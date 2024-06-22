extends Node2D

var matching_scene = preload("res://Scenes/Matching/matching.tscn")
var matching_scene_instance

func _ready():
	open_book()

func open_book():
	var scene_instance = matching_scene.instantiate()
	matching_scene_instance = scene_instance
	matching_scene_instance.matching_complete.connect(show)
	get_tree().get_root().add_child.call_deferred(scene_instance)
	hide()