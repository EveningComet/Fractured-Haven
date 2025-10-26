## Stores things for missions.
class_name MissionData extends Resource

## The location where the mission will take place.
@export var map: PackedScene

## How can the player win or fail?
@export var victory_condition: VictoryCondition # TODO: Multiple/bonus objectives?
