class_name CapturablePartition extends Partition

@export var effects: Array[PartitionEffect] = []

signal captured(partition : Partition)

var is_captured: bool = false

var monitored_timers: Dictionary[Timer, Actor] = {}

func _ready() -> void:
	super._ready()
	body_exited.connect(_check_partition_captured)
	captured.connect(_apply_effects_on_all_actors)
	body_entered.connect(_check_partition_effect_entry)
	body_exited.connect(_check_partition_effect_exit)
	
func _check_partition_captured(_body) -> void:
	var enemies := monitored.values().filter(func(a: Actor): return not a.owned_by_player)
	if enemies.size() == 0 and not is_captured:
		print("Partition :: %s captured" % [name])
		is_captured = true
		captured.emit(self)
		
func _apply_effects_on_all_actors(_partition : Partition) -> void:
	for actor in monitored.values():
		_activate_partition_effects(actor)
	
func _check_partition_effect_entry(body) -> void:
	if is_captured and body is Actor:
		_activate_partition_effects(body as Actor)
	
func _check_partition_effect_exit(body) -> void:
	if is_captured and body is Actor:
		_deactivate_partition_effects(body as Actor)

func _activate_partition_effects(actor : Actor) -> void:
	print("Partition :: %s activating partition effects for %s" % [name, actor.combatant.character_data.char_name])
	_setup_timers_for_continuous_effects()
	for effect in effects:
		effect.entry(actor)

func _deactivate_partition_effects(actor : Actor) -> void:
	print("Partition :: %s deactivating partition effects for %s" % [name, actor.combatant.character_data.char_name])
	var timers_to_remove : Array[Timer] = [] 
	for timer in monitored_timers:
		if monitored_timers[timer] == actor:
			timer.stop()
			timers_to_remove.append(timer)
	for timer in timers_to_remove:
		monitored_timers.erase(timer)
		timer.queue_free()
	for effect in effects:
		effect.exit(actor)

func _setup_timers_for_continuous_effects() -> void:
	for effect in effects.filter(func(e: PartitionEffect): return e.duration_type == PartitionEffect.EffectDurationType.Continuous):
		for actor in monitored.values():
			var timer := Timer.new()
			timer.autostart = false
			timer.wait_time = effect.interval_in_seconds
			timer.timeout.connect(effect.tick.bind(actor))
			timer.tree_entered.connect(timer.start)
			monitored_timers[timer] = actor
			add_child(timer)
