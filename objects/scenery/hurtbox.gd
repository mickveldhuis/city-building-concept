extends Area2D


signal hurtbox_hit(body, dmg, type)


func on_hit(body : KinematicBody2D, dmg : int, type : String) -> void:
	emit_signal("hurtbox_hit", body, dmg, type)
