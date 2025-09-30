## Think of this as a tile in a strategy game. [Actor]s operate in these areas.
class_name Partition extends Area3D

## The neighbors.
@export var connections: Array[Partition] = []
# TODO: Might be better to make a class that will store connection data. That will
# make it really easy to handle things such as "a breakable wall" blocks the
# connection to a nearby room.

## The characters currently inside.
var monitored: Array[Actor] = []

func _ready() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	
	# TODO: Way to automate connections?
	
func _on_body_entered(body) -> void:
	if body is Actor:
		if OS.is_debug_build() == true:
			print("Partition :: %s found: %s" % [name, body.name])
		var actor: Actor = body as Actor
		actor.partition  = self
		monitored.append(body)

func _on_body_exited(body) -> void:
	if body is Actor:
		monitored.erase(body)
