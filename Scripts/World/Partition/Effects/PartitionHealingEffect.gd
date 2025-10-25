class_name PartitionHealingEffect extends PartitionEffect

@export var heal_amount: int = 0

func entry(_actor: Actor) -> void:
	pass

func tick(actor: Actor) -> void:
	actor.combatant.character_data.stats.heal(heal_amount)

func exit(_actor: Actor) -> void:
	pass
