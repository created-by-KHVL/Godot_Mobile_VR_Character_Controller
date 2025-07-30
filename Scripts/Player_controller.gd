extends CharacterBody3D

@export var xr_origin: XROrigin3D 
var player_camera: Camera3D
@export var movement_speed: float = 4


const JUMP_VELOCITY = 4.5

var start_movement_speed: float
var movement_acceleration: int = 4

var is_jumping: bool = false
var is_running: bool = false

var input_direction: Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	start_movement_speed = movement_speed
	player_camera = xr_origin.get_child(0)

func _process(_delta):
	if Input.is_action_pressed("run") and abs(input_direction) > Vector2.ZERO:
		is_running = true
	else:
		is_running = false
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta # add the gravity
	else:
		# Move player
		player_movement()
		is_jumping = false
		
		# Handle jump
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			velocity.y = JUMP_VELOCITY
	
	# Player rotation
	player_rotation()
	
	move_and_slide()

func player_movement():
	if is_running:
		movement_speed = start_movement_speed + movement_acceleration # player speed increase
	else:
		movement_speed = start_movement_speed # set speed back to start speed
	# Get input vector
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if direction:
		velocity.x = direction.x * movement_speed
		velocity.z = direction.z * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.z = move_toward(velocity.z, 0, movement_speed)

func player_rotation():
	# Gamepad input
	var gamepad_sensitivity: float = 2
	# Get input vector
	var controller_view_rotation: Vector2 = Input.get_vector("look_up", "look_down", "look_left", "look_right")
	
	# Only camera rotation along the X-axis
	xr_origin.rotation_degrees.x -= controller_view_rotation.x * gamepad_sensitivity 
	# Player rotation along the Y-axis
	rotation_degrees.y -= controller_view_rotation.y * gamepad_sensitivity 
	
	# Clamp player_camera rotation along the Z-axis
	xr_origin.rotation.z = clamp(xr_origin.rotation.z, -60.0, 60.0)
	# Clamp XR Origin rotation along the X-axis
	xr_origin.rotation.x = clamp(xr_origin.rotation.x, deg_to_rad(-90.0), deg_to_rad(90.0))
