class_name SignalUtil

static func disconnect_all_signals(object : Object, obj_signal : Signal):
	var connections = object.get_signal_connection_list(obj_signal.get_name())
	for connection in connections:
		obj_signal.disconnect(connection["callable"])