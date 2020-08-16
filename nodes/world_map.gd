extends Node

class_name WorldMap


signal map_updated

export(int) var width = 40 # Width in number of tiles
export(int) var height = 25 # Height in number of tiles
export(int) var tile_size = Global.TILE_SIZE

var map : Array # 2D array of tiles

const TILE_DIRECTIONS : Array = ["left", "right", "top", "bottom"]

enum Error {
	OK,
	FAILED,
}

class Tile:
	var is_unique : bool
	var node_path : NodePath
	var position : Vector2
	var has_left_group_neighbor : bool = false
	var has_right_group_neighbor : bool = false
	var has_top_group_neighbor : bool = false
	var has_bottom_group_neighbor : bool = false
	var type : int = Global.EntityType.EMPTY
	
	
	func _init(tile_type : int, tile_pos : Vector2, is_persistable : bool = false) -> void:
		type = tile_type
		position = tile_pos
		is_unique = is_persistable # I.e. terrain (trees/rocks -> false) vs. houses (true) 
	
	
	func set_neighbors(left : bool = false, right : bool = false, top : bool = false, bottom : bool = false) -> void:
		has_left_group_neighbor = left
		has_right_group_neighbor = right
		has_top_group_neighbor = top
		has_bottom_group_neighbor = bottom
	
	
	func set_node_path(path : NodePath) -> void:
		node_path = path
	
	
	func get_tile_type() -> int:
		return type
	
	
	func get_node_path() -> NodePath:
		if not node_path:
			push_error("This Tile @ (x, y) = ({x_coord}, {y_coord} does not have a NodePath attached".format({
					"x_coord": 	position.x,
					"y_coord": 	position.y,
				}))
			
		return node_path
	
	
	func is_empty() -> bool:
		return type == Global.EntityType.EMPTY
	
	
	func get_group_neighbors() -> Dictionary:
		if type == Global.EntityType.EMPTY:
			push_warning("This is an empty tile! Cannot contain neighbors!")
		
		return {
			left = has_left_group_neighbor,
			right = has_right_group_neighbor,
			top = has_top_group_neighbor,
			bottom = has_bottom_group_neighbor,
		}


func _ready() -> void:
	_init_map_matrix()
#	set_cell(2, 2, Global.EntityType.HOUSE, {left = false, right = true, 
#											 top = false, bottom = true})
#	set_cell(3, 2, Global.EntityType.HOUSE, {left = true, right = false, 
#											 top = false, bottom = true})
#	set_cell(2, 3, Global.EntityType.HOUSE, {left = false, right = true, 
#											 top = true, bottom = false})
#	set_cell(3, 3, Global.EntityType.HOUSE, {left = true, right = false, 
#											 top = true, bottom = false})
#	_print_map()
#	set_cell_group(1, 1, Global.EntityType.FARM, Vector2(3, 3))
#	#reset_cell(2, 2)
#	_print_map()


func _init_map_matrix():
	map = []
	map.resize(width)
	for x in width:
		map[x] = []
		map[x].resize(height)
		
		for y in height:
			# Fill the map with empty tiles
			map[x][y] = Tile.new(Global.EntityType.EMPTY, Vector2(x, y))


func _is_cell_empty(x : int, y : int) -> bool:
	return map[x][y].is_empty()


func _is_within_bounds(x : int, y : int) -> bool:
	return x < width and y < height


func _print_map() -> void:
	"""
	Print the map in terms of tile (entity) types.
	"""
	print("Entity Map: ")
	
	for y in height:
		var row : Array = []
		for x in width:
			row.append(map[x][y].get_tile_type())
		
		print(row)
	
	print("\n")


func map_to_world(map_pos : Vector2) -> Vector2:
	var world_pos : Vector2 = map_pos * tile_size
	
	return world_pos


func world_to_map(world_pos : Vector2) -> Vector2:
	var map_pos : Vector2 = Vector2.ZERO
	
	map_pos.x = int(world_pos.x) / tile_size
	map_pos.y = int(world_pos.y) / tile_size
	
	return map_pos


func set_cell(x : int, y : int, tile_type : int, neighbor_info : Dictionary = {}) -> int:
	if tile_type != Global.EntityType.EMPTY and not (tile_type in Global.STATELESS_ENTITIES):
		var new_tile : Tile = Tile.new(tile_type, Vector2(x, y), true)
		
		if neighbor_info.has_all(TILE_DIRECTIONS):
			new_tile.set_neighbors(neighbor_info.left, neighbor_info.right,
								neighbor_info.top, neighbor_info.bottom)
		
		map[x][y] = new_tile
		
		return Error.OK
	elif tile_type != Global.EntityType.EMPTY:
		var new_tile : Tile = Tile.new(tile_type, Vector2(x, y), false)
		
		if neighbor_info.has_all(TILE_DIRECTIONS):
			new_tile.set_neighbors(neighbor_info.left, neighbor_info.right,
								neighbor_info.top, neighbor_info.bottom)
		
		map[x][y] = new_tile
		
		return Error.OK
	
	return Error.FAILED


func set_cell_group(x : int, y : int, tile_type : int, group_extent : Vector2 = Vector2.ONE) -> int:
	var _end_pos : Vector2 = Vector2(x, y) + group_extent - Vector2.ONE
	
	# Check whether the tile group can be placed, note the minus 1 in the last statement
	# is to correct for the extent of the group
	if tile_type != Global.EntityType.EMPTY and _is_cell_empty(x, y) and _is_within_bounds(x, y) and _is_within_bounds(_end_pos.x, _end_pos.y):
		if not are_cells_empty(x, y, group_extent.x, group_extent.y):
			if group_extent == Vector2.ONE:
				set_cell(x, y, tile_type)
			else:
				var dir_l : bool = false
				var dir_r : bool = false
				var dir_t : bool = false
				var dir_b : bool = false
				
				for i in range(x, _end_pos.x + 1):
					dir_l = true if i > x else false
					dir_r = true if i < _end_pos.x else false
					
					for j in range(y, _end_pos.y + 1):
						dir_t = true if j > y else false 
						dir_b = true if j < _end_pos.y else false
						
						var _err : int = set_cell(i, j, tile_type, {left = dir_l, 
										right = dir_r, top = dir_t, bottom = dir_b})
			
			emit_signal("map_updated")
			return Error.OK
	
	return Error.FAILED

func are_cells_empty(x : int, y : int, w : int, h : int) -> bool:
	var _is_blocked : bool = false
	
	for i in range(x, x + w):
		for j in range(y, y + h):
			_is_blocked = _is_blocked or not _is_cell_empty(i, j)
	
	return _is_blocked


func is_cell_populated_by(x : int, y : int, entity : int) -> bool:
	var tile : Tile = get_cell_tile(x, y)
	return tile.type == entity


func do_cells_contain(x : int, y : int, w : int, h : int, entity : int) -> bool:
	var _contains_tile : bool = false
	
	for i in range(x, x + w):
		for j in range(y, y + h):
			var _is_same_tile : bool = is_cell_populated_by(x, y, entity)
			_contains_tile = _contains_tile or _is_same_tile
	
	return _contains_tile

func reset_cell(x : int, y : int) -> void:
	if map[x][y] and _is_cell_empty(x, y):
		# Get in which direction the tile has neighbors of a tile group (i.e. a house)
		var dirs : Dictionary = map[x][y].get_group_neighbors()
		
		# Delete the current cell, i.e. change the cell to an empty one
		map[x][y] = Tile.new(Global.EntityType.EMPTY, Vector2(x, y))
		
		if dirs.left:
			reset_cell(x - 1, y)
		
		if dirs.right:
			reset_cell(x + 1, y)
		
		if dirs.top:
			reset_cell(x, y - 1)
		
		if dirs.bottom:
			reset_cell(x, y + 1)


func get_cell_tile(x : int, y : int) -> Tile:
	if x >= width or y >= height or x < 0 or y < 0:
		push_error("The position (x, y) is out of bounds")
	
	return map[x][y]


func get_cell_node_path(x : int, y : int) -> NodePath:
	var tile : Tile = map[x][y]
	return tile.node_path


func set_cell_path(x : int, y : int, path : NodePath) -> void:
	if map[x][y]:
		# Get in which direction the tile has neighbors of a tile group (i.e. a house)
		var dirs : Dictionary = map[x][y].get_group_neighbors()
		
		# Set the current cell's node path
		map[x][y].set_node_path(path)
		
		if dirs.left:
			set_cell_path(x - 1, y, path)
		
		if dirs.right:
			set_cell_path(x - 1, y, path)
		
		if dirs.top:
			set_cell_path(x - 1, y, path)
		
		if dirs.bottom:
			set_cell_path(x - 1, y, path)
