extends Node

var state : State

func _ready():
	# todo load from file
	state = State.new()

func add_guests(new_guests_to_room : Dictionary):
	var new_guests = Array()
	for guest in new_guests_to_room:
		var room = new_guests_to_room[guest]
		var guest_state = GuestState.new()
		guest_state.guest = guest
		guest_state.room = room
		new_guests.append(guest_state)

		if state.available_rooms.has(room):
			state.available_rooms.erase(room)

	state.guests.append_array(new_guests)

func remove_guests():
	# todo compare guest stay duration with guest days stayed, remove those that should leave
	pass