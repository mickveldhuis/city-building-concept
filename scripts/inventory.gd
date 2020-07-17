extends Node

signal item_count_modified(amount)

onready var axe : BaseTool = load("res://objects/inventory/tools/axe.tres")
onready var current_tool : BaseTool = axe setget set_tool, get_tool

onready var wood : BaseItem = load("res://objects/inventory/items/wood.tres")
onready var current_item : BaseItem = wood setget set_item, get_item


func modify_item_count_by(n : int) -> void:
	var new_amount : int = current_item.amount + n
	if new_amount >= 0 and new_amount <= current_item.max_amount:
		current_item.amount = new_amount
	elif new_amount < 0:
		current_item.amount = 0
	else:
		current_item.amount = current_item.max_amount
	
	emit_signal("item_count_modified", current_item.amount)


func drop_items() -> void:
	# TO DO: Remove the item from the slot and insert a blank resource
	current_item.amount = 0


func get_item_count() -> int:
	if not current_item:
		return 0
	
	return current_item.amount


func set_tool(next_tool : BaseTool) -> void:
	current_tool = next_tool


func get_tool() -> BaseTool:
	return current_tool


func set_item(item : BaseItem) -> void:
	current_item = item


func get_item() -> BaseItem:
	return current_item

