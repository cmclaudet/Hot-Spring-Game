extends Control

@export var button : NinePatchRectButton

func _ready():
	button.button_selected.connect(self.end_day)

func end_day():
	# This is where you would put the code to end the day
	# For now, we'll just print a message
	print("Day ended")