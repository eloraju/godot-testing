extends Node

enum SceneKey {
	MAIN_MENU,
	DEBUG
}

var SceneData = {
	SceneKey.DEBUG: {
		path = "res://scenes/levels/debug/DebugLevel.tscn",
		scene = load("res://scenes/levels/debug/DebugLevel.tscn"),
		isLoaded = true
		},
	SceneKey.MAIN_MENU: {
		path = "res://scenes/main_menu/main_menu.tscn",
		scene = load("res://scenes/main_menu/main_menu.tscn"),
		isLoaded = true
		},
}
