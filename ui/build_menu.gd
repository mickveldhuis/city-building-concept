extends MarginContainer


enum {
	HOUSES,
	INFRASTRUCTURE,
}

var selector_active : bool = false

onready var menu_buttons = {
	HOUSES: $Categories/Houses/Toggle,
	INFRASTRUCTURE: $Categories/Infrastructure/Toggle,
}
onready var menu = {
	HOUSES: $Categories/Houses/Menu,
	INFRASTRUCTURE: $Categories/Infrastructure/Menu,
}


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action") and selector_active:
		place_object()
	elif Input.is_action_just_pressed("interact") and selector_active:
		free_selector()


func instantiate_selector_for(cat : String, subcat : String) -> void:
	if not selector_active:
		_toggle_current_menu()
		selector_active = true
		
		var selector = ResourceManager.components["tile_selector"].instance()
		selector.set_placeable(cat, subcat)
		
		var world = get_tree().current_scene
		world.add_child(selector)


func free_selector() -> void:
	_toggle_current_menu()
	selector_active = false
	
	get_tree().current_scene.get_node("TileSelector").queue_free()


func place_object() -> void:
	var ts : Control = get_tree().current_scene.get_node("TileSelector")
	var location : Vector2 = ts.get_location()
	var data : Dictionary = ts.placeable_data
	
	if not ts.is_blocked():
		var object = ResourceManager.placeables[data.cat][data.subcat].instance()
		object.set_position(location)
		
		var world = get_tree().current_scene
		world.add_child(object)


func toggle_visibility() -> void:
	visible = !visible

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


func _toggle_current_menu() -> void:
	for k in menu.keys():
		if menu[k].visible:
			for node in menu[k].get_children():
				if node is BaseButton: 
					node.disabled = !node.disabled


func _menu_button_toggled(btn : int) -> void:
	if _can_toggle(btn):
		_toggle_visibility(btn)
		_disable_all_buttons_but(btn)


func _on_houses_btn_toggled(button_pressed: bool) -> void:
	_menu_button_toggled(HOUSES)


func _on_infra_btn_toggled(button_pressed: bool) -> void:
	_menu_button_toggled(INFRASTRUCTURE)


func _on_wooden_house_button_up() -> void:
	instantiate_selector_for("buildings", "house")
	print("Place wooden house")


func _on_stone_house_button_up() -> void:
	instantiate_selector_for("buildings", "house")
	print("Place stone house")


func _on_dirt_road_button_up() -> void:
#	instantiate_selector_for("infrastructure", "dirt_road")
	print("Place dirt road")
