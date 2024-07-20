class_name DayIntro extends Control

signal signal_day_intro_closed

@export var day_text : Label

func init(day : int):
	day_text.text = "Day " + str(day)
	SignalUtil.disconnect_all_signals(self, signal_day_intro_closed)

func _on_button_button_selected():
	emit_signal("signal_day_intro_closed")
	hide()
