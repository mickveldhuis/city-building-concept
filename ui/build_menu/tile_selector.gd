extends Control


enum SelectorState {
	CLEAR,
	BLOCKED,
}

var state : int = SelectorState.CLEAR
var n_entered : int = 0 # How many bodies/areas have entered the tileselector

var size : Vector2 = Vector2(1, 1) # Size in units of 16 pixels
var placeable_texture : Texture = null
var placeable_data : Dictionary = {
	entity = null
}

onready var selector_rect : NinePatchRect = $SelectorRect
onready var area : Area2D = $SelectorRect/Area2D
onready var collision_shape : CollisionShape2D = $SelectorRect/Area2D/CollisionShape2D
onready var placeable_sprite : Sprite = $PlaceableSprite

func _ready() -> void:
	init_selector()


func _process(delta: float) -> void:
	move_rect(get_global_mouse_position())
	
	if n_entered > 0:
		selector_rect.texture = ResourceManager.sprites["selector_error"]
		state = SelectorState.BLOCKED
	else:
		selector_rect.texture = ResourceManager.sprites["selector_ok"]
		state = SelectorState.CLEAR


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


func set_placeable(entity : int) -> void:
	placeable_texture = ResourceManager.placeable_sprites[entity]
	size = placeable_texture.get_size() / Global.TILE_SIZE
	
	placeable_data.entity = entity


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


func _on_area_entered(area: Area2D) -> void:
	n_entered += 1


func _on_area_exited(area: Area2D) -> void:
	n_entered -= 1


func _on_body_entered(body: Node) -> void:
	n_entered += 1


func _on_body_exited(body: Node) -> void:
	n_entered -= 1
