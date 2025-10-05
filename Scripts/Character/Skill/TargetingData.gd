## Wrapper or container for things [SkillData] will need to do its job.
class_name TargetingData extends Resource

var user: Actor
var partitions: Array[Partition] = []
var targets: Array[Actor] = []

func _init(unit: Actor = null, ps: Array[Partition] = [], ts: Array[Actor] = []) -> void:
	user       = unit
	partitions = ps
	targets    = ts
