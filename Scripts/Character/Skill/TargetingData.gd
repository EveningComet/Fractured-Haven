## Wrapper or container for things [SkillData] will need to do its job.
class_name TargetingData extends Resource

var user: Actor
var partitions: Array[Partition] = []
var units: Array[Actor] = []

func _init(unit: Actor = null, ps: Array[Partition] = [], us: Array[Actor] = []) -> void:
	user       = unit
	partitions = ps
	units      = us
