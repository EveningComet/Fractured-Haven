## Stores data for something that modifies a stat.
class_name StatModifier extends Resource

## What stat does this modifier change?
@export var stat_changing: StatHelper.StatTypes

## Which type of modifier does this give?
@export var stat_modifier_type: StatModifierTypes.StatModifierTypes

## The modifier's value
@export var value: float = 0.0

## How much priority does this modifier have?
@export var sort_order: int = 0
