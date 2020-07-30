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
	"buildings": {
		"barn": preload("res://entities/buildings/barn.tscn"),
	},
	"houses": {
		"wood": preload("res://entities/buildings/house.tscn"),
	},
	"infrastructure": {
		
	},
}
onready var placeable_sprites = {
	"buildings": {
		"barn": preload("res://entities/buildings/assets/barn.png"),
	},
	"houses": {
		"wood": preload("res://entities/buildings/assets/house_wood.png"),
	},
	"infrastructure": {
		
	},
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
