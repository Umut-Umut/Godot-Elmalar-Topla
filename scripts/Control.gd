extends Control

func _process(_delta):
	if Input.is_key_pressed(82):
		get_tree().change_scene("res://scenes/world.tscn")


func _on_Button_pressed():
	get_tree().quit()
