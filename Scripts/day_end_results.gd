extends Control

signal signal_end_day

@export var guests_leaving_text : Label
@export var ratings_container : BoxContainer
@export var generic_rating_texts : Resource

var guest_rating_panel_scene = preload("res://Scenes/guest_rating_panel.tscn")

func init(guests : Array[GuestState]):
	SignalUtil.disconnect_all_signals(self, signal_end_day)
	init_guests_leaving_text(guests)
	for child in ratings_container.get_children():
		child.queue_free()
	for guest in guests:
		var guest_rating_panel = guest_rating_panel_scene.instantiate()
		guest_rating_panel.init(guest, generic_rating_texts.texts_by_star)
		ratings_container.add_child(guest_rating_panel)

func init_guests_leaving_text(guests : Array[GuestState]):
	if guests.size() == 0:
		guests_leaving_text.text = "No check outs. You had a calm, peaceful day."
	else:
		guests_leaving_text.text = "Guests leaving..."

func _on_button_button_selected():
	emit_signal("signal_end_day")
	hide()
