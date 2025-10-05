## Stores all the [Partition]s under it.
class_name Board extends Node3D

var partitions: Array[Partition] = []

func _ready() -> void:
	setup_partitions_list()

func setup_partitions_list() -> void:
	for c in get_children():
		partitions.append(c)

## Search for an amount of neighbors, using the starting [Partition], and the depth.
static func depth_search(visited: Array[Partition], start: Partition, depth: int = 1) -> Array[Partition]:
	visited.append(start)
	if depth == 0:
		return visited
	for c: Connection in start.connections:
		var neighbor: Partition = c.partition
		if visited.has(neighbor) == false:
			depth_search(visited, neighbor, depth - 1)
	return visited
