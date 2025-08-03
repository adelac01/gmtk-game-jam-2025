extends CharacterBody2D


signal died

@export var speed = 400.0
@export var jump_velocity = -625.0

@onready var _animation = $AnimatedSprite2D


func _physics_process(delta: float) -> void:

	var direction: int = Input.get_axis("left", "right")
	if direction:
		if direction == 1:
			_animation.flip_h = false
		else:
			_animation.flip_h = true
			
		_animation.play("walk")
		velocity.x = direction * speed
	else:
		_animation.stop()
		velocity.x = move_toward(velocity.x, 0, speed)

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
