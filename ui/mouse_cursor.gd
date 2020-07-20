extends Node2D

onready var action_icon : Sprite = $ActionIcon
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	action_icon.texture = Inventory.current_tool.icon
	Inventory.connect("tool_swapped", self, "_on_tool_swapped")


func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("attack"):
		anim_player.play("use_tool")


func _on_tool_swapped() -> void:
	action_icon.texture = Inventory.current_tool.icon
