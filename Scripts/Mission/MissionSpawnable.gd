## Something related to being spawned for a mission.
class_name MissionSpawnable extends Resource

@export_category("Object(s) To Spawn")
@export var character_data:     CharacterData     = CharacterData.new()
@export var item_data:          ItemSlotData      = ItemSlotData.new()
@export var location_to_spawn:  Vector3           = Vector3.ZERO
@export var spawn_rotation:     Vector3           = Vector3.ZERO

@export_category("Creature Instancing")
@export var skills:             Array[SkillData]  = []
