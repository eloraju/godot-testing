extends Label

@export var stateMachine: CharacterStateMachine
@export var player: CharacterBody2D


var last_animation_started: String = "none"
var last_animation_ended: String = "none"
var nextState = "Not set"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stateMachine.current_state.next_state != null:
		nextState = stateMachine.current_state.next_state.name
	text = "State: " + stateMachine.current_state.name + "\n" \
	+ "Next state (persisted): " + nextState + "\n" \
	+ "Last non-zero move vector: " + str(player.last_move_vec) + "\n" \
	+ "Last started animation: " + last_animation_started + "\n" \
	+ "Last ended animation: " + last_animation_ended + "\n" 
	pass


func _on_animation_tree_animation_player_changed():
	pass # Replace with function body.


func _on_animation_tree_animation_finished(anim_name):
	last_animation_ended = anim_name


func _on_animation_tree_animation_started(anim_name):
		last_animation_started = anim_name
