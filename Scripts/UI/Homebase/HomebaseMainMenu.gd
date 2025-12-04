## Controls stuff related to the Homebase scene's main menu.
class_name HomebaseMainMenu extends Node

## The scene that stores the map where battles take place.
@export_file("*.tscn") var _battle_scene: String

@export_category("Buttons")
## The button player's select to go to the mission's menu.
@export var _mission_button:     Button
@export var _party_setup_button: Button
@export var _activities_button:  Button

func _ready() -> void:
	_mission_button.pressed.connect(_on_start_mission_pressed)
	_test_stats_growth()

func _on_start_mission_pressed() -> void:
	SceneManager.change_scene(_battle_scene)

## A method used for simulating the mechanic used for boosting stats outside of
## level ups.
func _test_stats_growth() -> void:
	var test_cd: CharacterData = PlayerPartyController.roster[0]
	var max_hp  := test_cd.stats.max_hp
	if OS.is_debug_build() == true:
		print("HomebaseMainMenu :: Test cd's hp before boosting: %s" % [max_hp])
	test_cd.stats.raise_base_value(StatHelper.StatTypes.MaxHP, 10.0)
	test_cd.stats.full_restore()
	max_hp = test_cd.stats.max_hp
	if OS.is_debug_build() == true:
		print("HomebaseMainMenu :: Test cd's hp after boosting: %s" % [max_hp])
