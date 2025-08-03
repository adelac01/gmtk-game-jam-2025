extends CharacterBody2D


@export var speed = 500.0
@export var jump_velocity = -625.0

@onready var _animation = $AnimatedSprite2D

var is_moving: bool
var is_airborne: bool = false
var is_dead: bool = false

func _physics_process(delta: float) -> void:
	
	if is_dead:
		return
	
	is_moving = false

	var direction: int = Input.get_axis("left", "right")
	if direction:
		is_moving = true
		if direction == 1:
			_animation.flip_h = false
		else:
			_animation.flip_h = true
		if !is_airborne:
			_animation.play("walk")
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if not is_on_floor():
		is_airborne = true
		is_moving = true
		velocity += get_gravity() * delta
	else:
		is_airborne = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_airborne = true
		is_moving = true
		_animation.play("jump")
		velocity.y = jump_velocity
		
	# Use first frame of walk as standing image
	if !is_moving:
		_animation.play("walk")
		_animation.stop()

	move_and_slide()


func _on_killzones_player_dead() -> void:
	is_dead = true
	velocity = Vector2()
	visible = false
