extends KinematicBody2D

export(int) var speed = 70
export(int) var acceleration = 450
export(int) var friction = 300

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

func attack_state(delta):
	pass


func action_state(delta):
	pass


func move():
	velocity = move_and_slide(velocity)
