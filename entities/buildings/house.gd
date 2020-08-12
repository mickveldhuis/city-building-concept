extends StaticBody2D


export(Resource) var data


onready var sprite : Sprite = $Sprite
onready var collider : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	if data:
		sprite.texture = data.sprite


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the House
	   Node
	"""
	return -$Sprite.position
