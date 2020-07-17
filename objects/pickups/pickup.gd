extends Area2D

var type : String = "wood"
var amount : Vector2 = Vector2(5, 10)


func _on_body_entered(body: Node) -> void:
	if body.has_method("is_in_inventory") and body.has_method("add_to_inventory"):
		if body.is_in_inventory(type):
			body.add_to_inventory(int(rand_range(amount.x, amount.y)))
			queue_free()
