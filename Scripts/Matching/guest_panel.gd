class_name GuestPanel extends MatchingPanel

@export var guest_name : RichTextLabel
@export var picture : TextureRect

func init(guest : Guest):
	guest_name.text = "[center]" + guest.name
	picture.texture = guest.profile_pic

func _get_line_offset():
	return Vector2(size.x, size.y / 2)