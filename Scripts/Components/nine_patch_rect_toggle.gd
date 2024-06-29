class_name NinePatchRectToggle extends NinePatchRect

signal button_selected()
signal button_deselected()

@export var onHoverTex : Texture2D
@export var onPressedTex : Texture2D
@export var onSelectedTex : Texture2D

var defaultTex : Texture2D
var isSelected : bool = false

func _ready():
	defaultTex = texture

func _on_mouse_entered():
	if !isSelected:
		texture = onHoverTex

func _on_mouse_exited():
	if !isSelected:
		texture = defaultTex

func _on_gui_input(event:InputEvent):
	var mouse_event = event as InputEventMouseButton
	if mouse_event != null: 
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.is_pressed():
				texture = onPressedTex
			elif mouse_event.is_released():
				if isSelected:
					_deselect()
					texture = onHoverTex
				else:
					_select()
		else:
			if !isSelected:
				texture = onHoverTex

func _deselect():
	isSelected = false
	texture = defaultTex
	emit_signal("button_deselected")

func _select():
	isSelected = true
	texture = onSelectedTex
	emit_signal("button_selected")