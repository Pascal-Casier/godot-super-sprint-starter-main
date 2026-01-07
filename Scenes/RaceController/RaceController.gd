extends Node

class_name RaceController

@export var total_laps : int = 5

var _cars : Array[Car] = []
var _track_curve : Curve2D
var _race_data : Dictionary[Car, CarRaceData] = {}
var _started : bool = false
var _finished : bool = false
var _start_time : float


func setup(cars : Array[Car], track_curve : Curve2D) -> void:
	_cars = cars
	_track_curve = track_curve
	for c in cars:
		_race_data[c] = CarRaceData.new(
			c.car_name, c.car_number, total_laps
		)
	print("Race Controller init with %d cars", cars.size())
func _enter_tree() -> void:
	EventHub.on_lap_completed.connect(on_lap_completed)
	EventHub.on_race_start.connect(on_race_start)
	
func on_race_start() -> void:
	if _started : return
	_started = true
	_finished = false
	_start_time = Time.get_ticks_msec()
	
	
func on_lap_completed(info : LapCompleteData) -> void:
	print("Racecontroller on lap completed : ", info)
	if not _started or _finished : return
	
	var car: Car = info.car
	var rd : CarRaceData = _race_data[car]

func _on_race_over_timer_timeout() -> void:
	pass # Replace with function body.
