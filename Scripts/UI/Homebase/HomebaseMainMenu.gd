## Controls stuff related to the Homebase scene's main menu.
class_name HomebaseMainMenu extends Node

@export_category("Battle Related UI")
## The scene that stores the map where battles take place.
@export_file("*.tscn") var _battle_scene: String

@export var _mission_button: Button

func _ready() -> void:
	_mission_button.pressed.connect(_on_start_mission_pressed)

func _on_start_mission_pressed() -> void:
	SceneManager.change_scene(_battle_scene)
