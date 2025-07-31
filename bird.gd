extends CharacterBody2D

# Speed variables
@export var speed: float = 300.0
@export var ascent_velocity: float = 1000.0
@export var gravity_division_factor: float = 2.0

# Flight variables
@export var flight_time_limit: float = 4.0
@export var flight_restore: float = 0.15
@export var flight_drain_factor: float = 3.0
@onready var curr_flight_time: float = flight_time_limit
@onready var is_airborne: bool = false


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += (get_gravity() / gravity_division_factor) * delta
	else:
		is_airborne = false
		curr_flight_time = min(curr_flight_time + flight_restore, flight_time_limit)
		
	if Input.is_action_pressed("jump") && curr_flight_time > 0:
		is_airborne = true
		curr_flight_time -= flight_drain_factor * delta
		velocity.y += -ascent_velocity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
