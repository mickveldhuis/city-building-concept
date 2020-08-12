extends Node


signal world_data_updated


var time : int = 0
var item_supply = {
	Global.ItemType.WOOD: 0,
	Global.ItemType.STONE: 0,
}


func modify_supply(type : int, amount : int) -> void:
	var updated_amount : int = item_supply[type] + amount
	
	if updated_amount >= 0:
		item_supply[type] = updated_amount
	else:
		item_supply[type] = 0
		push_error("The supply is negative!!!")
	
	emit_signal("world_data_updated")


func take_from_supply(type : int, amount : int) -> int:
	var updated_amount : int = item_supply[type] + amount
	
	if updated_amount < 0:
		modify_supply(type, -item_supply[type])
		return item_supply[type]
	
	modify_supply(type, -amount)
	emit_signal("world_data_updated")
	return amount
