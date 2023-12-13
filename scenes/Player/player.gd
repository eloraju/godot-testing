extends CharacterBody2D

@export var SPEED = 300.0

@onready var ap := $AnimationPlayer

func move(direction: Vector2):
	velocity = direction.normalized() * SPEED

	if(velocity.x > 0):
		$PlayerSprite.scale.x = scale.y * 1
	elif(velocity.x < 0):
		$PlayerSprite.scale.x = scale.y * -1

	if(velocity.abs().length() > 0):
		ap.play("move")
	elif(velocity.length() == 0):
		ap.play("idle")
	
	move_and_slide()
	get_tree().call_group("Enemies", "player_position_update", position)

func _physics_process(delta):
	move(Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	))
