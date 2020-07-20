extends KinematicBody2D

export(int) var speed = 70
export(int) var acceleration = 450
export(int) var friction = 300
export(int) var interaction_dist = 10
export(int) var item_drop_radius = 40

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
onready var anim_state : AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")
onready var ray_cast : RayCast2D = $RayCast2D
onready var action_timer : Timer = $ActionTimer


func _ready() -> void:
	Inventory.connect("item_dropped", self, "_on_item_dropped")


func _process (delta):
	update_raycast_position()
	
	if Input.is_action_just_pressed("action"):
		interact(false)
	elif Input.is_action_just_pressed("attack") and action_timer.is_stopped():
		interact(true)
		action_timer.start(Inventory.current_tool.cooldown)


func _physics_process(delta):
	match state:
		PlayerState.MOVE:
			move_state(delta)
		
		PlayerState.ATTACK:
			attack_state(delta)

		PlayerState.ACTION:
			action_state(delta)

	
func move_state(delta : float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector.length() != 0:
		anim_tree.set("parameters/idle/blend_position", input_vector)
		anim_tree.set("parameters/walk/blend_position", input_vector)
		anim_state.travel("walk")
		velocity = velocity.move_toward(speed * input_vector, acceleration * delta)
	else:
		anim_state.travel("idle")
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


func interact(does_damage : bool = false) -> void:
	if ray_cast.is_colliding():
		if does_damage and ray_cast.get_collider().has_method("on_hit"):
			ray_cast.get_collider().on_hit(self, Inventory.current_tool.damage, 
												 Inventory.current_tool.type)
		elif not does_damage and ray_cast.get_collider().has_method("on_interact"):
			ray_cast.get_collider().on_interact(self)


func update_raycast_position() -> void:
	var mouse_dir = ray_cast.global_position - get_global_mouse_position()
	mouse_dir = mouse_dir.normalized()
	
	ray_cast.cast_to = mouse_dir * interaction_dist


func is_in_inventory(item_type : int) -> bool:
	var in_inv : bool = false
	if Inventory.current_item.type == item_type:
		in_inv = true
	
	return in_inv


func add_to_inventory(amount : int) -> void:
	Inventory.modify_item_count_by(amount)


func _on_item_dropped() -> void:
	for _n in range(Inventory.current_item.amount):
		var disp = int(rand_range(-item_drop_radius, item_drop_radius))
		var x : int = int(rand_range(-disp, disp))
		var y : int = int(rand_range(-disp, disp))
		var pos_disp : Vector2 = Vector2(x, y)

		var item = ResourceManager.pickups[Inventory.current_item.type].instance()
		item.enable_timer()
		item.global_position = global_position + pos_disp

		var world = get_tree().current_scene
		world.get_node("YSort/Pickups").add_child(item)
