extends StaticBody2D


export(Resource) var data

enum PlaceableState {
	IN_CONSTRUCTION,
	BUILT,
}

var state : int = PlaceableState.IN_CONSTRUCTION
var construction_progress : int = 0

onready var sprite : Sprite = $Sprite
onready var hurtbox : Area2D = $Hurtbox
onready var interaction_area : Area2D = $InteractionArea

func _ready() -> void:
	if data:
		sprite.texture = data.sprite
	
	if state == PlaceableState.IN_CONSTRUCTION:
		sprite.modulate.a = 0.5
		interaction_area.monitorable = false


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the House
	   Node
	"""
	return -$Sprite.position


func _on_hurtbox_hit(body, dmg, type) -> void:
	if construction_progress >= 100:
		$Hurtbox.visible = false
		sprite.modulate.a = 1
		interaction_area.monitorable = true
		
		hurtbox.monitoring = false
		hurtbox.monitorable = false
		
		state = PlaceableState.BUILT
	
	if type == Global.ToolType.HAMMER and state == PlaceableState.IN_CONSTRUCTION:
		construction_progress += 50 #dmg
