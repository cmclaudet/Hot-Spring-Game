class_name NinePatchRectButton extends NinePatchRect

signal button_selected()

@export var onHoverTex : Texture2D
@export var onPressedTex : Texture2D

var defaultTex : Texture2D

func _ready():
	defaultTex = texture

func _on_mouse_entered():
	texture = onHoverTex

func _on_mouse_exited():
	texture = defaultTex

func _on_gui_input(event:InputEvent):
	var mouse_event = event as InputEventMouseButton
	if mouse_event != null: 
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.is_pressed():
				texture = onPressedTex
			elif mouse_event.is_released():
				_pressed()
				texture = onHoverTex

func _pressed():
	emit_signal("button_selected")
