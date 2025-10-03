## Handles things related to the player's hud.
class_name PlayerHUD extends CanvasLayer

@export var _input_controller:     PlayerInputController
@export var _selection_controller: SelectionController

@export var _skill_bar:       Skillbar
@export var _party_displayer: PartyDisplayer

func _ready() -> void:
	_skill_bar.setup(_input_controller, _selection_controller)
	_party_displayer.setup(_selection_controller)
