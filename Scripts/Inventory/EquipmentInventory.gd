@tool
## Modified version of [Inventory] that only takes equipment.
class_name EquipmentInventory extends Inventory

const MAX_NUMBER_OF_EQUIP_SLOTS: int = 4

## The character that will have stuff altered.
var _character: CharacterData

func _init(character: CharacterData = null):
	_character = character
	
	for i in MAX_NUMBER_OF_EQUIP_SLOTS:
		stored_items.insert(i, null)

## Modified version that removes any modifiers from an item, if it exists.
func grab_slot_data(index: int) -> ItemSlotData:
	var slot_data: ItemSlotData = stored_items[index]
	if slot_data != null and slot_data.stored_item != null:
		remove_modifiers_from_equipment( slot_data.stored_item )
	
	# If we have a slot to move, remove the slot and tell anyone caring about the change.
	if slot_data != null and slot_data.stored_item != null:
		stored_items[index] = null
		inventory_updated.emit( self )
		return slot_data
	else:
		return null

## A modified version of the drop slot data method that only accepts equipment
func drop_slot_data(grabbed_slot_data: ItemSlotData, index: int) -> ItemSlotData:
	
	if grabbed_slot_data.stored_item == null:
		return grabbed_slot_data
	
	# If something wants to place an item in us that is not equipment, stop it
	if grabbed_slot_data.stored_item.item_type != ItemTypes.ItemTypes.Equipment:
		return grabbed_slot_data
	
	if _meets_stat_requirements(grabbed_slot_data.stored_item) == false:
		return grabbed_slot_data
	
	# Check if we have to remove the previous equipment
	if stored_items[index] != null and stored_items[index].stored_item != null:
		remove_modifiers_from_equipment( stored_items[index].stored_item )
	
	# This is where the equipment will be equipped and then notify the 
	# stats and all that
	add_modifiers_from_equipment( grabbed_slot_data.stored_item )
	
	return super.drop_slot_data( grabbed_slot_data, index )

## A modified version of the drop single slot data method that only accepts equipment
func drop_single_slot_data(grabbed_slot_data: ItemSlotData, index: int) -> ItemSlotData:
	
	if grabbed_slot_data.stored_item == null:
		return grabbed_slot_data
		
	if _meets_stat_requirements(grabbed_slot_data.stored_item) == false:
		return grabbed_slot_data
	
	# If something wants to place an item in us that is not equipment, stop it
	if grabbed_slot_data.stored_item.item_type != ItemTypes.ItemTypes.Equipment:
		return grabbed_slot_data
	
	# Check if we have to remove the previous equipment
	if stored_items[index] != null and stored_items[index].stored_item != null:
		remove_modifiers_from_equipment( stored_items[index].stored_item )
	
	# This is where the equipment will be equipped and then notify the 
	# stats and all that
	add_modifiers_from_equipment( grabbed_slot_data.stored_item )
	
	return super.drop_single_slot_data( grabbed_slot_data, index )

func find_empty_slot(slot_data: ItemSlotData) -> int:
	var possible_index: int = -1
	
	match slot_data.stored_item.equip_type:
		ItemTypes.EquipmentTypes.Weapon:
			if stored_items[0] == null:
				possible_index = 0
		
		ItemTypes.EquipmentTypes.Accessory:
			for i: int in range(1, stored_items.size()):
				if stored_items[i] == null:
					possible_index = i
					break
		
		_:
			return possible_index
	
	return possible_index

## Used to check if the character meets all the attribute requirements for a
## piece of equipment.
func _meets_stat_requirements(item_data: ItemData) -> bool:
	if item_data.attribute_requirements.size() == 0:
		return true
	
	var stats: Dictionary = _character.stats.stats
	for sr: StatRequirement in item_data.attribute_requirements:
		var attribute_value: int = floor(stats[sr.attribute].get_calculated_value())
		if attribute_value < sr.requirement:
			return false
	
	return true

func add_modifiers_from_equipment(item_data: ItemData) -> void:
	for sm: StatModifier in item_data.stat_modifiers:
		_character.stats.add_modifier(sm.stat_changing, sm)

func remove_modifiers_from_equipment(item_data: ItemData) -> void:
	for sm: StatModifier in item_data.stat_modifiers:
		_character.stats.remove_modifier(sm.stat_changing, sm)
