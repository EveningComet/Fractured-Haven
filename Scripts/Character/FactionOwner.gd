## A component that helps with telling what side a character belongs to.
class_name FactionOwner extends Node

enum Faction {
	Player,
	Enemy
}

@export var faction: Faction = Faction.Player

func is_on_same_team(other: FactionOwner) -> bool:
	return faction == other.faction
