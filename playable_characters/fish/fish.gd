extends CharacterBody2D


const SPEED = 300.0
const ACCELERATION = 30

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("left", "right",)
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var directiony := Input.get_axis("up", "down",)
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_area_2_entered(body: Node2D) -> void:
	print("1")
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
