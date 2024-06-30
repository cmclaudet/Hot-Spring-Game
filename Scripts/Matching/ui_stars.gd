class_name StarContainer extends HBoxContainer

@export var star_template : TextureRect

func init(star_count : int):
	if star_count < 1:
		star_template.hide()
		return

	for i in range(1, star_count):
		var star = star_template.duplicate()
		add_child(star)