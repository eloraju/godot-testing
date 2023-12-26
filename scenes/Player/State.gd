extends Node
class_name State

@export var can_act: bool = true

var character: CharacterBody2D
var anim: AnimationTree
var next_state: State


func _state_input(input: InputEvent):
	pass

func _state_on_enter():
	pass
	
func _state_on_exit():
	pass

func _state_process(delta: float):
	pass

func _state_physics_process(delta: float):
	pass
