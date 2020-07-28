extends StaticBody2D


export(Resource) var data

onready var sprite : Sprite = $Sprite
onready var collider : CollisionShape2D = $CollisionShape2D
onready var area : CollisionShape2D = $HurtBox/CollisionShape2D


func _ready() -> void:
	if data:
		sprite.texture = data.sprite
#
#		collider.position = Global.TILE_SIZE * data.size / 2
#		collider.scale = data.size
#
#		area.position = Global.TILE_SIZE * data.size / 2
#		area.scale = data.size


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the House
	   Node
	"""
	return -$Sprite.position
