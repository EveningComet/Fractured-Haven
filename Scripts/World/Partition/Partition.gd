## Think of this as a tile in a strategy game. [Actor]s operate in these areas.
class_name Partition extends Area3D

## The neighbors.
@export var connections: Array[Connection] = []

## The characters currently inside.
var monitored: Array[Actor] = []

func _ready() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	setup_connections()
	# TODO: Way to automate connections?

func setup_connections() -> void:
	for c: Connection in connections:
		c.partition = get_node(c.to_path)
	
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
