extends Control


signal confirmed_selection(position)

var step_size : int = 16
var size : Vector2 = Vector2(1, 1) # Size in units of 16 pixels

onready var selector_rect : NinePatchRect = $SelectorRect
onready var area : Area2D = $SelectorRect/Area2D
onready var collision_shape : CollisionShape2D = $SelectorRect/Area2D/CollisionShape2D


func _ready() -> void:
	rect_position = get_global_mouse_position()


func _process(delta: float) -> void:
	move_rect(get_global_mouse_position())
	update_rect_size()
	
	if Input.is_action_just_pressed("action"):
		print("rect corner pos: ", rect_position.x, ", ", rect_position.y)
	
	if area.get_overlapping_areas().empty() and area.get_overlapping_bodies().empty():
		selector_rect.texture = ResourceManager.sprites["selector_ok"]
	else:
		selector_rect.texture = ResourceManager.sprites["selector_error"]


func move_rect(pos : Vector2) -> void:
	var remainder_x : int = int(fmod(pos.x, step_size))
	var remainder_y : int = int(fmod(pos.y, step_size))
	
	rect_position.x = int(pos.x) - remainder_x
	rect_position.y = int(pos.y) - remainder_y


func update_rect_size() -> void:
	if Input.is_action_just_pressed("ui_right"):
		selector_rect.rect_size.x += step_size
		collision_shape.position.x += step_size / 2
		collision_shape.scale.x += 1
	if Input.is_action_just_pressed("ui_left") and selector_rect.rect_size.x > 16:
		selector_rect.rect_size.x -= step_size
		collision_shape.position.x -= step_size / 2
		collision_shape.scale.x -= 1

	if Input.is_action_just_pressed("ui_down"):
		selector_rect.rect_size.y += step_size
		collision_shape.position.y += step_size / 2
		collision_shape.scale.y += 1
	if Input.is_action_just_pressed("ui_up") and selector_rect.rect_size.y > 16:
		selector_rect.rect_size.y -= step_size
		collision_shape.position.y -= step_size / 2
		collision_shape.scale.y -= 1
