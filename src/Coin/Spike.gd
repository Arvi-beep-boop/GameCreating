extends Area2D


func _on_body_entered(body):
	var name = body.get_name()
	if name == "Player":
		get_tree().reload_current_scene()
	print(name)
