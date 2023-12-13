extends State

@export var move_speed: float = 200
@export var roll_state: State
@export var roll_animation: String = "roll"


func state_input(input: InputEvent):
	var roll = Input.is_action_just_pressed("roll")
	if roll && character.velocity.length() > 0:
		anim["parameters/playback"].travel("roll")
		next_state = roll_state
