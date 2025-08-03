extends CharacterBody2D


# Speed variables
@export var speed: float = 500.0
@export var ascent_acceleration: float = -1750.0
@export var gravity_factor: float = 0.9

#Limits
@export var flight_time_limit: float = 4.0
@export var max_up_velocity: float = -1000.0
@export var max_down_velocity: float = 600.0

# Flight variables
@export var flight_restore: float = 0.15
@export var flight_drain_factor: float = 1.25
@onready var curr_flight_time: float = flight_time_limit

# Status variables
@onready var is_moving: bool = false
@onready var is_airborne: bool = false

@onready var _animation = $AnimatedSprite2D;

func _physics_process(delta: float) -> void:
	
	is_moving = false
	
	# Get the input direction and handle the movement/deceleration.
	var direction: int = Input.get_axis("left", "right")
	if direction:
		is_moving = true
		if direction == 1:
			_animation.flip_h = false
		else:
			_animation.flip_h = true
		if !is_airborne:
			_animation.play("walking")
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if not is_on_floor():
		is_airborne = true
		is_moving = true
		_animation.play("flight")
		velocity.y += gravity_factor * get_gravity().y * delta
		
		# Keep velocity within limits
		velocity.y = min(velocity.y, max_down_velocity)
		velocity.y = max(velocity.y, max_up_velocity)
	else:
		is_airborne = false
		curr_flight_time = min(curr_flight_time + flight_restore, flight_time_limit)
		
	if Input.is_action_pressed("jump") && curr_flight_time > 0:
		is_moving = true
		curr_flight_time -= flight_drain_factor * delta
		velocity.y += ascent_acceleration * delta
		
	if !is_moving: 
		_animation.play("walking")
		_animation.stop()

	print(is_moving)
	move_and_slide()
