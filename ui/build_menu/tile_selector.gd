extends Control


enum SelectorState {
	CLEAR,
	BLOCKED,
}

enum SelectorType {
	PLACEABLE,
	RESOURCE,
}

var state : int = SelectorState.CLEAR
var type : int = SelectorType.PLACEABLE
var size : Vector2 = Vector2(1, 1) # Size in units of 16 pixels
var placeable_texture : Texture = null
var placeable_data : Dictionary = {
	entity = null,
	base_extent = null,
	size = null,
	delta_y = null,
	resource = null,
}

onready var selector_rect : NinePatchRect = $SelectorRect
onready var placeable_rect : TextureRect = $PlaceableRect


func _ready() -> void:
	init_selector()


func _process(_delta: float) -> void:
	_move_rect(get_global_mouse_position())
	_update_selector_state()


func _update_selector_state(is_placing_resource : bool = false, entity: int = 0) -> void:
	var tile_pos : Vector2  = ConstructionManager.map.world_to_map(rect_position)
	var is_blocked : bool 
	
	if is_placing_resource:
		ConstructionManager.map.do_cells_contain(tile_pos.x, tile_pos.y, placeable_data.base_extent.x, 
									placeable_data.base_extent.y, entity)
	else:
		is_blocked = ConstructionManager.map.are_cells_empty(tile_pos.x, tile_pos.y, 
						placeable_data.base_extent.x, placeable_data.base_extent.y)
	
	if is_blocked:
		selector_rect.texture = ResourceManager.sprites["selector_error"]
		state = SelectorState.BLOCKED
	else:
		selector_rect.texture = ResourceManager.sprites["selector_ok"]
		state = SelectorState.CLEAR


func _move_rect(pos : Vector2) -> void:
	var remainder_x : int = int(fmod(pos.x, Global.TILE_SIZE))
	var remainder_y : int = int(fmod(pos.y, Global.TILE_SIZE))
	
	rect_position.x = int(pos.x) - remainder_x
	rect_position.y = int(pos.y) - remainder_y


func update_rect_size() -> void:
	if Input.is_action_just_pressed("ui_right"):
		selector_rect.rect_size.x += Global.TILE_SIZE
	if Input.is_action_just_pressed("ui_left") and selector_rect.rect_size.x > 16:
		selector_rect.rect_size.x -= Global.TILE_SIZE

	if Input.is_action_just_pressed("ui_down"):
		selector_rect.rect_size.y += Global.TILE_SIZE
	if Input.is_action_just_pressed("ui_up") and selector_rect.rect_size.y > 16:
		selector_rect.rect_size.y -= Global.TILE_SIZE


func get_location() -> Vector2:
	return rect_position


func set_placeable(entity : int) -> void:
	var _data : Resource = ResourceManager.placeable_resources[entity]
	
	placeable_data.entity = entity
	placeable_data.base_extent = _data.base_extent
	placeable_data.size = _data.size
	placeable_data.delta_y = Global.TILE_SIZE * int(abs(_data.size.y - _data.base_extent.y))
	
	placeable_texture = ResourceManager.placeable_sprites[entity]
	size = _data.base_extent

func set_placeable_resource(resource : Resource) -> void:
	placeable_data.resource = resource
	placeable_data.entity = null
	placeable_data.base_extent = Vector2.ONE
	placeable_data.size = Vector2.ONE
	placeable_data.delta_y = 0
	
	placeable_texture = resource.icon
	size = placeable_data.base_extent


func init_selector() -> void:
	var base_size : Vector2 = ConstructionManager.map.map_to_world(size)
	
	selector_rect.rect_size = base_size
	rect_position = get_global_mouse_position()
	
	if placeable_texture:
		placeable_rect.texture = placeable_texture
		placeable_rect.rect_position.y -= placeable_data.delta_y


func is_blocked() -> bool:
	return state == SelectorState.BLOCKED
