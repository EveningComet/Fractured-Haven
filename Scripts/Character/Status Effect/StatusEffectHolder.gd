## Keeps track of the [StatusEffect]s on a character, using [SEInstance].
class_name StatusEffectHolder extends Resource

signal statuses_changed(se_holder: StatusEffectHolder)

@export var statuses: Dictionary[StatusEffect, SEInstance] = {}
var _character: CharacterData

func _init(cd: CharacterData) -> void:
	_character = cd

func tick(delta: float) -> void:
	for sei: SEInstance in statuses.values():
		sei.tick(delta)

func add_status(se: StatusEffect) -> void:
	if statuses.has(se) == true:
		pass
	else:
		var se_instance: SEInstance = SEInstance.new(se)
		statuses[se] = se_instance
		se_instance.status_expired.connect(_on_status_expired)
		se_instance.tick_rate_achieved.connect(_on_status_tick_rate_met)

func remove_status(se: StatusEffect) -> void:
	statuses.erase(se)
	statuses_changed.emit(self)
	statuses_changed.emit(self)

func _on_status_expired(se: StatusEffect) -> void:
	remove_status(se)

func _on_status_tick_rate_met(sei: SEInstance) -> void:
	sei.status.trigger_on_tick(_character)
