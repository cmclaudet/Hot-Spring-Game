class_name RoomPanel extends MatchingPanel

@export var room_name : Label
@export var bed_container : HBoxContainer
@export var star_container : StarContainer

var room : Room

var room_panel_bed_scene = preload("res://Scenes/Matching/room_panel_bed.tscn")

func init(room : Room, matching_container : Control):
	self.matching_container = matching_container
	self.room = room
	room_name.text = room.get_room_name()
	for child in bed_container.get_children():
		child.queue_free()

	for bed : Bed in room.beds:
		var bed_instance = room_panel_bed_scene.instantiate()
		bed_container.add_child(bed_instance)
		bed_instance.init(bed)

	star_container.init(room.stars)

func _get_line_offset():
	return Vector2(0, size.y / 2)
