extends State

@export var roll_animation: String = "roll"
@export var move_state: State
@export var roll_speed: float = 300

var roll_dir: Vector2 = Vector2.ZERO

func on_exit():
	roll_dir = Vector2.ZERO

func on_enter():
	if roll_dir == Vector2.ZERO:
		roll_dir = character.velocity

	character.velocity = roll_dir.normalized() * roll_speed

func _on_animation_tree_animation_finished(anim_name):
	print("Animation: "+anim_name+" done")
	if anim_name == roll_animation:
		next_state = move_state



func _on_animation_tree_animation_started(anim_name):
	print("Animation: "+anim_name+" STARTED")
