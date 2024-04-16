extends Node
class_name SceneManager

@onready var current_scene: Node2D = $CurrentScene
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.switch_scene.connect(_on_switch_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_switch_scene(sceneKey: SceneData.SceneKey):
	var new_scene_data = SceneData.SceneData[sceneKey]
	var new_scene: Node
	if new_scene_data.isLoaded:
		new_scene = new_scene_data.scene.instantiate()
	else:
		var packed_scene = load(new_scene_data.path)
		new_scene = packed_scene.instantiate()
		
	if new_scene:
		for active_scene in current_scene.get_children():
			active_scene.queue_free()
			
		current_scene.add_child(new_scene)
