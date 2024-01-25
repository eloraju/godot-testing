extends State
class_name Attack

@export var return_state: State
@export var hitbox: Area2D
@export var anim_name: String;
@export var combo_attack: Attack;


var will_combo := false;

func _ready():
	hitbox.monitoring = false
	hitbox.connect("area_entered", Callable(self, "on_attack_hitbox_area_entered"))

func _state_input(input: InputEvent):
	if(input.is_action_pressed("attack") && combo_attack && !will_combo):
		will_combo = true

func _state_on_enter():
	anim["parameters/playback"].travel(anim_name)
	
func _state_on_exit():
	will_combo = false

func _state_anim_finished(last_anim_name:String):
	print("State: ", name, " --- node anim: ", anim_name, " --- last anim: ", last_anim_name)
	if last_anim_name == anim_name && will_combo:
		next_state = combo_attack
	else:
		next_state = return_state


func _on_attack_hitbox_area_entered(area):
	print(area.name, " hit!")
