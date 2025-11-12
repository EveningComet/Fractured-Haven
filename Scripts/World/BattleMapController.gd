## Controls things related to the battle map.
class_name BattleMapController extends Node

@onready var _actor_template = preload("res://Scenes/Characters/Templates/Actor Template.tscn")

var curr_mission: MissionData = preload("res://Game Data/Missions/Test Mission.tres")
var curr_map: Node3D

func _ready() -> void:
	initialize_mission()

func initialize_mission() -> void:
	spawn_map()
	spawn_units()

func spawn_map() -> void:
	curr_map = curr_mission.map.instantiate()
	add_child(curr_map)

func spawn_units() -> void:
	# Spawn the player's characters.
	PlayerPartyController.party_as_actors.clear()
	for pm: CharacterData in PlayerPartyController.active_party:
		var actor: Actor = _actor_template.instantiate()
		actor.faction_owner.faction = FactionOwner.Faction.Player
		actor.set_character_data(pm)
		curr_map.add_child.call_deferred(actor)
		actor.global_position = Vector3(1, 1, 0.0)
		PlayerPartyController.party_as_actors.append(actor)
	
	# Now spawn the enemies and everything else
	for ms: MissionSpawnable in curr_mission.spawnables:
		var character_data: CharacterData = ms.character_data
		if character_data != null:
			var actor: Actor = _actor_template.instantiate()
			actor.faction_owner.faction = FactionOwner.Faction.Enemy
			actor.set_character_data(character_data)
			curr_map.add_child(actor)
			actor.global_position = ms.location_to_spawn
			var simple_AI: SimpleAI = SimpleAI.new()
			actor.add_child(simple_AI)
			simple_AI.initialize()
			actor.global_rotation = ms.spawn_rotation
