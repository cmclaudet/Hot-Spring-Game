class_name GuestPanel extends MatchingPanel

@export var guest_name : Label
@export var picture : TextureRect
@export var desired_room_name : Label
@export var desired_room_stars : StarContainer
@export var stay_duration : Label

var guest : Guest

func init(guest : Guest):
	self.guest = guest
	guest_name.text = guest.name
	picture.texture = guest.profile_pic
	desired_room_name.text = guest.desired_room.get_room_type_text()
	var nights_text = " Night" if guest.stay_duration == 1 else " Nights"
	stay_duration.text = str(guest.stay_duration) + nights_text
	desired_room_stars.init(guest.desired_room.stars)

func _get_line_offset():
	return Vector2(size.x, size.y / 2)
