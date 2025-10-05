@abstract
## Defines where a [SkillData] object may get targets.
class_name TargetingRange extends Resource

## For those that need it, how far away, in zones, is the skill able to reach?
@export var range_in_partitions: int = 1
# TODO: Variable/function for getting the entire map?
# TODO: Horizontal & vertical range?

func get_targets_in_range(start: Partition) -> Array[Actor]:
	return []

func get_partitions_in_range(start: Partition) -> Array[Partition]:
	return [start]
