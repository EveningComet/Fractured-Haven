## The state where the [SkillHandler] is just waiting for a skill to be activated.
class_name SHIdle extends SHState

func enter(msgs: Dictionary = {}) -> void:
	if OS.is_debug_build() == true:
		print("SHIdle :: Entered.")
