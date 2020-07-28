extends StaticBody2D


export(int) var hp = 5

var log_dispersion : Vector2 = Vector2(hp, 3*hp)
var pos_dispersion : int = 30

onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var hit_sound : AudioStreamPlayer2D = $HitSound


func _ready() -> void:
	anim_player.playback_speed = 10


func on_death() -> void:
	drop_loot()
	queue_free()


func drop_loot() -> void:
	var num_logs : int = int(rand_range(log_dispersion.x, log_dispersion.y))
	
	for _n in range(num_logs):
		var disp = int(rand_range(-pos_dispersion, pos_dispersion))
		var log_x : int = int(rand_range(-disp, disp))
		var log_y : int = int(rand_range(-disp, disp))
		var pos_disp : Vector2 = Vector2(log_x, log_y)
		
		var wood = ResourceManager.pickups[Global.ItemType.WOOD].instance()
		wood.global_position = global_position + pos_disp
		
		var world = get_tree().current_scene
		world.get_node("YSort/Pickups").add_child(wood)


func _on_hurtbox_hit(body : KinematicBody2D, dmg : int, type : int) -> void:
	if type == Global.ToolType.AXE:
		hit_sound.play()
		hp -= dmg
	
	if hp <= 0:
		anim_player.play("death", 2)
