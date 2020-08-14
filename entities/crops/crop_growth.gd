extends Area2D


export(Resource) var data
export(Resource) var crop_data

onready var sprite : Sprite = $CropSprite


func _ready() -> void:
	crop_data = load("res://entities/crops/resources/wheat.tres")
	
	if crop_data:
		sprite.texture = crop_data.sprite_sheet
		sprite.hframes = crop_data.get_growth_length_in_days()
		sprite.frame = 0
	
	var _err = WorldData.connect("new_day_commenced", self, "_on_new_day_commenced")


func _on_new_day_commenced() -> void:
	if sprite.frame + 1 < sprite.hframes:
		sprite.frame += 1


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the Crop
	   Node
	"""
	return -$CropSprite.position


func set_additional_placeable_data(data : Dictionary) -> void:
	"""Set additional data passed through from the 
	   build menu.
	"""
	crop_data = data.crop_resource
