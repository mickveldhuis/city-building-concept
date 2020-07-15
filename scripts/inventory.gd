extends Node

onready var axe : BaseTool = load("res://objects/inventory/tools/axe.tres")
onready var current_tool : BaseTool = axe

onready var wood : BaseItem = load("res://objects/inventory/items/wood.tres")
onready var current_item : BaseItem = null
