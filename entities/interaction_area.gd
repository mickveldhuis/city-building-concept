extends Area2D


signal interacted(body)


func on_interact(body : KinematicBody2D) -> void:
	emit_signal("interacted", body)
