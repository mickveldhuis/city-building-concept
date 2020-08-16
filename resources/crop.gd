extends Resource

class_name Crop


export(String) var name
export(Global.CropType) var type
export(Global.EntityType) var target_entity
export(Texture) var sprite_sheet
export(Texture) var icon
export(int) var growth_stage # in number of days


func get_growth_length_in_days() -> int:
	return sprite_sheet.get_width() / Global.TILE_SIZE


func is_fully_grown() -> bool:
	return growth_stage >= get_growth_length_in_days()


