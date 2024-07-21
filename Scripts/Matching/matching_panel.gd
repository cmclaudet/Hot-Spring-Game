class_name MatchingPanel extends Control

@export var button : NinePatchRectToggle
var attached_line : Line2D
var attached_line_point_index : int
var matching_container : Control

func _process(_delta):
	if attached_line != null:
		attached_line.set_point_position(attached_line_point_index, get_line_position())

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
	attached_line_point_index = 1
	line.set_point_position(attached_line_point_index, get_line_position())

func create_line() -> Line2D:
	var line = Line2D.new()
	line.default_color = Color(0, 0, 0, 0.5)
	line.width = 2
	matching_container.get_parent().add_child(line)
	
	line.add_point(get_line_position())
	line.add_point(get_global_mouse_position())

	attached_line_point_index = 0
	attached_line = line
	return line

func delete_line():
	if attached_line != null:
		attached_line.queue_free()
	attached_line = null

func get_line_position():
	return get_global_transform_with_canvas().origin + _get_line_offset()

func _get_line_offset():
	return Vector2(0, 0)

func _get_mouse_offset():
	return Vector2 (0, size.y / 2)
