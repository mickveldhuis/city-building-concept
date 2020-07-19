extends Area2D

var _name : String = "wood"
var type : int = BaseItem.ItemType.WOOD
var amount : int = 1
var timer_wait_time : float = 1

var has_timer : bool = false
var timer_finished : bool = false
var timer : Timer


func _ready() -> void:
	if has_timer:
		create_timer(timer_wait_time)


func enable_timer() -> void:
	has_timer = true


func create_timer(wait_time : float) -> void:
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(wait_time)
	
	add_child(timer)
	
	timer.start()


func _on_body_entered(body: Node) -> void:
	if body.has_method("is_in_inventory") and body.has_method("add_to_inventory") \
	   and (not has_timer or timer.is_stopped()):
		if body.is_in_inventory(type) \
		   and Inventory.current_item.amount < Inventory.current_item.max_amount:
			body.add_to_inventory(amount)
			queue_free()
		elif Inventory.current_item.type == BaseItem.ItemType.EMPTY:
			Inventory.set_item(_name)
			body.add_to_inventory(amount)
			queue_free()
