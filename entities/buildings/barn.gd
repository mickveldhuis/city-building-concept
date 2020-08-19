extends StaticBody2D


export(Resource) var data
export(int) var max_supply_count = 50

enum PlaceableState {
	IN_CONSTRUCTION,
	BUILT,
}

var state : int = PlaceableState.IN_CONSTRUCTION
var construction_progress : int = 0
var supply : Dictionary = {
	Global.ItemType.WOOD: 0,
	Global.ItemType.STONE: 0,
	Global.ItemType.WHEAT: 0,
}

onready var resource_counter : Control = $ResourceCounter
onready var counter_label : Label = $ResourceCounter/CounterPanel/Counter
onready var sprite : Sprite = $Sprite
onready var hurtbox : Area2D = $Hurtbox
onready var door : Area2D = $Door


func _ready() -> void:
	resource_counter.visible = false
	_update_counter_label()
	
	if state == PlaceableState.IN_CONSTRUCTION:
		sprite.modulate.a = 0.5
		door.monitorable = false


func add_to_supply() -> void:
	if Inventory.current_item.type != Global.ItemType.EMPTY:
		var item_count : int = Inventory.current_item.amount
		var barn_space : int = _get_barn_space()
		
		if barn_space >= item_count:
			supply[Inventory.current_item.type] += item_count
			WorldData.modify_supply(Inventory.current_item.type, item_count)
			Inventory.empty_inventory()
			
		elif barn_space < item_count and barn_space > 0:
			supply[Inventory.current_item.type] = max_supply_count
			WorldData.modify_supply(Inventory.current_item.type, barn_space)
			Inventory.modify_item_count_by(-barn_space)
		
		_update_counter_label()


func take_from_supply(type : int, amount : int) -> void:
	if Inventory.current_item.type == type:
		Inventory.modify_item_count_by(-amount)


func _get_barn_reserve() -> int:
	var supply_count : int = 0
	
	for item_count in supply.values():
		supply_count += item_count
	
	return supply_count


func _get_barn_space() -> int:
	return max_supply_count - _get_barn_reserve()


func _update_counter_label() -> void:
	var current_count : int = _get_barn_reserve()
	counter_label.text = "{current}/{max}".format({"current": current_count, "max": max_supply_count})


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the Node
	"""
	return -$Sprite.position	


func _on_door_interacted(_body : KinematicBody2D):
	add_to_supply()


func _on_door_mouse_entered():
	if state == PlaceableState.BUILT:
		resource_counter.visible = true


func _on_door_mouse_exited():
	resource_counter.visible = false


func _on_hurtbox_hit(body, dmg, type) -> void:
	if construction_progress >= 100:
		$Hurtbox.visible = false
		sprite.modulate.a = 1
		door.monitorable = true
		
		hurtbox.monitoring = false
		hurtbox.monitorable = false
		
		resource_counter.visible = true
		
		state = PlaceableState.BUILT
	
	if type == Global.ToolType.HAMMER and state == PlaceableState.IN_CONSTRUCTION:
		construction_progress += 50 #dmg
