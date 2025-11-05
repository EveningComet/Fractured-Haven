## Stores all the [Partition]s under it.
class_name Board extends Node3D

@export var unit_holder_node: Node

## Prefab of the [Actor] object.
@export var actor_template: PackedScene

var partitions: Array[Partition] = []

func _ready() -> void:
	setup_partitions_list()
	spawn_player_party()

func setup_partitions_list() -> void:
	for c in get_children():
		partitions.append(c)

func spawn_player_party() -> void:
	PlayerPartyController.party_as_actors.clear()
	for pm: CharacterData in PlayerPartyController.active_party:
		var actor: Actor = actor_template.instantiate()
		actor.set_character_data(pm)
		unit_holder_node.add_child.call_deferred(actor)
		actor.global_position = Vector3(1, 1, 0.0)
		PlayerPartyController.party_as_actors.append(actor)

## Search for an amount of neighbors, using the starting [Partition], and the depth.
## This method uses depth limited search.
static func depth_search(
	visited: Array[Partition],
	start: Partition,
	depth: int = 1
) -> Array[Partition]:
	visited.append(start)
	if depth == 0:
		return visited
	for c: Connection in start.connections:
		var neighbor: Partition = c.partition
		if visited.has(neighbor) == false:
			depth_search(visited, neighbor, depth - 1)
	return visited
