class_name GuestRatingPanel extends Control

@export var guest_name : Label
@export var guest_pic : TextureRect
@export var guest_rating_text : Label
@export var guest_rating_stars : StarContainer
@export var money_earned_label : RichTextLabel

func init(guest : GuestState, star_rating : int, texts_by_star : Dictionary, money : int):
	guest_name.text = guest.guest.name
	guest_pic.texture = guest.guest.profile_pic
	init_money_earned(money)
	init_rating(star_rating, texts_by_star)

func init_rating(star_rating : int, texts_by_star : Dictionary):
	guest_rating_text.text = get_rating_text(texts_by_star, star_rating)
	guest_rating_stars.init(star_rating)

func get_rating_text(texts_by_star : Dictionary, star_rating : int) -> String:
	var rating_text_options : Array = texts_by_star[star_rating]
	var random_option_index : int = randi() % rating_text_options.size()
	return rating_text_options[random_option_index]

func init_money_earned(money : int):
	var img_text = TextUtil.get_img_txt(Constants.MONEY_ICON_PATH, 7, 7)
	money_earned_label.text = "[right]%s+%d" % [img_text, money]
