## Stores things for missions.
class_name MissionData extends Resource

## The location where the mission will take place.
@export var map: PackedScene

@export var spawnables: Array[MissionSpawnable] = []

## How can the player win or fail?
@export var victory_condition: VictoryCondition # TODO: Multiple/bonus objectives?

@export_category("Completion")
@export var rewards:           Array[MissionReward] = []
@export var missions_unlocked: Array[MissionData]   = []
