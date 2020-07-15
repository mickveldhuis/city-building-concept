extends HBoxContainer


signal drop_item(item_type, amount)

onready var tool_rect : TextureRect = $ToolSlot/Tool
onready var item_rect : TextureRect = $ItemSlot/Item


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_tool"):
		pass
	if Input.is_action_just_pressed("drop_item"):
		pass


func change_tool() -> void:
	pass


func drop_item() -> void:
	pass
