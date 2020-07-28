extends Control


enum SelectorState {
	CLEAR,
	BLOCKED,
}

var state : int = SelectorState.CLEAR
var size : Vector2 = Vector2(1, 1) # Size in units of 16 pixels
var placeable_texture : Texture = null
var placeable_data : Dictionary = {
	cat = null,
	subcat = null,
}

onready var selector_rect : NinePatchRect = $SelectorRect
onready var area : Area2D = $SelectorRect/Area2D
onready var collision_shape : CollisionShape2D = $SelectorRect/Area2D/CollisionShape2D
onready var placeable_sprite : Sprite = $PlaceableSprite

func _ready() -> void:
	init_selector()


func _process(delta: float) -> void:
	move_rect(get_global_mouse_position())
	
	if area.get_overlapping_areas().empty() and area.get_overlapping_bodies().empty():
		selector_rect.texture = ResourceManager.sprites["selector_ok"]
		state = SelectorState.CLEAR
	else:
		selector_rect.texture = ResourceManager.sprites["selector_error"]
		state = SelectorState.BLOCKED


func move_rect(pos : Vector2) -> void:
	var remainder_x : int = int(fmod(pos.x, Global.TILE_SIZE))
	var remainder_y : int = int(fmod(pos.y, Global.TILE_SIZE))
	
	rect_position.x = int(pos.x) - remainder_x
	rect_position.y = int(pos.y) - remainder_y


func update_rect_size() -> void:
	if Input.is_action_just_pressed("ui_right"):
		selector_rect.rect_size.x += Global.TILE_SIZE
		collision_shape.position.x += Global.TILE_SIZE / 2
		collision_shape.scale.x += 1
	if Input.is_action_just_pressed("ui_left") and selector_rect.rect_size.x > 16:
		selector_rect.rect_size.x -= Global.TILE_SIZE
		collision_shape.position.x -= Global.TILE_SIZE / 2
		collision_shape.scale.x -= 1

	if Input.is_action_just_pressed("ui_down"):
		selector_rect.rect_size.y += Global.TILE_SIZE
		collision_shape.position.y += Global.TILE_SIZE / 2
		collision_shape.scale.y += 1
	if Input.is_action_just_pressed("ui_up") and selector_rect.rect_size.y > 16:
		selector_rect.rect_size.y -= Global.TILE_SIZE
		collision_shape.position.y -= Global.TILE_SIZE / 2
		collision_shape.scale.y -= 1


func get_location() -> Vector2:
	return rect_position


func set_placeable(cat : String, subcat : String) -> void:
	size = Vector2(3, 3)
	placeable_texture = ResourceManager.placeable_sprites[cat][subcat]
	placeable_data.cat = cat
	placeable_data.subcat = subcat


func init_selector() -> void:
	var w : int = size.x * Global.TILE_SIZE
	var h : int = size.y * Global.TILE_SIZE
	
	selector_rect.rect_size.x = w
	collision_shape.position.x = w / 2
	collision_shape.scale.x = size.x
	
	selector_rect.rect_size.y = h
	collision_shape.position.y = h / 2
	collision_shape.scale.y = size.y
	
	rect_position = get_global_mouse_position()
	
	if placeable_texture:
		placeable_sprite.texture = placeable_texture


func is_blocked() -> bool:
	return state == SelectorState.BLOCKED
