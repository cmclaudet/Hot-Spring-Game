class_name UiGuest extends Control

signal signal_on_close_button

var guest_in_room_panel_scene = preload("res://Scenes/guest_in_room_panel.tscn")

@export var guest_container : BoxContainer

func _ready():
	update()

func update():
	for child in guest_container.get_children():
		child.queue_free()
	var guest_states : Array[GuestState] = StateService.state.guests
	for state in guest_states:
		var panel : GuestInRoomPanel = guest_in_room_panel_scene.instantiate()
		panel.init(state)
		guest_container.add_child(panel)
		
func _on_close_button_pressed():
	emit_signal("signal_on_close_button")
	hide()
