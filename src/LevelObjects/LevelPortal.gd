extends Area2D
export var NextLevelPath = ""
func _on_LevelPortal_body_entered(body):
	var name = body.get_name()
	if name == "Player":
		get_tree().change_scene(NextLevelPath)
	print("PORTAAALLLL!!!")
