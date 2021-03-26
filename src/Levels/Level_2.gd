extends Node2D

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	pass
