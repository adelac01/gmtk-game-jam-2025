extends CharacterBody2D


@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = 400.0
@export var GRAVITY: float = 980

var player_normal_vector: Vector2
var velocity_drop: Vector2

var is_airborne: bool

func _ready() -> void:
	player_normal_vector = Vector2.UP
	velocity_drop = Vector2.ZERO
	is_airborne = false


func _physics_process(delta: float) -> void:
	
	var ground_normal_vector = $RayCast2D.get_collision_normal()
	var rotation_change = player_normal_vector.angle_to(ground_normal_vector)
	rotation += rotation_change
	
	set_up_direction(ground_normal_vector)
	velocity = velocity_drop
	
	if not is_on_floor():
		is_airborne = true
		velocity = velocity.rotated(rotation_change) + (-ground_normal_vector * GRAVITY * delta)
	else:
		is_airborne = false
		velocity = -ground_normal_vector * GRAVITY
	
	if Input.is_action_just_pressed("jump") && !is_airborne:
		is_airborne = true
		velocity = ground_normal_vector * JUMP_VELOCITY
	
	velocity_drop = velocity
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity = velocity_drop + (transform.x * direction * SPEED)
		print(velocity_drop)
		print(transform.x * direction * SPEED)
		#print(velocity)
	else:
		velocity = velocity_drop
		
	
	#print(velocity)

	player_normal_vector = ground_normal_vector
	move_and_slide()
