extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export (NodePath) var respawnPoint

var velocity = Vector2.ZERO

func _ready():
	respawnPoint = get_node(respawnPoint)


func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right2"):
		dir += 1
		get_node( "Player Blue" ).set_flip_h( false )
	if Input.is_action_pressed("walk_left2"):
		get_node( "Player Blue" ).set_flip_h( true )
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump2"):
		if is_on_floor():
			velocity.y = jump_speed



		








func _on_RespawnBoxBlue_body_entered(body):
	if body == self:
		global_position = respawnPoint.global_position
