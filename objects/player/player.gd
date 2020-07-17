extends KinematicBody2D

export(int) var speed = 70
export(int) var acceleration = 450
export(int) var friction = 300
export(int) var interaction_dist = 10
export(int) var tool_dmg = 2 

enum PlayerState {
	MOVE,
	ATTACK,
	ACTION,
}

enum ActionState {
	WOOD_CHOPPING,
	MINING,
	GATHERING,
}

var state: int = PlayerState.MOVE
var velocity: Vector2 = Vector2.ZERO

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var anim_tree: AnimationTree = $AnimationTree
onready var ray_cast : RayCast2D = $RayCast2D


func _process (delta):
	update_raycast_position()
	
	if Input.is_action_just_pressed("action"):
		interact(false)
	elif Input.is_action_just_pressed("attack"):
		interact(true)


func _physics_process(delta):
	match state:
		PlayerState.MOVE:
			move_state(delta)
		
		PlayerState.ATTACK:
			attack_state(delta)

		PlayerState.ACTION:
			action_state(delta)

	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector.length() != 0:
		anim_tree.set("parameters/idle/blend_position", input_vector)
		velocity = velocity.move_toward(speed * input_vector, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack"):
#		state = PlayerState.ATTACK
		pass
	
	if Input.is_action_just_pressed("action"):
#		state = PlayerState.ACTION
		pass

func attack_state(delta) -> void:
	pass


func action_state(delta) -> void:
	pass


func move() -> void:
	velocity = move_and_slide(velocity)


func interact(is_attack : bool) -> void:
	if ray_cast.is_colliding():
		if is_attack and ray_cast.get_collider().has_method("on_hit"):
			ray_cast.get_collider().on_hit(self, tool_dmg)
		elif not is_attack and ray_cast.get_collider().has_method("on_interact"):
			ray_cast.get_collider().on_interact(self)


func update_raycast_position() -> void:
	var mouse_dir = ray_cast.global_position - get_global_mouse_position()
	mouse_dir = mouse_dir.normalized()
	
	ray_cast.cast_to = mouse_dir * interaction_dist


func is_in_inventory(item_type : String) -> bool:
	# Check if the item that the player is picking up is in the inventory
	return true


func add_to_inventory(amount : int) -> void:
	print("picked up")
	Inventory.modify_item_count_by(amount)
