extends StaticBody2D


export(Resource) var data


var supply : Dictionary = {
	Global.ItemType.WOOD: 0,
	Global.ItemType.STONE: 0,
}


func add_to_supply() -> void:
	if Inventory.current_item.type != Global.ItemType.EMPTY:
		supply[Inventory.current_item.type] += Inventory.current_item.amount
		WorldData.modify_supply(Inventory.current_item.type, Inventory.current_item.amount)
		Inventory.empty_inventory()


func take_from_supply(type : int, amount : int) -> void:
	if Inventory.current_item.type == type:
		Inventory.modify_item_count_by(-amount)


func get_left_corner_position() -> Vector2:
	"""Return the negated sprite position to
	   correct for the zero point of the Node
	"""
	return -$Sprite.position


func _on_door_entered(body) -> void:
	add_to_supply()
