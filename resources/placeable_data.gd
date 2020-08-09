extends Resource

class_name PlaceableData


export(String) var name = "building"
export(String) var description = "a building"
export(Global.PlaceableType) var type = Global.PlaceableType.BUILDING
export(Global.EntityType) var entity_id = Global.EntityType.EMPTY
export(Vector2) var size = Vector2.ZERO
export(Vector2) var base_extent = Vector2.ZERO
export(Texture) var sprite = null


func get_delta_y() -> int:
	return int(abs(size.y - base_extent.y)) * Global.TILE_SIZE
