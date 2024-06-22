class_name MatchingPanel extends Control

@export var button : NinePatchRectButton
var attached_line : Line2D

func set_matched():
	button.texture = button.onHoverTex

func set_unmatched():
	button.isSelected = false
	button.texture = button.defaultTex
	if attached_line != null:
		attached_line.queue_free()
	attached_line = null

func attach_line(line : Line2D):
	attached_line = line
	line.set_point_position(1, get_global_position() + _get_line_offset())

func create_line():
	var line = Line2D.new()
	line.default_color = Color(0, 0, 0, 0.5)
	line.width = 2
	var global_pos = get_global_position() + _get_line_offset()
	line.add_point(global_pos)
	line.add_point(get_global_mouse_position())
	attached_line = line
	get_tree().get_root().add_child(line)

func delete_line():
	if attached_line != null:
		attached_line.queue_free()
	attached_line = null

func _get_line_offset():
	return Vector2(0, 0)