extends Car
class_name CpuCar


const STEER_REACTION_MAX : float = 9.0

@export var debug : bool = true
@export var waypoint_distance : float = 20.0

@onready var target_sprite: Sprite2D = $TargetSprite

var _adjusted_waypoint_target : Vector2 = Vector2.ZERO
var _steer_reaction : float = STEER_REACTION_MAX
var _target_speed : float = 250.0
var _next_waypoint : Waypoint

func _ready() -> void:
	super()
	target_sprite.visible = debug
	
func update_waypoint() -> void:
	if global_position.distance_to(_adjusted_waypoint_target) < waypoint_distance:
		set_next_waypoint(_next_waypoint.next_waypoint)
	
func set_next_waypoint(wp : Waypoint) -> void:
	_next_waypoint = wp
	_adjusted_waypoint_target = wp.global_position
	target_sprite.global_position = _adjusted_waypoint_target
	
func _physics_process(delta: float) -> void:
	if _state != CarState.DRIVING: return
	if ! _next_waypoint : return
	
	var ta : float = (_adjusted_waypoint_target - global_position).angle()
	rotation = lerp_angle(rotation, ta, _steer_reaction * delta)
	_velocity = lerp(_velocity, _target_speed, delta)
	position += transform.x * _velocity * delta
	
	update_waypoint()
