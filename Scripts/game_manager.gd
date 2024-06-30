extends Node

signal signal_start_day
signal signal_end_game
signal signal_matching_complete

var day_intro_scene = preload("res://Scenes/day_intro.tscn")
var day_intro_scene_instance

var matching_scene = preload("res://Scenes/Matching/matching.tscn")
var matching_scene_instance

func start_day(day : int):
	var day_resource = get_day_resource(day)
	if day_resource == null:
		end_game()
		return

	if day_intro_scene_instance != null:
		day_intro_scene_instance.init(day)
		day_intro_scene_instance.show()
		day_intro_scene_instance.signal_day_intro_closed.connect(on_day_intro_closed.bind(day_resource))
	else:
		day_intro_scene_instance = day_intro_scene.instantiate()
		day_intro_scene_instance.init(day)
		day_intro_scene_instance.signal_day_intro_closed.connect(on_day_intro_closed.bind(day_resource))
		get_tree().get_root().add_child(day_intro_scene_instance)
	emit_signal("signal_start_day")

func end_day():
	StateService.end_day()
	StateService.remove_guests()
	start_day(StateService.state.day)

func on_day_intro_closed(day : Day):
	var guests = day.guests
	if guests.size() > 0:
		start_matching(guests, StateService.state.available_rooms)
	else:
		emit_signal("signal_matching_complete")

func get_day_resource(day : int) -> Day:
	var day_resource = LoaderUtil.load_day(day)
	return day_resource

func start_matching(guests : Array[Guest], rooms : Array[Room]):
	matching_scene_instance = matching_scene.instantiate()
	matching_scene_instance.init(guests, rooms)
	matching_scene_instance.matching_complete.connect(on_matching_complete)
	get_tree().get_root().add_child(matching_scene_instance)

func on_matching_complete():
	emit_signal("signal_matching_complete")

func end_game():
	print("Game Over")
	emit_signal("signal_end_game")