extends Car
class_name CpuCar


const STEER_REACTION_MAX : float = 9.0

@export var debug : bool = true
@export var waypoint_distance : float = 20.0
@export var max_top_speed_limit : float = 350.0
@export var min_top_speed_limit : float = 300.0
@export var max_bottom_speed_limit : float = 120.0
@export var min_bottom_speed_limit : float = 80.0
@export var speed_reaction : float = 2.0

@onready var target_sprite: Sprite2D = $TargetSprite

var _adjusted_waypoint_target : Vector2 = Vector2.ZERO
var _steer_reaction : float = STEER_REACTION_MAX
var _target_speed : float = 250.0
var _next_waypoint : Waypoint

func _ready() -> void:
	super()
	target_sprite.visible = debug
	_target_speed = randf_range(min_top_speed_limit, max_top_speed_limit)
	
func update_waypoint() -> void:
	if global_position.distance_to(_adjusted_waypoint_target) < waypoint_distance:
		set_next_waypoint(_next_waypoint.next_waypoint)
		_target_speed = lerp(
			max_bottom_speed_limit,
			max_top_speed_limit,
			_next_waypoint.next_waypoint.radius_factor
		)
		#print(car_number, " ", _target_speed)
	
func set_next_waypoint(wp : Waypoint) -> void:
	_next_waypoint = wp
	_adjusted_waypoint_target = wp.global_position
	target_sprite.global_position = _adjusted_waypoint_target
	
func _physics_process(delta: float) -> void:
	if ! _next_waypoint : 
		return
	if _state == CarState.SLIPPING: 
		update_waypoint()
	if _state != CarState.DRIVING: 
		return
	
	var ta : float = (_adjusted_waypoint_target - global_position).angle()
	rotation = lerp_angle(rotation, ta, _steer_reaction * delta)
	_velocity = lerp(_velocity, _target_speed, delta * speed_reaction)
	position += transform.x * _velocity * delta
	
	update_waypoint()
