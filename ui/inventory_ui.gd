extends HBoxContainer


onready var tool_rect : TextureRect = $ToolSlot/ToolIcon
onready var item_rect : TextureRect = $ItemSlot/ItemIcon
onready var item_counter : Label = $ItemSlot/ItemCounter


func _ready() -> void:
	item_counter.text = str(Inventory.get_item_count())
	item_rect.texture = Inventory.current_item.icon
	
	Inventory.connect("item_count_modified", self, "_on_item_count_modified")
	Inventory.connect("item_type_changed", self, "_on_item_type_changed")
	Inventory.connect("tool_swapped", self, "_on_tool_swapped")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_tools"):
		Inventory.swap_tool()
	if Input.is_action_just_pressed("drop_item") \
	   and Inventory.current_item.type != Global.ItemType.EMPTY:
		Inventory.drop_items()
	
	if Inventory.current_item.type == Global.ItemType.EMPTY:
		item_counter.text = ""


func _on_tool_swapped() -> void:
	tool_rect.texture = Inventory.current_tool.icon


func _on_item_type_changed() -> void:
	item_rect.texture = Inventory.current_item.icon


func _on_item_count_modified() -> void:
	item_counter.text = str(Inventory.get_item_count())
