extends CanvasLayer

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func showScore(score, appleNum):
	$score.text = str(score, "/", appleNum)


func showLevel(level):
	$level.text = str("Seviye: ", level)


func showHealth(health):
	$health.text = str(health)


func showMsg(msg):
	$mesage.text = msg
	$Timer.start()


func _on_Timer_timeout():
	$mesage.text = ""
