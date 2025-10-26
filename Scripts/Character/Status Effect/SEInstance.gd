## Stores an instance of a [StatusEffect] object.
class_name SEInstance extends Resource

## Fired when this object has reached its max, allowed lifetime.
signal status_expired(sei: SEInstance)

signal tick_rate_achieved(sei: SEInstance)

@export var status: StatusEffect = null

var curr_lifetime: float = 0.0
var tick_time:     float = 0.0

func _init(se: StatusEffect = null) -> void:
	status = se

func tick(delta: float) -> void:
	if status.is_infinite() == false:
		curr_lifetime += delta
		tick_time     += delta
		if tick_time >= status.tick_rate:
			tick_rate_achieved.emit(self)
			tick_time = 0.0
		if curr_lifetime >= status.base_duration:
			status_expired.emit(self)
