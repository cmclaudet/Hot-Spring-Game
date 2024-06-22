extends TextureButton

func _ready():
	pressed.connect(self.open_guest_ui)

func open_guest_ui():
	# todo show current guests in UI panel
	var guests = StateService.state.guests
	pass