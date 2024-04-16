extends Node

enum SceneKey {
	MAIN_MENU,
	DEBUG,
	TEST
}

var SceneData = {
	SceneKey.DEBUG: {
		title = "DebugMenu",
		path = "res://scenes/levels/debug/DebugLevel.tscn",
		scene = load("res://scenes/levels/debug/DebugLevel.tscn"),
		isLoaded = true
		},
	SceneKey.MAIN_MENU: {
		title = "MainMenu",
		path = "res://scenes/menus/main_menu/main_menu.tscn",
		scene = load("res://scenes/menus/main_menu/main_menu.tscn"),
		isLoaded = true
		},
	SceneKey.TEST: {
		title = "Test level",
		path = "res://scenes/levels/test/test_scene.tscn",
		scene = load("res://scenes/levels/test/test_scene.tscn"),
		isLoaded = true
		},
}
