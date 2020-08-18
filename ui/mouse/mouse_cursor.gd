extends Node2D


var is_anim_allowed : bool = false

onready var action_icon : Sprite = $ActionIcon
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Inventory.connect("tool_swapped", self, "_on_tool_swapped")
	Global.connect("enable_mouse_action", self, "_on_mouse_action_toggled", [true])
	Global.connect("disable_mouse_action", self, "_on_mouse_action_toggled", [false])
	
	action_icon.visible = false
	configure_tool_animation()


func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	
	if is_anim_allowed and Input.is_action_just_pressed("action"):
		pass
#		anim_player.play("use_tool")


func _on_tool_swapped() -> void:
	configure_tool_animation()
	pass


func configure_tool_animation() -> void:
	# Set custom playback speed if the tool cooldown is different from the
	# animation its length
	var anim : Animation = anim_player.get_animation("use_tool")
	var custom_playback_speed : float = anim.length / Inventory.current_tool.cooldown
	
	anim_player.playback_speed = custom_playback_speed
	action_icon.texture = Inventory.current_tool.icon
	


func _on_mouse_action_toggled(entity : int, enabled : bool) -> void:
	is_anim_allowed = not is_anim_allowed
#	action_icon.visible = not action_icon.visible
