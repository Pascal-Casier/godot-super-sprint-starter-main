extends Car
class_name PlayerCar


@export var max_speed : float = 380.0
@export var friction : float = 300.0
@export var acceleration : float = 150.0
@export var steer_strength : float = 6.0
@export var min_steer_factor : float = 0.5

var _throttle : float = 0.0
var _steer : float = 0.0





func _process(delta: float) -> void:
	_throttle = Input.get_action_strength("ui_up")
	_steer = Input.get_axis("ui_left", "ui_right")
	super(delta)
	
func _physics_process(delta: float) -> void:
	if _state != CarState.DRIVING:
		return
	apply_throttle(delta)
	apply_rotation(delta)
	position += transform.x * _velocity * delta

func apply_throttle(delta : float) -> void:
	if _throttle > 0.0:
		_velocity += acceleration * delta
	else:
		_velocity -= friction * delta
	_velocity = clamp(_velocity, 0, max_speed)

func get_steer_factor() -> float:
	return clamp(
		1.0 - pow(_velocity / max_speed, 2.0),
		min_steer_factor,
		1.0
	) * steer_strength
	
	
func apply_rotation(delta : float) -> void:
	rotate(get_steer_factor() * delta * _steer)
	
