extends MarginContainer


enum {
	HOUSES,
	INFRASTRUCTURE,
}

onready var menu_buttons = {
	HOUSES: $Categories/Houses/Toggle,
	INFRASTRUCTURE: $Categories/Infrastructure/Toggle,
}
onready var menu = {
	HOUSES: $Categories/Houses/Menu,
	INFRASTRUCTURE: $Categories/Infrastructure/Menu,
}


func _ready() -> void:
	pass


func _can_toggle(btn : int) -> bool:
	var allow_toggle : bool = true
	var none_toggled : bool = false
	
	for k in menu.keys():
		none_toggled = none_toggled or !menu[k].visible
		
		if k != btn and menu[k].visible:
			allow_toggle = false
	
	return (menu[btn].visible or none_toggled) and allow_toggle


func _toggle_visibility(btn : int) -> void:
	menu[btn].visible = !menu[btn].visible


func _disable_all_buttons_but(btn : int) -> void:
	for k in menu_buttons.keys():
		if k != btn:
			menu_buttons[k].disabled = !menu_buttons[k].disabled


func _menu_button_toggled(btn : int) -> void:
	if _can_toggle(btn):
		_toggle_visibility(btn)
		_disable_all_buttons_but(btn)


func _on_houses_btn_toggled(button_pressed: bool) -> void:
	_menu_button_toggled(HOUSES)


func _on_infra_btn_toggled(button_pressed: bool) -> void:
	_menu_button_toggled(INFRASTRUCTURE)


func _on_wooden_house_button_up() -> void:
	print("Place wooden house")


func _on_stone_house_button_up() -> void:
	print("Place stone house")


func _on_dirt_road_button_up() -> void:
	print("Place dirt road")
