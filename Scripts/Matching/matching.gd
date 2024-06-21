extends Control

@export var guests : Array[Guest]
@export var rooms : Array[Room]
@export var guest_container : BoxContainer
@export var room_container : BoxContainer

var guest_panel_scene = preload("res://Scenes/Matching/guest_panel.tscn")
var room_panel_scene = preload("res://Scenes/Matching/room_panel.tscn")

var matched_panels : Dictionary

var selected_guest : GuestPanel
var selected_room : RoomPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	for guest in guests:
		var guest_panel = guest_panel_scene.instantiate()
		guest_panel.init(guest)
		guest_panel.button_selected.connect(on_guest_selected.bind(guest_panel))
		guest_panel.button_deselected.connect(on_guest_deselected.bind(guest_panel))
		guest_container.add_child(guest_panel)
	
	for room in rooms:
		var room_panel = room_panel_scene.instantiate()
		room_panel.init(room)
		room_panel.button_selected.connect(on_room_selected.bind(room_panel))
		room_panel.button_deselected.connect(on_room_deselected.bind(room_panel))
		room_container.add_child(room_panel)

func on_guest_selected(guest_panel : GuestPanel):
	if selected_room != null:
		matched_panels[guest_panel] = selected_room
		selected_room.set_matched()
		guest_panel.set_matched()
		selected_room = null
	else:
		if selected_guest != null:
			selected_guest._deselect()
		selected_guest = guest_panel

func on_room_selected(room_panel : RoomPanel):
	if selected_guest != null:
		matched_panels[selected_guest] = room_panel
		selected_guest.set_matched()
		room_panel.set_matched()
		selected_guest = null
	else:
		if selected_room != null:
			selected_room._deselect()
		selected_room = room_panel

func on_guest_deselected(guest_panel : GuestPanel):
	if matched_panels.has(guest_panel):
		unmatch(guest_panel, matched_panels[guest_panel])
		if selected_room != null:
			guest_panel._select()
	elif selected_guest == guest_panel:
		selected_guest = null

func on_room_deselected(room_panel : RoomPanel):
	if matched_panels.values().has(room_panel):
		unmatch(matched_panels.find_key(room_panel), room_panel)
		if selected_guest != null:
			room_panel._select()
	elif selected_room == room_panel:
		selected_room = null

func unmatch(guest_panel : GuestPanel, room_panel : RoomPanel):
	guest_panel.set_unmatched()
	room_panel.set_unmatched()
	matched_panels.erase(guest_panel)