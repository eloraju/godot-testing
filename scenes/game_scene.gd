extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var reset = Input.is_action_just_pressed("reset")
	if reset:
		get_tree().reload_current_scene()
