extends AudioStreamPlayer

var is_playing: bool = false
var next_stream: AudioStreamOggVorbis #currently unused

func _ready():
	pass

func play_stream(audio_stream: AudioStreamOggVorbis):
	stream = audio_stream
	play()
