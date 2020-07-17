extends StaticBody2D


var hp : int = 5

onready var pickup : PackedScene = preload("res://objects/pickups/pickup.tscn")
onready var anim_player : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	anim_player.playback_speed = 10


func on_death() -> void:
	drop_loot()
	queue_free()


func drop_loot() -> void:
	var wood = pickup.instance()
	wood.global_position = global_position
	
	var world = get_tree().current_scene
	world.add_child(wood)


func _on_hurtbox_hit(body : KinematicBody2D, dmg : int) -> void:
	hp -= dmg
	
	if hp <= 0:
		anim_player.play("death", 2)
