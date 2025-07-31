extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 400.0
const GRAVITY = 980

var player_normal_vector
var rotation_direction = 0

func _ready() -> void:
	player_normal_vector = Vector2.UP


func _physics_process(delta: float) -> void:
	
	var ground_normal_vector = $RayCast2D.get_collision_normal()
	var rotation_change = player_normal_vector.angle_to(ground_normal_vector)
	rotation_direction += rotation_change
	rotation = rotation_direction
	
	set_up_direction(ground_normal_vector)
	
	# Handle gravity
	if not is_on_floor():
		#print("Above ground")
		velocity += -ground_normal_vector * GRAVITY * delta
	
	if Input.is_action_just_pressed("jump"):
		#print("Jump action received")
		#print(player_normal_vector * JUMP_VELOCITY)
		velocity = player_normal_vector * JUMP_VELOCITY
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity = transform.x * direction * SPEED
	
	print(is_on_floor())
	print(velocity)
	move_and_slide()
	
	player_normal_vector = ground_normal_vector
	
