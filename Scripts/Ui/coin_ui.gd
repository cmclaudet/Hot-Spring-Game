extends Control

@export var amount_label : Label

func _ready():
	update_coin_amount()
	
func update_coin_amount():
	amount_label.text = str(StateService.state.money)