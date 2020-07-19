extends Node

onready var tools = {
	Global.ToolType.AXE: load("res://objects/inventory/tools/axe.tres"),
	Global.ToolType.PICKAXE: load("res://objects/inventory/tools/pickaxe.tres"),
}
onready var items = {
	Global.ItemType.EMPTY: load("res://objects/inventory/items/empty_item.tres"),
	Global.ItemType.WOOD: load("res://objects/inventory/items/wood.tres"),
}
onready var pickups = {
	Global.ItemType.WOOD: preload("res://objects/pickups/pickup.tscn"),
}
