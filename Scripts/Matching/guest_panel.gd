class_name GuestPanel extends NinePatchRectButton

@export var guest_name : RichTextLabel
@export var picture : TextureRect

func init(guest : Guest):
	# print_debug("GuestPanel init" + guest.name)
	guest_name.text = "[center]" + guest.name
	picture.texture = guest.profile_pic

func set_matched():
	texture = onHoverTex

func set_unmatched():
	isSelected = false
	texture = defaultTex
