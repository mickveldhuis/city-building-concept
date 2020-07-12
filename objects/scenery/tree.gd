extends StaticBody2D

var hp : int = 5

onready var anim_player : AnimationPlayer = $AnimationPlayer

func on_hit(dmg : int) -> void:
	hp -= dmg
	
	if hp <= 0:
		anim_player.play("death")

func on_death() -> void:
	queue_free()
