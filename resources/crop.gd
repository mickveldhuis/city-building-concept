extends Resource

class_name Crop


export(String) var name
export(Texture) var sprite_sheet


func get_growth_length_in_days() -> int:
	return sprite_sheet.get_width() / Global.TILE_SIZE
