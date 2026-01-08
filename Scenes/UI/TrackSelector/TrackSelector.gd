extends PanelContainer
class_name TrackSelector

@onready var high_light: ColorRect = $HighLight
@onready var texture_rect: TextureRect = $MC/TextureRect
@onready var track_label: Label = $MC/TrackLabel
@onready var best_lap_label: Label = $MC/BestLapLabel

const DARK : Color = Color("132136")
const LIGHT : Color = Color("324d74")

@export var track_info : TrackInfo

func _ready() -> void:
	high_light.color = DARK
	texture_rect.texture = track_info.preview_image
	track_label.text = track_info.track_name
	
	var best_lap : float = GameManager.get_best_lap(track_info.track_name)
	if best_lap == CarRaceData.DEFAULT_LAPTIME:
		best_lap_label.text = "No best lap"
	else:
		best_lap_label.text = "Best: %.2fs" % best_lap

func _on_mouse_entered() -> void:
	high_light.color = LIGHT


func _on_mouse_exited() -> void:
	high_light.color = DARK


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		GameManager.change_to_track(track_info)
