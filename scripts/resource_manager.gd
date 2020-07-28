extends Node

onready var sprites = {
	"mouse_default": preload("res://assets/ui/cursor.png"),
	"selector_ok": preload("res://assets/ui/selector_green.png"),
	"selector_error": preload("res://assets/ui/selector_red.png"),
}
onready var components = {
	"tile_selector": preload("res://ui/tile_selector.tscn"),
}
onready var placeables = {
	"houses": {
		"wood": preload("res://objects/buildings/house.tscn"),
	},
	"infrastructure": {
		
	},
}
onready var placeable_sprites = {
	"houses": {
		"wood": preload("res://assets/house_wood.png"),
	},
	"infrastructure": {
		
	},
}
onready var tools = {
	Global.ToolType.AXE: preload("res://objects/inventory/tools/axe.tres"),
	Global.ToolType.PICKAXE: preload("res://objects/inventory/tools/pickaxe.tres"),
}
onready var items = {
	Global.ItemType.EMPTY: preload("res://objects/inventory/items/empty_item.tres"),
	Global.ItemType.WOOD: preload("res://objects/inventory/items/wood.tres"),
	Global.ItemType.STONE: preload("res://objects/inventory/items/stone.tres"),
}
onready var pickups = {
	Global.ItemType.WOOD: preload("res://objects/pickups/wood_pickup.tscn"),
	Global.ItemType.STONE: preload("res://objects/pickups/stone_pickup.tscn"),
}
