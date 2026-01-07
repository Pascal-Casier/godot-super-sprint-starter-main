extends Object
class_name CarRaceData

const DEFAULT_LAPTIME : float = 999.99

var _car_number : int
var _car_name : String
var _total_time : float
var _completed_laps : int
var _partial_progress : float
var _best_lap : float = DEFAULT_LAPTIME
var _target_laps : int = 0

var race_completed : bool :
	get:
		return _completed_laps == _target_laps

var total_progress : float :
	get:
		return _completed_laps + _partial_progress

func _init(car_name : String, car_number : int, target_laps : int) -> void:
	_target_laps = target_laps
	_car_number = car_number
	_car_name = car_name

func add_lap_time(lap_time : float) -> void:
	_completed_laps += 1
	_best_lap = min(_best_lap, lap_time)
