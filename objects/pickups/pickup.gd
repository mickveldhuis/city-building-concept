extends Area2D

var type : String = "wood"
var amount : int = 1


func _on_body_entered(body: Node) -> void:
	if body.has_method("is_in_inventory") and body.has_method("add_to_inventory"):
		if body.is_in_inventory(type):
			body.add_to_inventory(amount)
			queue_free()
