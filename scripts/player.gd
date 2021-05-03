extends KinematicBody2D

# Move variables
var vel = Vector2()
var direction = Vector2()
var acceleration = 5
const MAX_SPEED = 300

var isDead = false  # World.gd

func _ready():
	pass


func _process(_delta):
	# Move
	if not isDead:
		controls()
	else:
		$Area2D/CollisionShape2D.disabled = true
	
	vel = move_and_slide(vel)


func controls():
	# RIGHT and LEFT
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_d"):
		vel.x = min(vel.x+acceleration, MAX_SPEED)
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_a"):
		vel.x = max(vel.x-acceleration, -MAX_SPEED)
	#else: vel.x = lerp(vel.x, 10, 0.2)
	
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_w"):
		vel.y = max(vel.y-acceleration, -MAX_SPEED)
	elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_s"):
		vel.y = min(vel.y+acceleration, MAX_SPEED)
	#else: vel.y = lerp(vel.y, 10, 0.2)
