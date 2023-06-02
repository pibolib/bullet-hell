extends AudioStreamPlayer

var is_playing: bool = false
@export_range(0.5, 5) var bgm_fade_out_seconds = 1.25

func play_stream(audio_stream: AudioStreamOggVorbis):
	if is_playing:
		await stop_stream()
	volume_db = 0
	stream = audio_stream
	is_playing = true
	play()

func stop_stream():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "volume_db", -80, bgm_fade_out_seconds)
	tween.tween_callback(stop)
	await tween.finished
	is_playing = false
