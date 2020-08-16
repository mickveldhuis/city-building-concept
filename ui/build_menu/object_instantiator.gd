extends Control


func place_object() -> void:
	var ts : Control = get_tree().current_scene.get_node("TileSelector")
	var location : Vector2 = ts.get_location()
	var data : Dictionary = ts.placeable_data
	
	ConstructionManager.build(location, data.entity)


func add_resource() -> void:
	var ts : Control = get_tree().current_scene.get_node("TileSelector")
	var pos : Vector2 = ts.get_location()
	var data : Dictionary = ts.placeable_data
	var tile_pos : Vector2 = ConstructionManager.map.world_to_map(pos)
	
	# USE set_node_path on the tile.... *facepalm*
	# Probably where the tile gets added to the map
	if not ts.is_blocked():
		var np : NodePath = ConstructionManager.map.get_cell_node_path(tile_pos.x, tile_pos.y)
		var node : Node = get_node(np)
		# Add resource to node
		if node.has_method("set_additional_resource_data"):
			node.set_additional_resource_data(data.resource)
		else:
			print("Node does not have function: set_additional_resource_data(...)")
	else:
		print("Cannot place resource @ ({x}, {y})".format({"x": pos.x, "y": pos.y}))
