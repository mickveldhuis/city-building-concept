extends Node


signal item_count_modified
signal item_type_changed
signal item_dropped
signal tool_swapped

onready var current_tool : BaseTool = ResourceManager.tools["axe"]
onready var current_item : BaseItem = ResourceManager.items["empty"]


func modify_item_count_by(n : int) -> void:
	var new_amount : int = current_item.amount + n
	
	if new_amount >= 0 and new_amount <= current_item.max_amount:
		current_item.amount = new_amount
	elif new_amount < 0:
		current_item.amount = 0
	else:
		current_item.amount = current_item.max_amount
	
	emit_signal("item_count_modified")


func drop_items() -> void:
	emit_signal("item_dropped")
	
	current_item.amount = 0
	set_item("empty")	


func swap_tool() -> void:
	match current_tool.name:
		"axe":
			set_tool("pickaxe")
		"pickaxe":
			set_tool("axe")


func get_item_count() -> int:
	if not current_item:
		return 0
	
	return current_item.amount


func set_tool(tool_name : String) -> void:
	current_tool = ResourceManager.tools[tool_name]
	emit_signal("tool_swapped")


func set_item(item_name : String) -> void:
	current_item = ResourceManager.items[item_name]
	emit_signal("item_type_changed")
