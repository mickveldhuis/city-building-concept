extends StaticBody2D

var hp : int = 5

onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.playback_speed = 10


func on_death() -> void:
	queue_free()


func _on_hurtbox_hit(body : KinematicBody2D, dmg : int) -> void:
	hp -= dmg
	
	if hp <= 0:
		anim_player.play("death", 2)
