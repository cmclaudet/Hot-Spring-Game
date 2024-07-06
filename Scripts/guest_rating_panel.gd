class_name GuestRatingPanel extends Control

@export var guest_name : Label
@export var guest_pic : TextureRect
@export var guest_rating_text : Label
@export var guest_rating_stars : StarContainer

func init(guest : GuestState, texts_by_star : Dictionary):
	guest_name.text = guest.guest.name
	guest_pic.texture = guest.guest.profile_pic
	init_rating(guest, texts_by_star)

func init_rating(guest : GuestState, texts_by_star : Dictionary):
	var desired_room = guest.guest.desired_room
	var actual_room = guest.room
	var star_rating = get_star_rating(desired_room, actual_room)
	guest_rating_text.text = get_rating_text(texts_by_star, star_rating)
	guest_rating_stars.init(star_rating)

func get_star_rating(desired_room : Room, actual_room : Room) -> int:
	var room_star_difference = abs(desired_room.stars - actual_room.stars)
	var room_type_difference = abs(desired_room.type - actual_room.type) * 1.5
	var star_rating : int = round(5 - (room_star_difference + room_type_difference) / 2.0)
	return star_rating

func get_rating_text(texts_by_star : Dictionary, star_rating : int) -> String:
	var rating_text_options : Array = texts_by_star[star_rating]
	var random_option_index : int = randi() % rating_text_options.size()
	return rating_text_options[random_option_index]
