class_name DefaultValidator extends TargetingValidator

func is_valid(targetable: Node) -> bool:
	return true if targetable != null else false
