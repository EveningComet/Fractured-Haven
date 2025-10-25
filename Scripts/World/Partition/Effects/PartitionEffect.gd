@abstract
## Defines special qualities for [Partition] objects.
class_name PartitionEffect extends Resource

enum EffectDurationType { Once, Continuous }

@export var duration_type: EffectDurationType = EffectDurationType.Once
@export var interval_in_seconds : float = 0.0

@abstract func entry(actor: Actor) -> void
@abstract func tick(actor: Actor) -> void
@abstract func exit(actor: Actor) -> void
