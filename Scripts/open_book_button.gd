extends TextureButton

var matching_scene = preload("res://Scenes/Matching/matching.tscn")
var matching_scene_instance

func _ready():
	pressed.connect(self.open_book)

func open_book():
	if matching_scene_instance:
		matching_scene_instance.show()
	else:
		var scene_instance = matching_scene.instantiate()
		matching_scene_instance = scene_instance
		get_tree().get_root().add_child(scene_instance)
	hide()