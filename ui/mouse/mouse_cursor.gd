extends Node2D


onready var action_icon : Sprite = $ActionIcon
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Inventory.connect("tool_swapped", self, "_on_tool_swapped")
	
	configure_tool_animation()


func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("action"):
		anim_player.play("use_tool")


func _on_tool_swapped() -> void:
	configure_tool_animation()


func configure_tool_animation() -> void:
	# Set custom playback speed if the tool cooldown is different from the
	# animation its length
	var anim : Animation = anim_player.get_animation("use_tool")
	var custom_playback_speed : float = anim.length / Inventory.current_tool.cooldown
	
	anim_player.playback_speed = custom_playback_speed
	action_icon.texture = Inventory.current_tool.icon
	
