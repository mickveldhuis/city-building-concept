extends Node

onready var sprites = {
	"mouse_default": preload("res://ui/mouse/assets/cursor.png"),
	"selector_ok": preload("res://ui/build_menu/assets/selector_green.png"),
	"selector_error": preload("res://ui/build_menu/assets/selector_red.png"),
}
onready var components = {
	"tile_selector": preload("res://ui/build_menu/tile_selector.tscn"),
}
onready var placeables = {
	Global.EntityType.BARN:preload("res://entities/buildings/barn.tscn"),
	Global.EntityType.HOUSE: preload("res://entities/buildings/house.tscn"),
}
onready var placeable_resources = {
	Global.EntityType.BARN:preload("res://entities/buildings/resources/barn.tres"),
	Global.EntityType.HOUSE: preload("res://entities/buildings/resources/house.tres"),
}
onready var placeable_sprites = {
	Global.EntityType.BARN: preload("res://entities/buildings/assets/barn.png"),
	Global.EntityType.HOUSE: preload("res://entities/buildings/assets/house.png"),
}
onready var tools = {
	Global.ToolType.AXE: preload("res://ui/inventory/resources/tools/axe.tres"),
	Global.ToolType.PICKAXE: preload("res://ui/inventory/resources/tools/pickaxe.tres"),
}
onready var items = {
	Global.ItemType.EMPTY: preload("res://ui/inventory/resources/items/empty_item.tres"),
	Global.ItemType.WOOD: preload("res://ui/inventory/resources/items/wood.tres"),
	Global.ItemType.STONE: preload("res://ui/inventory/resources/items/stone.tres"),
}
onready var pickups = {
	Global.ItemType.WOOD: preload("res://entities/pickups/wood_pickup.tscn"),
	Global.ItemType.STONE: preload("res://entities/pickups/stone_pickup.tscn"),
}
