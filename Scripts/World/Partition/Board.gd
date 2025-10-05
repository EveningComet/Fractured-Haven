## Stores all the [Partition]s under it.
class_name Board extends Node3D

var partitions: Array[Partition] = []

func _ready() -> void:
	setup_partitions_list()

func setup_partitions_list() -> void:
	for c in get_children():
		partitions.append(c)
