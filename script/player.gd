extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -350.0
var direction
@export var controls: Resource = null
var Bullet = preload("res://scenes/bullet.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed(controls.jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed(controls.shoot):
		shoot()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = Input.get_axis(controls.move_left, controls.move_right)		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
