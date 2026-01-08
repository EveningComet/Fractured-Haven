## Controls stuff related to the Homebase scene's main menu.
class_name HomebaseMainMenu extends Node

## The scene that stores the map where battles take place.
@export_file("*.tscn") var _battle_scene: String

@export_category("Buttons")
## The button player's select to go to the mission's menu.
@export var _mission_button:     Button
@export var _party_setup_button: Button
@export var _activities_button:  Button
# TODO: Recruit/Spawn button.

@export_category("Homebase Components")
@export var _party_setup_menu: CanvasLayer
@export var _activities_menu:  CanvasLayer

func _ready() -> void:
	_mission_button.pressed.connect(_on_start_mission_pressed)
	_party_setup_button.pressed.connect(_on_party_setup_button_pressed)
	_activities_button.pressed.connect(_on_activities_button_pressed)

func _on_start_mission_pressed() -> void:
	_party_setup_menu.hide()
	SceneManager.change_scene(_battle_scene)

func _on_party_setup_button_pressed() -> void:
	_party_setup_menu.show()
	_activities_menu.hide()

func _on_activities_button_pressed() -> void:
	_party_setup_menu.hide()
	_activities_menu.show()
