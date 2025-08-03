extends Area2D


@onready var _timer: Timer = $Timer
@export var file_path: String;

func _on_body_entered(body):
	print("Entered Loading Zone")
	_timer.start()

func _on_timer_timeout(): 
	get_tree().change_scene_to_file(file_path)
