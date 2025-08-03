extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("water"):
		get_tree().change_scene_to_file("res://levels/ocean/Fish Level.tscn")
		
	if Input.is_action_just_pressed("grass"):
		get_tree().change_scene_to_file("res://levels/grassy_field/GrassyField.tscn")
		
	if Input.is_action_just_pressed("city"):
		get_tree().change_scene_to_file("res://levels/city/city.tscn")
