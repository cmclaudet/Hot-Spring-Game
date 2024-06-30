class_name LoaderUtil

static func load_day(day_number : int):
	var path = "res://Resources/Days/day_" + str(day_number) + ".tres"
	var day_resource = ResourceLoader.load(path)
	return day_resource

static func load_rooms():
	var rooms_path = "res://Resources/Rooms"
	var room_dir = DirAccess.open(rooms_path)
	var rooms : Array[Room] = []

	if room_dir:
		room_dir.list_dir_begin()
		var file_name = room_dir.get_next()
		while file_name != "":
			if file_name.begins_with("room_"):
				var room_path = rooms_path + "/" + file_name
				var room_resource = ResourceLoader.load(room_path)
				rooms.append(room_resource)
			file_name = room_dir.get_next()

	return rooms