extends Node2D

@export var ui_container : Control
@export var starting_rooms : Array[Room]
@export var canvas_layer : CanvasLayer
@export var player : Player

func _ready():
	ui_container.hide()
	init_state()
	GameManager.init(canvas_layer)
	GameManager.signal_start_day.connect(on_start_day)
	GameManager.signal_end_day.connect(on_end_day)
	GameManager.signal_matching_complete.connect(on_matching_complete)
	GameManager.signal_end_game.connect(on_end_game)

	GameManager.start_day.call_deferred(StateService.state.day)

func init_state():
	StateService.state.day = 1
	StateService.state.available_rooms = starting_rooms

func _on_end_day_ui_button_signal_end_day():
	GameManager.end_day()

func on_start_day():
	ui_container.hide()
	player.can_move = false

func on_matching_complete():
	ui_container.show()
	player.can_move = true

func on_end_day():
	ui_container.hide()
	player.can_move = false

func on_end_game():
	ui_container.hide()