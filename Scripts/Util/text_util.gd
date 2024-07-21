class_name TextUtil

static func get_img_txt(path : String, width : int, height : int) -> String:
	return "[img=%dx%d]%s[/img]" % [width, height, path]