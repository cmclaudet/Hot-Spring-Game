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

func end_day():
	state.day += 1
	for guest in state.guests:
		guest.days_stayed += 1

func remove_guests() -> Array[GuestState]:
	var guests_to_remove : Array[GuestState] = []
	for guest in state.guests:
		if guest.days_stayed >= guest.guest.stay_duration:
			guests_to_remove.append(guest)

	for guest in guests_to_remove:
		state.available_rooms.append(guest.room)
		state.guests.erase(guest)

	return guests_to_remove