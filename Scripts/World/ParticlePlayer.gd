class_name ParticlePlayer extends Node3D

func _ready() -> void:
	# TODO: More robust way of doing this.
	await get_tree().create_timer(3.0, false, true).timeout
	queue_free()
