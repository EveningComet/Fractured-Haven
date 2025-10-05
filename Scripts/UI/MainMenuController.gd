## Manages the main menu.
class_name MainMenuController extends Node

@export var start_game_button: Button
@export var quit_button:            Button

@export var button_holder: Container

## Reference to the scene storing the testing game.
@export_file("*.tscn") var _start_test_game: String

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game_button.pressed.connect(_on_start_game_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Allow gamepad controls
	button_holder.get_child(0).grab_focus()

func _on_start_game_pressed() -> void:
	SceneManager.change_scene(_start_test_game)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
