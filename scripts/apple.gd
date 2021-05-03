extends KinematicBody2D

var random = RandomNumberGenerator.new()

var rotationVar
var rotationDegresVar
var vel = Vector2()

func _ready():
	random.randomize()
	
	rotationDegresVar = random.randi_range(-360, 360) # World.gd => swap()
	$Sprite.rotation_degrees = rotationDegresVar
	rotationVar = random.randf_range(-0.5, 0.5)

	vel.x = random.randf_range(-10, 10)
	vel.y = random.randf_range(-10, 10)


func _process(_delta):
	move()


func move():
	vel = move_and_slide(vel)
	$Sprite.rotation_degrees += rotationVar


func playSound():
	$sound.play()


func playCreateAnimation():
	$animation.play("create")
	

func playAddAnimation():
	$animation.play("add")


func _on_animation_animation_finished(anim_name):
	if anim_name == "add":
		queue_free()
