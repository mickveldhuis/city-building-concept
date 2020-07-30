extends MarginContainer


enum {
	NONE_SELECTED,
	HOUSES,
	INFRASTRUCTURE,
}

var selector_active : bool = false
var active_menu_btn : int = NONE_SELECTED

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
		toggle_disability_current_menu()
		selector_active = true
		
		var selector = ResourceManager.components["tile_selector"].instance()
		selector.set_placeable(cat, subcat)
		
		var world = get_tree().current_scene
		world.add_child(selector)


func free_selector() -> void:
	toggle_disability_current_menu()
	selector_active = false
	
	get_tree().current_scene.get_node("TileSelector").queue_free()


func place_object() -> void:
	var ts : Control = get_tree().current_scene.get_node("TileSelector")
	var location : Vector2 = ts.get_location()
	var data : Dictionary = ts.placeable_data
	
	if not ts.is_blocked():
		var object = ResourceManager.placeables[data.cat][data.subcat].instance()
		object.set_position(location + object.get_left_corner_position())
		
		var world = get_tree().current_scene
		world.get_node("YSort/Placeables").add_child(object)


func toggle_visibility() -> void:
	visible = !visible


func can_toggle(btn : int) -> bool:
	var allow_toggle : bool = true
	var none_toggled : bool = false
	
	for k in menu.keys():
		none_toggled = none_toggled or !menu[k].visible
		
		if k != btn and menu[k].visible:
			allow_toggle = false
	
	return (menu[btn].visible or none_toggled) and allow_toggle


func toggle_menu_visibility(btn : int) -> void:
	menu[btn].visible = !menu[btn].visible
		
	if active_menu_btn == btn:
		active_menu_btn = NONE_SELECTED
	else:
		active_menu_btn = btn


func disable_all_buttons_but(btn : int) -> void:
	for k in menu_buttons.keys():
		if k != btn:
			menu_buttons[k].disabled = !menu_buttons[k].disabled


func toggle_disability_current_menu() -> void:
	if active_menu_btn != NONE_SELECTED:
		for node in menu[active_menu_btn].get_children():
			if node is BaseButton:
				node.disabled = !node.disabled


func menu_button_toggled(btn : int) -> void:
	if can_toggle(btn):
		toggle_menu_visibility(btn)
		disable_all_buttons_but(btn)


func exit_build_menu() -> void:
	toggle_visibility()
	
	if selector_active:
		free_selector()


func _on_houses_btn_toggled(button_pressed: bool) -> void:
	menu_button_toggled(HOUSES)


func _on_infra_btn_toggled(button_pressed: bool) -> void:
	menu_button_toggled(INFRASTRUCTURE)


func _on_wooden_house_button_up() -> void:
	instantiate_selector_for("houses", "wood")


func _on_dirt_road_button_up() -> void:
#	instantiate_selector_for("infrastructure", "dirt_road")
	print("Place dirt road")


func _on_barn_button_up() -> void:
	instantiate_selector_for("buildings", "barn")
