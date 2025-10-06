## This component works as a middle-man. It allows interacting with an inventory.
class_name InventoryInterface extends Node2D

@export_category("Inventory UI")
## The component displaying the player's inventory.
@export var player_inventory_displayer: InventoryDisplayer

## The ui that will display the contents of a shop, chest, and so on to the player.
@export var external_inventory_displayer: InventoryDisplayer

@export_category("Drag & Drop")
## Used for displaying a dragged item to the player.
@export var grabbed_slot_ui: ItemSlotUI

var _grabbed_slot_data: ItemSlotData = null

# TODO: More dynamic system
var _player_inventory:   Inventory
var _external_inventory: Inventory
var _pm_equipment:       EquipmentInventory

@onready var _parent: Control = get_parent()

func _ready() -> void:
	_parent.visibility_changed.connect( _on_visibility_changed )
	external_inventory_displayer.player_gui_input.connect( _on_inventory_gui_input )

func _input(event: InputEvent) -> void:
	if grabbed_slot_ui.visible == true:
		# Display the grabbed slot at the mouse position with an offset
		grabbed_slot_ui.global_position = get_global_mouse_position() + Vector2(5, 5)

## Set the player's inventory to be displayed and hook it up with the needed
## stuff.
func set_player_inventory(new_inventory: Inventory) -> void:
	_player_inventory = new_inventory
	player_inventory_displayer.set_inventory_to_display( _player_inventory )
	_player_inventory.inventory_interacted.connect(
		_on_inventory_interacted
	)
	player_inventory_displayer.player_gui_input.connect(
		_on_inventory_gui_input
	)

func set_external_inventory(new_inventory: Inventory) -> void:
	if _external_inventory != null:
		_external_inventory.inventory_interacted.disconnect( _on_inventory_interacted )
	_external_inventory = new_inventory
	_external_inventory.inventory_interacted.connect( _on_inventory_interacted )
	external_inventory_displayer.set_inventory_to_display(_external_inventory)
	external_inventory_displayer.show()

## Used when the player interacts with an inventory data object.
func _on_inventory_interacted(inventory_data: Inventory, index: int, button_index: int) -> void:	
	match [_grabbed_slot_data, button_index]:
		
		# The player wants to grab the whole item
		[null, MOUSE_BUTTON_LEFT]:
			_grabbed_slot_data = inventory_data.grab_slot_data(index)
		
		# The player wants to drop the item in a new slot
		[_, MOUSE_BUTTON_LEFT]:
			_grabbed_slot_data = inventory_data.drop_slot_data(_grabbed_slot_data, index)
		
		# Attempt to use the item
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data( index )
		
		# Player is trying to drop a piece of the slot
		[_, MOUSE_BUTTON_RIGHT]:
			_grabbed_slot_data = inventory_data.drop_single_slot_data(_grabbed_slot_data, index)
		
	_update_grabbed_slot()

func _on_inventory_gui_input(inventory_data: Inventory, event: InputEvent) -> void:
	if _grabbed_slot_data != null:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			inventory_data.add_slot_data( _grabbed_slot_data )
			_grabbed_slot_data = null
			_update_grabbed_slot()

func clear_external_inventory() -> void:
	if _external_inventory != null:
		external_inventory_displayer.clear_inventory()
		_external_inventory.inventory_interacted.disconnect( _on_inventory_interacted )
		_external_inventory = null
		external_inventory_displayer.hide()

func _update_grabbed_slot() -> void:
	if _grabbed_slot_data != null:
		grabbed_slot_ui.global_position = get_global_mouse_position()
		grabbed_slot_ui.show()
		grabbed_slot_ui.set_slot_data( _grabbed_slot_data )
	else:
		grabbed_slot_ui.hide()

func _on_visibility_changed() -> void:
	if _parent.visible == false and _grabbed_slot_data != null:
		_player_inventory.add_slot_data(_grabbed_slot_data )
		_grabbed_slot_data = null
		_update_grabbed_slot()
