extends Area2D


signal door_entered(body)


func on_interact(body : KinematicBody2D) -> void:
	emit_signal("door_entered", body)
