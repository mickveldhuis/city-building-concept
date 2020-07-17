extends HBoxContainer


onready var tool_rect : TextureRect = $ToolSlot/ToolIcon
onready var item_rect : TextureRect = $ItemSlot/ItemIcon
onready var item_counter : Label = $ItemSlot/ItemCounter


func _ready() -> void:
	item_counter.text = str(Inventory.get_item_count())
	Inventory.connect("item_count_modified", self, "_on_item_count_modified")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_tool"):
		pass
	if Input.is_action_just_pressed("drop_item"):
		pass


func _on_tool_swapped() -> void:
	pass


func _on_item_dropped() -> void:
	pass

func _on_item_count_modified(amount : int) -> void:
	item_counter.text = str(amount)
