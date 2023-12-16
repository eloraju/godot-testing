extends CharacterBody2D

@onready var at := $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine

@export var move_speed: float = 200

func _ready():
	at.active = true;

func update_facing_direction():
	if(velocity.x > 0):
		$PlayerSprite.flip_h = false
	elif(velocity.x < 0):
		$PlayerSprite.flip_h = true

func update_animation_params():
	at.set("parameters/default/blend_position", velocity.normalized().length())
	($Label as Label).text = "Blend: " + str(at.get("parameters/default/blend_position"))

func _physics_process(delta):
	var move_dir = Input.get_vector("left", "right", "up", "down")
	
	if move_dir.length() > 0 && stateMachine.can_act():
		velocity = move_dir * move_speed
	else:
		velocity = velocity.normalized() * move_toward(velocity.length(),0,move_speed)
	
	update_animation_params()
	update_facing_direction()
	move_and_slide()
	get_tree().call_group("Enemies", "_player_position_update", position)
