extends Node


func get_placeable(entity : int) -> Node:
	var idx : int = _get_idx_from_entity_type(entity)
	return get_child(idx).duplicate()


func _get_idx_from_entity_type(entity : int) -> int:
	var idx : int
	
	match entity:
		Global.EntityType.HOUSE:
			idx = 0
		
		Global.EntityType.BARN:
			idx = 1
		
		Global.EntityType.CROP:
			idx = 2
	
	return idx
