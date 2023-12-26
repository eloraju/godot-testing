extends State

@export var return_state: State
@export var hitbox: Area2D

var willCombo:bool = false

func _ready():
	hitbox.monitoring = false

func _state_input(input: InputEvent):
	if(input.is_action_pressed("attack")):
		willCombo = true
		anim["parameters/playback"].travel("attack_2")

func _state_on_enter():
	anim["parameters/playback"].travel("attack_1")
	
func _state_on_exit():
	willCombo = false


func _state_process(delta: float):
	pass

func _state_physics_process(delta: float):
	pass


func _on_animation_tree_animation_finished(anim_name:String):
	if (anim_name == "attack_1" && !willCombo) || anim_name == "attack_2":
		next_state = return_state


func _on_attack_hitbox_body_entered(body):
	print(body.name, " hit!")


func _on_attack_hitbox_area_entered(area):
	print(area.name, " hit!")
