## Display's usable skills to the player.
class_name Skillbar extends PanelContainer

@export var skill_button_prefab: PackedScene

## Holds the displayed skills.
@export var _slot_container: Container

var _selection_controller: SelectionController   = null
var _input_controller:     PlayerInputController = null

func _ready() -> void:
	_clear()
	hide()

func setup(ic: PlayerInputController, sc: SelectionController) -> void:
	_input_controller     = ic
	_selection_controller = sc
	_selection_controller.pawns_selected.connect(_on_characters_selected)

func _clear() -> void:
	for c in _slot_container.get_children():
		c.queue_free()

## When the player has selected their unit(s), display the relevant skills.
func _on_characters_selected(selected: Array[Actor]) -> void:
	_clear()
	if OS.is_debug_build() == true:
		print("Skillbar :: Detected selected characters. {%s}" % [selected])
	if selected.size() < 1:
		hide()
		return
	
	for unit: Actor in selected:
		var skills: Array[SkillData] = unit.combatant.character_data.skills
		for s: SkillData in skills:
			var skill_slot: Skillslot = skill_button_prefab.instantiate()
			skill_slot.setup(unit, s)
			_slot_container.add_child(skill_slot)
			skill_slot.pressed.connect(_on_skill_button_pressed.bind(unit, s))
	show()

func _on_skill_button_pressed(user: Actor, skill: SkillData) -> void:
	if OS.is_debug_build() == true:
		print("Skillbar :: Noticed that the player is trying to perform a skill.")
