extends Node


signal item_count_modified
signal item_type_changed
signal item_dropped
signal tool_swapped

onready var current_tool : BaseTool = ResourceManager.tools[Global.ToolType.AXE]
onready var current_item : BaseItem = ResourceManager.items[Global.ItemType.EMPTY]


func modify_item_count_by(n : int) -> void:
	var new_amount : int = current_item.amount + n
	
	if new_amount >= 0 and new_amount <= current_item.max_amount:
		current_item.amount = new_amount
	elif new_amount < 0:
		current_item.amount = 0
	else:
		current_item.amount = current_item.max_amount
	
	emit_signal("item_count_modified")


func empty_inventory() -> void:
	current_item.amount = 0
	set_item(Global.ItemType.EMPTY)


func drop_items() -> void:
	emit_signal("item_dropped")
	empty_inventory()


func swap_tool() -> void:
	match current_tool.type:
		Global.ToolType.AXE:
			set_tool(Global.ToolType.PICKAXE)
		Global.ToolType.PICKAXE:
			set_tool(Global.ToolType.HOE)
		Global.ToolType.HOE:
			set_tool(Global.ToolType.HAMMER)
		Global.ToolType.HAMMER:
			set_tool(Global.ToolType.AXE)


func get_item_count() -> int:
	if not current_item:
		return 0
	
	return current_item.amount


func set_tool(type : int) -> void:
	current_tool = ResourceManager.tools[type]
	emit_signal("tool_swapped")


func set_item(type : int) -> void:
	current_item = ResourceManager.items[type]
	emit_signal("item_type_changed")
