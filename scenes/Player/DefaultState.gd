extends State

@export var move_speed: float = 200
@export var roll_state: State
@export var roll_animation: String = "roll"


func state_input(input: InputEvent):
	var roll = Input.is_action_just_pressed("roll")
	# If the character has no velocity, the roll will just happen 
	# in place. Not fun. Gotta figure out how to pass the last non-zero
	# vector to the roll thingy
	if roll && character.velocity.length() > 0:
		anim["parameters/playback"].travel("roll")
		next_state = roll_state
