extends State

@export var roll_animation: String = "roll"
@export var roll_speed: float = 500
@export var return_state: State

var roll_dir: Vector2 = Vector2.ZERO

func _state_on_exit():
	roll_dir = Vector2.ZERO

func _state_on_enter():
	if roll_dir == Vector2.ZERO:
		roll_dir = character.last_move_vec

	character.velocity = roll_dir.normalized() * roll_speed
	print("should travel to new animation")
	anim["parameters/playback"].travel("roll")


func _state_physics_process(delta):
	character.velocity = roll_dir.normalized() * roll_speed

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == roll_animation:
		next_state = return_state
