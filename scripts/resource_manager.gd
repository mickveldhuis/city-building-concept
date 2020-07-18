extends Node

onready var tools = {
	"axe": load("res://objects/inventory/tools/axe.tres"),
	"pickaxe": load("res://objects/inventory/tools/pickaxe.tres"),
}
onready var items = {
	"empty": load("res://objects/inventory/items/empty_item.tres"),
	"wood": load("res://objects/inventory/items/wood.tres"),
}
onready var pickups = {
	"wood": preload("res://objects/pickups/pickup.tscn"),
}
