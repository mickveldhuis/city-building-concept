extends MarginContainer


onready var wood_counter : Label = $Panel/HBoxContainer/WoodCounter
onready var stone_counter : Label = $Panel/HBoxContainer/StoneCounter


func _ready() -> void:
	update_stats_bar()
	WorldData.connect("world_data_updated", self, "_on_world_data_updated")


func _on_world_data_updated() -> void:
	update_stats_bar()


func update_stats_bar() -> void:
	wood_counter.text = "Wood: %s" % str(WorldData.item_supply[Global.ItemType.WOOD])
	stone_counter.text = "Stone: %s" % str(WorldData.item_supply[Global.ItemType.STONE])
