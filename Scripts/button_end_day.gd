extends TextureButton

func _ready():
	pressed.connect(self.end_day)

func end_day():
	# This is where you would put the code to end the day
	# For now, we'll just print a message
	print("Day ended")