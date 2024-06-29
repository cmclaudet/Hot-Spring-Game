extends Control

signal matching_complete()

@export var guests : Array[Guest]
@export var rooms : Array[Room]
@export var guest_container : BoxContainer
@export var room_container : BoxContainer

var guest_panel_scene = preload("res://Scenes/Matching/guest_panel.tscn")
var room_panel_scene = preload("res://Scenes/Matching/room_panel.tscn")

var matched_panels : Dictionary

var selected_panel : MatchingPanel

var lines : Array[Line2D]

func _ready():
	for guest in guests:
		var guest_panel = guest_panel_scene.instantiate()
		guest_panel.init(guest)
		guest_panel.button.button_selected.connect(on_guest_selected.bind(guest_panel))
		guest_panel.button.button_deselected.connect(on_guest_deselected.bind(guest_panel))
		guest_container.add_child(guest_panel)
	
	for room in rooms:
		var room_panel = room_panel_scene.instantiate()
		room_panel.init(room)
		room_panel.button.button_selected.connect(on_room_selected.bind(room_panel))
		room_panel.button.button_deselected.connect(on_room_deselected.bind(room_panel))
		room_container.add_child(room_panel)

func _process(_delta):
	if selected_panel != null:
		var mouse_pos = get_global_mouse_position()
		selected_panel.attached_line.set_point_position(1, mouse_pos)

func on_guest_selected(guest_panel : GuestPanel):
	var selected_room = selected_panel as RoomPanel
	var selected_guest = selected_panel as GuestPanel

	if selected_room != null:
		matched_panels[guest_panel] = selected_room
		selected_room.set_matched()
		guest_panel.set_matched()
		guest_panel.attach_line(selected_room.attached_line)
		selected_panel = null
	else:
		if selected_guest != null:
			selected_guest.button._deselect()
		var line = guest_panel.create_line()
		lines.append(line)
		selected_panel = guest_panel

func on_room_selected(room_panel : RoomPanel):
	var selected_room = selected_panel as RoomPanel
	var selected_guest = selected_panel as GuestPanel

	if selected_guest != null:
		matched_panels[selected_guest] = room_panel
		selected_guest.set_matched()
		room_panel.set_matched()
		room_panel.attach_line(selected_guest.attached_line)
		selected_panel = null
	else:
		if selected_room != null:
			selected_room.button._deselect()
		var line = room_panel.create_line()
		lines.append(line)
		selected_panel = room_panel

func on_guest_deselected(guest_panel : GuestPanel):
	var selected_room = selected_panel as RoomPanel
	var selected_guest = selected_panel as GuestPanel

	if matched_panels.has(guest_panel):
		unmatch(guest_panel, matched_panels[guest_panel])
		if selected_room != null:
			guest_panel.button._select()
	elif selected_guest == guest_panel:
		lines.erase(selected_guest.attached_line)
		selected_guest.delete_line()
		selected_panel = null

func on_room_deselected(room_panel : RoomPanel):
	var selected_room = selected_panel as RoomPanel
	var selected_guest = selected_panel as GuestPanel

	if matched_panels.values().has(room_panel):
		unmatch(matched_panels.find_key(room_panel), room_panel)
		if selected_guest != null:
			room_panel.button._select()
	elif selected_room == room_panel:
		lines.erase(selected_room.attached_line)
		selected_room.delete_line()
		selected_panel = null

func unmatch(guest_panel : GuestPanel, room_panel : RoomPanel):
	guest_panel.set_unmatched()
	room_panel.set_unmatched()
	matched_panels.erase(guest_panel)

func _on_done_button_pressed():
	var guest_to_room : Dictionary = {}
	for guest_panel in matched_panels:
		var room_panel = matched_panels[guest_panel]
		guest_to_room[guest_panel.guest] = room_panel.room

	StateService.add_guests(guest_to_room)
	emit_signal("matching_complete")
	for line in lines:
		if line != null:
			line.queue_free()
	queue_free()