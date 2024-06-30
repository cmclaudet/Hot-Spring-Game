extends Control

signal signal_end_day

@export var button : NinePatchRectButton

func _ready():
	button.button_selected.connect(self.end_day)

func end_day():
	emit_signal("signal_end_day")