extends Area2D

signal player_dead

@onready var timer: Timer = $Timer

func _on_body_entered(body):
	print("1")
	player_dead.emit()
	timer.start()

func _on_timer_timeout(): 
	get_tree().reload_current_scene()
