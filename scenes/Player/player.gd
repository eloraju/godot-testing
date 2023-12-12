extends CharacterBody2D


@export var SPEED = 300.0

@onready var ap := $AnimationPlayer

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = direction.normalized() * SPEED

	if(velocity.x > 0):
		scale.x = scale.y * 1
	elif(velocity.x < 0):
		scale.x = scale.y * -1
		ap.play("idle")
	
	if(velocity.length() > 0):
		if(ap.current_animation != "move"):
			ap.play("move")
		elif(ap.current_animation != "idle"):
			ap.play("idle")
	
	move_and_slide()
