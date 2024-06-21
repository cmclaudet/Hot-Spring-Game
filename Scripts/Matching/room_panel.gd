class_name RoomPanel extends NinePatchRectButton

@export var room_name : RichTextLabel
@export var bed_container : HBoxContainer

var room_panel_bed_scene = preload("res://Scenes/Matching/room_panel_bed.tscn")

func init(room : Room):
	room_name.text = Room.RoomType.keys()[room.type]
	for child in bed_container.get_children():
		child.queue_free()

	for bed : Bed in room.beds:
		var bed_instance = room_panel_bed_scene.instantiate()
		bed_container.add_child(bed_instance)
		bed_instance.init(bed)

func set_matched():
	texture = onHoverTex

func set_unmatched():
	isSelected = false
	texture = defaultTex