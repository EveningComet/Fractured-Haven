## Returns the user and their [Partition].
class_name SelfRange extends TargetingRange

func get_targetables_in_range(start: Partition = null, user: Actor = null) -> Array[Node]:
	return [user]
