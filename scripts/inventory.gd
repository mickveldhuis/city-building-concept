extends Node

signal item_count_modified(amount)
signal tool_swapped

onready var tools = {
	"axe": load("res://objects/inventory/tools/axe.tres"),
	"pickaxe": load("res://objects/inventory/tools/pickaxe.tres"),
}

#onready var pickaxe : BaseTool = load("res://objects/inventory/tools/pickaxe.tres")
#onready var axe : BaseTool = load("res://objects/inventory/tools/axe.tres")
onready var current_tool : BaseTool = tools["axe"]

onready var wood : BaseItem = load("res://objects/inventory/items/wood.tres")
onready var current_item : BaseItem = wood


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


func swap_tool() -> void:
	match current_tool.name:
		"axe":
			current_tool = tools["pickaxe"]
		"pickaxe":
			current_tool = tools["axe"]
	
	emit_signal("tool_swapped")


func get_item_count() -> int:
	if not current_item:
		return 0
	
	return current_item.amount
