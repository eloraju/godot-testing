extends Button


func _pressed():
	Signals.switch_scene.emit(SceneData.SceneKey.DEBUG)
