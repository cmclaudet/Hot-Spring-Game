extends Control

signal signal_end_day

@export var header : Label
@export var guests_leaving_text : Label
@export var ratings_container : BoxContainer
@export var generic_rating_texts : Resource
@export var total_money_earned_label : RichTextLabel

var guest_rating_panel_scene = preload("res://Scenes/guest_rating_panel.tscn")
var max_star_count : int = 5
var base_star_count : int = 3

func init(guests : Array[GuestState]):
	header.text = "Day %d End" % (StateService.state.day - 1)
	SignalUtil.disconnect_all_signals(self, signal_end_day)
	init_guests_leaving_text(guests)
	for child in ratings_container.get_children():
		child.queue_free()
	var total_money_earned = 0
	for guest in guests:
		var star_rating = get_star_rating(guest)
		var money = give_money(guest, star_rating)
		var guest_rating_panel = guest_rating_panel_scene.instantiate()
		guest_rating_panel.init(guest, star_rating, generic_rating_texts.texts_by_star, money)
		ratings_container.add_child(guest_rating_panel)
		total_money_earned += money
	init_total_money_earned(total_money_earned)

func init_guests_leaving_text(guests : Array[GuestState]):
	if guests.size() == 0:
		guests_leaving_text.text = "No check outs. You had a calm, peaceful day."
	else:
		guests_leaving_text.text = "Guests leaving..."

func _on_button_button_selected():
	emit_signal("signal_end_day")
	hide()

func give_money(guest : GuestState, star_rating : int):
	var extra_stars = max(0, star_rating - base_star_count)
	var extra_money : int = round(extra_stars * guest.guest.base_nightly_pay * 0.05)
	var total_money : int = (guest.guest.base_nightly_pay + extra_money) * guest.days_stayed
	StateService.state.money += total_money
	return total_money

func get_star_rating(guest : GuestState) -> int:
	var desired_room = guest.guest.desired_room
	var actual_room = guest.room
	var room_star_difference = abs(desired_room.stars - actual_room.stars)
	var room_type_difference = abs(desired_room.type - actual_room.type) * 1.5
	var star_rating : int = round(max_star_count - (room_star_difference + room_type_difference) / 2.0)
	return star_rating

func init_total_money_earned(total_money_earned : int):
	var img_text = TextUtil.get_img_txt(Constants.MONEY_ICON_PATH, 15, 15)
	total_money_earned_label.text = "[right]%s+%d" % [img_text, total_money_earned]
