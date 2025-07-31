extends CharacterBody2D

@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = 400.0
@export var GRAVITY: float = 980
@export var ROTATION_SPEED: float = 90

@onready var player_normal_vector: Vector2 = Vector2.UP
@onready var velocity_drop: Vector2 = get_gravity()
@onready var is_airborne: bool = false
#@onready var prev_rotation: float = 0


func _physics_process(delta: float) -> void:
	
	var ground_normal_vector: Vector2 = $RayCast2D.get_collision_normal()
	var rotation_change: float = player_normal_vector.angle_to(ground_normal_vector)
	rotation += rotation_change
	#rotation = lerp_angle(rotation, rotation + rotation_change, 0.15)
	#prev_rotation = rotation
	
	set_up_direction(ground_normal_vector)
	
	if not is_on_floor():
		is_airborne = true
		
		# Use the previous velocity but transformed 
		velocity = velocity_drop.rotated(rotation_change) + (-ground_normal_vector * GRAVITY * delta)
	else:
		is_airborne = false
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("jump") && !is_airborne:
		is_airborne = true
		velocity = ground_normal_vector * JUMP_VELOCITY
	
	velocity_drop = velocity
	
	var direction: int = Input.get_axis("left", "right")
	if direction:
		velocity = velocity_drop + (transform.x * direction * SPEED)
	else:
		velocity = velocity_drop

	player_normal_vector = ground_normal_vector
	move_and_slide()
