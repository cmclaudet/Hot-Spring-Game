extends Node2D

@export var ui_container : Control
@export var starting_rooms : Array[Room]
@export var canvas_layer : CanvasLayer

func _ready():
	ui_container.hide()
	init_state()
	GameManager.init(canvas_layer)
	GameManager.signal_start_day.connect(ui_container.hide)
	GameManager.signal_end_day.connect(ui_container.hide)
	GameManager.signal_matching_complete.connect(ui_container.show)
	GameManager.signal_end_game.connect(ui_container.hide)

	GameManager.start_day.call_deferred(StateService.state.day)

func init_state():
	StateService.state.day = 1
	StateService.state.available_rooms = starting_rooms

func _on_end_day_ui_button_signal_end_day():
	GameManager.end_day()
