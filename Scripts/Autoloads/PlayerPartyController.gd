## Responsible for managing things related to the player's characters.
extends Node
# TODO: Rename to PlayerRosterController.

signal party_changed(party: Array[Actor])

## The maximum number of party members the player can have in their party, not
## including summons.
const MAX_PMS_IN_ACTIVE_PARTY: int = 6

## Object storing all of the player's characters.
var roster: Array[CharacterData] = []

## The player's current party.
var active_party: Array[CharacterData] = []

var party_as_actors: Array[Actor] = []

func _ready() -> void:
	_load_testing_party()
	_load_testing_roster()

## Go through the [active_party] and return characters that have hp > 0.
func get_valid_party_members():
	var valid_pms: Array[Actor] = []
	for pm: CharacterData in active_party:
		if pm.stats.curr_hp > 0:
			valid_pms.append(pm)
	return valid_pms
	
func add_to_party(new_pm: CharacterData) -> void:
	active_party.append( new_pm )
	party_changed.emit(active_party)

func remove_from_party(pm_to_remove: CharacterData) -> void:
	pass

func is_party_fightable() -> bool:
	for pm: CharacterData in active_party:
		if pm.stats.curr_hp > 0:
			return true
	return false

func give_experience_points(xp_to_give: int) -> void:
	# TODO: If the party member is a lower level than a defeated enemy, give them more xp. However,
	# don't give less experience if the pm is a higher level, cause that's omega gay.
	for pm: CharacterData in active_party:
		pm.char_level.gain_experience(xp_to_give)
	# TODO: What about giving experience points to characters not actively in the party?

func fully_restore_party() -> void:
	for pm: CharacterData in active_party:
		pm.stats.full_restore()

func _load_testing_party() -> void:
	var data_path: String = "res://Game Data/Testing Party"
	var dir = DirAccess.open( data_path )
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres") == true:
				var cd: CharacterData = load(
					data_path + "/" + file_name
				)
				active_party.append( cd )
				roster.append( cd )
			file_name = dir.get_next()
		dir.list_dir_end()

func _load_testing_roster() -> void:
	var data_path: String = "res://Game Data/Testing Roster"
	var dir = DirAccess.open( data_path )
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres") == true:
				var cd: CharacterData = load(
					data_path + "/" + file_name
				)
				roster.append( cd )
			file_name = dir.get_next()
		dir.list_dir_end()
