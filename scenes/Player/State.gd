extends Node
class_name State

@export var can_act: bool = true

var character: CharacterBody2D
var anim: AnimationTree
var next_state: State

func state_input(input: InputEvent):
	pass

func on_enter():
	pass
	
func on_exit():
	pass

func state_process(delta: float):
	pass
