extends Node

onready var sprites = {
	"mouse_default": preload("res://assets/ui/cursor.png"),
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
