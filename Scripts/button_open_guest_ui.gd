extends TextureButton

@export var ui_container : Control

var ui_guests_scene = preload("res://Scenes/ui_guests.tscn")
var ui_guest_instance : UiGuest

func _ready():
	pressed.connect(self.open_guest_ui)

func open_guest_ui():
	if ui_guest_instance == null:
		ui_guest_instance = ui_guests_scene.instantiate()
		ui_guest_instance.signal_on_close_button.connect(self.on_close_guest_ui)
		get_tree().get_root().add_child(ui_guest_instance)
	else:
		ui_guest_instance.update()
		ui_guest_instance.show()

	ui_container.hide()

func on_close_guest_ui():
	ui_container.show()
