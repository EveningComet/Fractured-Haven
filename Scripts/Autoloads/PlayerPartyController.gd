extends Node

signal party_changed(party: Array[Actor])

## The maximum number of party members the player can have in their party, not
## including summons.
const MAX_PMS_IN_ACTIVE_PARTY: int = 6

# TODO: Replace [Actor] with the [CharacterData] type.
## The player's current party.
var active_party: Array[Actor] = []

## Go through the [active_party] and return characters that have hp > 0.
func get_valid_party_members():
	var valid_pms: Array[Actor] = []
	for pm: Actor in active_party:
		if pm.combatant.stats.curr_hp > 0:
			valid_pms.append(pm)
	return valid_pms
	
func add_to_party(new_pm: Actor) -> void:
	active_party.append( new_pm )
	party_changed.emit(active_party)

func is_party_fightable() -> bool:
	for pm: Actor in active_party:
		if pm.combatant.character_data.stats.curr_hp > 0:
			return true
	return false

func give_experience_points(xp_to_give: int) -> void:
	# TODO: If the party member is a lower level than a defeated enemy, give them more xp. However,
	# don't give less experience if the pm is a higher level, cause that's omega gay.
	for pm: Actor in active_party:
		pm.combatant.character_data.char_level.gain_experience(xp_to_give)
	# TODO: What about giving experience points to characters not actively in the party?
