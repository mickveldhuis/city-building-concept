extends HBoxContainer


onready var tool_rect : TextureRect = $ToolSlot/ToolIcon
onready var item_rect : TextureRect = $ItemSlot/ItemIcon
onready var item_counter : Label = $ItemSlot/ItemCounter


func _ready() -> void:
	item_counter.text = str(Inventory.get_item_count())
	Inventory.connect("item_count_modified", self, "_on_item_count_modified")
	Inventory.connect("tool_swapped", self, "_on_tool_swapped")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_tools"):
		Inventory.swap_tool()
	if Input.is_action_just_pressed("drop_item"):
		print("Dropping an item")


func _on_tool_swapped() -> void:
	tool_rect.texture = Inventory.current_tool.icon


func _on_item_dropped() -> void:
	pass

func _on_item_count_modified(amount : int) -> void:
	item_counter.text = str(amount)
