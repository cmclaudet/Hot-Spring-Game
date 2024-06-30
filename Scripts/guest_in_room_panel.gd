class_name GuestInRoomPanel extends VBoxContainer

var room_panel_bed_scene = preload("res://Scenes/Matching/room_panel_bed.tscn")

@export var guest_name : Label
@export var guest_picture : TextureRect
@export var days_remaining_label : Label
@export var room_name : Label
@export var bed_container : HBoxContainer

func init(guest_state : GuestState):
	set_guest(guest_state.guest)
	set_room(guest_state.room)
	set_days_remaining(guest_state)

func set_guest(guest : Guest):
	guest_name.text = guest.name
	guest_picture.texture = guest.profile_pic

func set_room(room : Room):
	room_name.text = room.get_room_name()
	for child in bed_container.get_children():
		child.queue_free()

	for bed : Bed in room.beds:
		var bed_instance = room_panel_bed_scene.instantiate()
		bed_container.add_child(bed_instance)
		bed_instance.init(bed)

func set_days_remaining(guest_state : GuestState):
	var days_remaining = guest_state.guest.stay_duration - guest_state.days_stayed
	days_remaining_label.text = "Days left:\n" + str(days_remaining)