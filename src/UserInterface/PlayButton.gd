tool
extends TextureButton
export(String, FILE) var next_scene_path: = ""


func _on_button_up():
	get_tree().change_scene(next_scene_path)
	get_tree().paused = false
	

func _get_configuration_warning()-> String:
	return "next_scene_path  must be set for the button to work" if next_scene_path == "" else ""
	
