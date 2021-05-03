extends KinematicBody2D


var vel = Vector2()
var rotationDegresVar
var rotationVar

func _ready():
	rotation_degrees = rotationDegresVar # World.gd => swap()
	
	$Timer.start()


func _process(_delta):
	vel = move_and_slide(vel)
	rotation_degrees += rotationVar


func delete(): # not use
	$AnimationPlayer.play("delete")


func playSwapAnimation():
	$AnimationPlayer.play("swap")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "delete":
		queue_free()


func _on_Timer_timeout():
	pass # Replace with function body.
