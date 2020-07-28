extends Area2D


signal hurtbox_hit(body, dmg, type)


func on_hit(body : KinematicBody2D, dmg : int, type : int) -> void:
	emit_signal("hurtbox_hit", body, dmg, type)
