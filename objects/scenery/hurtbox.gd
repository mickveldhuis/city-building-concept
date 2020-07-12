extends Area2D


signal hurtbox_hit(body, dmg)


func on_hit(body : KinematicBody2D, dmg : int) -> void:
	emit_signal("hurtbox_hit", body, dmg)
