extends Node2D


export(Resource) var data
export(Resource) var crop
export(int) var daily_target = 0

var is_planted : bool = false
var has_seed : bool = true
var daily_progress : int = 0

onready var sprite : Sprite = $CropSprite
onready var placeable_tile_map : TileMap = get_tree().current_scene.get_node("BackgroundPlaceables")

func _ready() -> void:
	_init_tilted_soil()
	WorldData.connect("new_day_commenced", self, "_on_new_day_commenced")


func _init_tilted_soil() -> void:
	var map_pos : Vector2 = placeable_tile_map.world_to_map(global_position)
	placeable_tile_map.set_cellv(map_pos, 1)


func _destruct_tilted_soil() -> void:
	var map_pos : Vector2 = placeable_tile_map.world_to_map(global_position)
	placeable_tile_map.set_cellv(map_pos, -1)


func _is_crop_fully_grown() -> bool:
	return sprite.frame + 1 < sprite.hframes


func _on_new_day_commenced() -> void:
	if has_seed and daily_progress >= daily_target and _is_crop_fully_grown():
		sprite.frame += 1


func plant_seed() -> void:
	# initiate growth!
	if crop:
		sprite.texture = crop.sprite_sheet
		sprite.hframes = crop.get_growth_length_in_days()
		sprite.frame = 0
	
	has_seed = true


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
	plant_seed()


func _on_hurtbox_hit(body, dmg, type) -> void:
	if type == Global.ToolType.HOE and has_seed:
		daily_progress += dmg


func _on_hurtbox_interaction(body) -> void:
	if _is_crop_fully_grown():
		# DROP CROP
		pass
