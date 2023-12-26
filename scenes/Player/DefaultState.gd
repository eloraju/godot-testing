extends State

@export var move_speed: float = 200
@export var roll_state: State
@export var attack_state: State


func _state_input(input: InputEvent):
	var roll = Input.is_action_just_pressed("roll")
	var attack = Input.is_action_just_pressed("attack")

	if roll:
		next_state = roll_state
	elif attack:
		next_state = attack_state
