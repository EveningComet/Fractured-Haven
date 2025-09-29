## Displays a clickable party member.
class_name PartyMemberClickableButton extends Button

var _monitored: Actor = null

func set_party_member(new_pm: Actor) -> void:
	if _monitored != null:
		_monitored.combatant.stats.stat_changed.disconnect(_on_stats_changed)
	_monitored = new_pm
	_monitored.combatant.stats.stat_changed.connect(_on_stats_changed)
	_on_stats_changed(_monitored.combatant.stats)

func _on_stats_changed(stats: CharacterStats) -> void:
	pass
