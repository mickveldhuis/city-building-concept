extends Area2D


export(Resource) var data
export(Resource) var crop

onready var sprite : Sprite = $CropSprite

onready var placeable_tile_map : TileMap = get_tree().current_scene.get_node("BackgroundPlaceables")


func _ready() -> void:
	crop = load("res://entities/crops/resources/wheat.tres")
	
	if crop:
		sprite.texture = crop.sprite_sheet
		sprite.hframes = crop.get_growth_length_in_days()
		sprite.frame = 0
	
	_init_tilted_soil()
	WorldData.connect("new_day_commenced", self, "_on_new_day_commenced")


func _init_tilted_soil() -> void:
	var map_pos : Vector2 = placeable_tile_map.world_to_map(global_position)
	placeable_tile_map.set_cellv(map_pos, 1)


func _destruct_tilted_soil() -> void:
	var map_pos : Vector2 = placeable_tile_map.world_to_map(global_position)
	placeable_tile_map.set_cellv(map_pos, -1)


func _on_new_day_commenced() -> void:
	if crop and sprite.frame + 1 < sprite.hframes:
		sprite.frame += 1


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the Crop
	   Node
	"""
	return -$CropSprite.position


func set_additional_resource_data(res_data : Resource) -> void:
	"""Set additional data passed through from the 
	   build menu.
	"""
	crop = res_data
