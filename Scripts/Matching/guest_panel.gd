class_name GuestPanel extends MatchingPanel

@export var guest_name : Label
@export var picture : TextureRect
var guest : Guest

func init(guest : Guest):
	self.guest = guest
	guest_name.text = guest.name
	picture.texture = guest.profile_pic

func _get_line_offset():
	return Vector2(size.x, size.y / 2)