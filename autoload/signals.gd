extends Node

# Debug signals
signal debug_toggle
signal debug_reset

# Global signals
signal pause_pressed

# Non sorted scenes
signal switch_scene(new_scene_key: SceneData.SceneKey)

