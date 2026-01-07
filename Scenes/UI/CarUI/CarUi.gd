extends VBoxContainer
class_name CarUi

@export var label_alignment : HorizontalAlignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT

@onready var name_label: Label = $NameLabel
@onready var lap_label: Label = $LapLabel
@onready var last_lap_label: Label = $LastLapLabel



func _ready() -> void:
	name_label.horizontal_alignment = label_alignment
	lap_label.horizontal_alignment = label_alignment
	last_lap_label.horizontal_alignment = label_alignment

func update_values(car : Car, lap_count : int, lap_time : float) -> void:
	name_label.text = "%s (%02d)" % [car.car_name, car.car_number]
	lap_label.text = "Laps %d" % lap_count
	last_lap_label.text = "Last: %.2fs" % lap_time
	
