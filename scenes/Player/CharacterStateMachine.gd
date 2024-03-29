extends Node
class_name CharacterStateMachine

@export var current_state: State
@export var character: CharacterBody2D
@export var animation_tree: AnimationTree

var states: Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			# Set states up here!
			child.character = character
			child.anim = animation_tree
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func can_act() -> bool:
	return current_state.can_act

func _process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	
	current_state._state_process(delta)
	
func _physics_process(delta):
	current_state._state_physics_process(delta)

func switch_states(new_state: State):
	if(current_state != null):
		current_state._state_on_exit()
		current_state.next_state = null
	
	current_state = new_state
	current_state._state_on_enter()

func _input(event: InputEvent):
	current_state._state_input(event)


func _on_animation_tree_animation_finished(anim_name):
	current_state._state_anim_finished(anim_name)
