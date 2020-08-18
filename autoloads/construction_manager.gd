extends Node


var world : Node2D
var map : WorldMap


func _ready() -> void:
	world = get_tree().current_scene
	map = world.get_node("WorldMap")


func build(pos : Vector2, entity : int) -> void:
	var _tile_pos : Vector2 = map.world_to_map(pos)
	var _data : Resource = ResourceManager.placeable_resources[entity]
	var _err = map.set_cell_group(_tile_pos.x, _tile_pos.y, entity, _data.base_extent)
	
	if _err == 0:
		var factory : Node = ResourceManager.construction_factory.instance()
		var object : Node = factory.get_placeable(entity)
		var pos_offset : Vector2 = object.get_left_corner_position() - Vector2(0, _data.get_delta_y())
		
		object.set_position(pos + pos_offset)
		
		var world = get_tree().current_scene
		world.get_node("YSort/Placeables").add_child(object)
		
		var object_path : NodePath = object.get_path()
		map.set_cell_path(_tile_pos.x, _tile_pos.y, object_path)
		
	else:
		print("Cannot build @ ({x}, {y})".format({"x": pos.x, "y": pos.y}))


func build_from_map() -> void:
	pass
