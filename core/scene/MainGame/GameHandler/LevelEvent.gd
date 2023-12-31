extends Node
class_name LevelEvent

signal tag_condition_reached(tag)
signal control_tag_condition_reached

class Event:
	func _init() -> void:
		pass

class TimeWaitEvent:
	extends Event
	var time: float
	func _init(seconds: float) -> void:
		super()
		self.time = seconds

class ControlEvent:
	extends Event

class LevelEndEvent:
	extends Event

class EntitySpawnEvent:
	extends ControlEvent
	var entity_type: PackedScene
	var location: Vector2
	var attributes: Dictionary = {}
	var tag: String = ""
	var uses_control_tag = false
	func _init(entity: PackedScene, loc: Vector2, att: Dictionary = {}) -> void:
		super()
		self.entity_type = entity
		self.location = loc
		self.attributes = att
	func set_tag(tag_name: String) -> EntitySpawnEvent: #tag functionality (to be implemented in 103)
		self.tag = tag_name
		return self
	func set_control_tag() -> EntitySpawnEvent:
		self.uses_control_tag = true
		return self

class BackgroundScrollEvent:
	extends ControlEvent
	var position_to: float
	var time: float
	func _init(pos_to, t) -> void:
		super()
		self.position_to = pos_to
		self.time = t

class MusicPlayEvent:
	extends ControlEvent
	var bgm_track: AudioStreamOggVorbis
	func _init(track) -> void:
		super()
		self.bgm_track = track
		
class MusicStopEvent:
	extends ControlEvent
	func _init() -> void:
		super()

#class DialogueEvent

#class TagWaitEvent

class ControlTagWaitEvent:
	extends Event
	func _init(value: int) -> void:
		self.value = value
		super()

class Tag:
	var name: String
	var value: int
	var current_value: int = 0
	func _init(tag_name: String, tag_value: int) -> void:
		self.name = tag_name
		self.value = tag_value
	func set_value(val: int) -> Tag:
		self.value = val
		return self
	func set_current_value(val: int) -> Tag:
		self.current_value = val
		return self
	func increment_current_value() -> Tag:
		self.current_value += 1
		return self

var events: Array[Event]
var event_index: int = 0
@onready var event_timer := Timer.new()
var active_tags: Array[Tag] = []
var control_tag := Tag.new("Control",-1)

func _ready():
	event_timer.one_shot = true
	add_child(event_timer)
	define_level()
	start_event(events[0])

func _process(_delta):
	for tag in active_tags:
		if tag.current_value >= tag.value:
			tag_condition_reached.emit(tag.name)
			tag.set_value(-1)
	if control_tag.current_value >= control_tag.value:
		control_tag_condition_reached.emit()
		control_tag.set_value(-1)

#overload this
func define_level() -> void:
	pass

func start_event(event: Event) -> void:
	if event is TimeWaitEvent:
		event_timer.start(event.time)
		await event_timer.timeout
	elif event is EntitySpawnEvent:
		var new_entity = event.entity_type.instantiate()
		new_entity.position = event.location
		new_entity.attributes = event.attributes
		new_entity.uses_control_tag = event.uses_control_tag
		add_child(new_entity)
	elif event is ControlTagWaitEvent:
		control_tag.set_current_value(0).set_value(event.value)
		await control_tag_condition_reached
	elif event is BackgroundScrollEvent:
		var tween = get_tree().create_tween()
		tween.tween_property($Background, "position:y", event.position_to, event.time)
	elif event is MusicPlayEvent:
		BGMHandler.play_stream(event.bgm_track)
	elif event is MusicStopEvent:
		BGMHandler.stop_stream()
	event_index += 1
	if !(event is LevelEndEvent):
		start_event(events[event_index])

func time_wait(seconds: float) -> TimeWaitEvent:
	var event := TimeWaitEvent.new(seconds)
	events.append(event)
	return event

func control_tag_wait(value: int) -> ControlTagWaitEvent:
	var event := ControlTagWaitEvent.new(value)
	events.append(event)
	return event

func spawn_entity(type: PackedScene, location: Vector2, attributes: Dictionary = {}) -> EntitySpawnEvent:
	var event := EntitySpawnEvent.new(type, location, attributes)
	events.append(event)
	return event

func background_scroll(pos_to: float, time: float) -> BackgroundScrollEvent:
	var event := BackgroundScrollEvent.new(pos_to, time)
	events.append(event)
	return event

func play_bgm(stream: AudioStreamOggVorbis) -> MusicPlayEvent:
	var event := MusicPlayEvent.new(stream)
	events.append(event)
	return event

func level_end() -> LevelEndEvent:
	var event := LevelEndEvent.new()
	events.append(event)
	return event
