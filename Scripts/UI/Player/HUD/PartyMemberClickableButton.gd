## Displays a clickable party member.
class_name PartyMemberClickableButton extends Button

@export var hp_bar: BarDisplayer = null
@export var sp_bar: BarDisplayer = null
var _monitored: Actor = null

func set_party_member(new_pm: Actor) -> void:
	if _monitored != null:
		_monitored.combatant.character_data.stats.stat_changed.disconnect(_on_stats_changed)
	_monitored = new_pm
	_monitored.combatant.character_data.stats.stat_changed.connect(_on_stats_changed)
	_on_stats_changed(_monitored.combatant.character_data.stats)

func _on_stats_changed(stats: CharacterStats) -> void:
	hp_bar.update_display(stats.curr_hp, stats.max_hp)
