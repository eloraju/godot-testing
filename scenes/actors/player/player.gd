extends CharacterBody2D


const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	var move_dir = Input.get_vector("left", "right", "up", "down")
	if move_dir.length() > 0:
		velocity = move_dir * SPEED
	else:
		velocity = velocity.normalized() * move_toward(velocity.length(), 0, SPEED * 2)

	move_and_slide()
