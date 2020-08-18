extends Node2D


export(Resource) var data
export(Resource) var crop
export(int) var daily_target = 0


var is_planted : bool = false
var allow_growth : bool = true
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
	return sprite.frame >= sprite.hframes - 1


func _on_new_day_commenced() -> void:
	if crop and allow_growth and daily_progress >= daily_target and not _is_crop_fully_grown():
		sprite.frame += 1


func plant_seed() -> void:
	if crop:
		sprite.texture = crop.sprite_sheet
		sprite.hframes = crop.get_growth_length_in_days()
		sprite.frame = 0
	
	allow_growth = true
	is_planted = true


func reset_growth() -> void:
	sprite.frame = 0


func stop_growth() -> void:
	allow_growth = false


func remove_crop() -> void:
	crop = null
	sprite.texture = null
	is_planted = false


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


func drop_loot() -> void:
	var n : int = 4
	var pos_dispersion : int = 30
	
	for _n in range(n):
		var disp = int(rand_range(-pos_dispersion, pos_dispersion))
		var x : int = int(rand_range(-disp, disp))
		var y : int = int(rand_range(-disp, disp))
		var pos_disp : Vector2 = Vector2(x, y)
		
		var wheat : Area2D = ResourceManager.pickup.instance()
		wheat.global_position = global_position + pos_disp
		wheat.set_pickup_item(Global.ItemType.WHEAT)
		
		var world = get_tree().current_scene
		world.get_node("YSort/Pickups").add_child(wheat)


func _on_hurtbox_hit(body, dmg, type) -> void:
	if type == Global.ToolType.HOE and allow_growth:
		daily_progress += dmg


func _on_hurtbox_interaction(body) -> void:
	if is_planted and _is_crop_fully_grown() and Inventory.current_tool.type == Global.ToolType.HOE:
		drop_loot()
		reset_growth()
