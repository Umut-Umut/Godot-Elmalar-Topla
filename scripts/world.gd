extends Node2D

# New
var random = RandomNumberGenerator.new()

# Get scene
onready var appleScene = preload("res://scenes/apple.tscn")
onready var hud = preload("res://scenes/Hud.tscn").instance()

onready var eated = preload("res://scenes/eatedApple.tscn").instance()

# Variables
var images = [
	"res://images/apples/apple1.png",
	"res://images/apples/apple2.png",
	"res://images/apples/apple3.png",
	"res://images/apples/apple4.png",
	"res://images/apples/apple5.png",
	"res://images/apples/apple6.png",
	"res://images/apples/apple7.png",
	"res://images/apples/apple8.png",
	"res://images/apples/apple9.png",
	"res://images/apples/apple10.png",
]
var sounds = [
	"res://sounds/appleSong(1).wav",
	"res://sounds/appleSong(2).wav",
	"res://sounds/appleSong(3).wav",
	"res://sounds/appleSong(4).wav",
	"res://sounds/appleSong(5).wav",
	"res://sounds/appleSong(6).wav",
	"res://sounds/appleSong(7).wav",
	"res://sounds/appleSong(8).wav",
	"res://sounds/appleSong(9).wav",
	"res://sounds/appleSong(10).wav",
	"res://sounds/appleSong(11).wav",
	"res://sounds/appleSong(12).wav",
	"res://sounds/appleSong(13).wav",
	"res://sounds/appleSong(14).wav",
	"res://sounds/appleSong(15).wav",
	"res://sounds/appleSong(16).wav",
]
var apples = []
var eatedApples = []
var appleIns
var appleInPlace
var eatedApple


var appleNum = 10
var maxAppleNum = 300
var maxEatedAppleNum = 500

var xRange = 100
var yRange = 100

# Hud variables
var score = 0
var level = 1
var health = 100

# COUNTERS
var counter = 0
var counterSwap = 0
var counterIndex = 0
var counterDuplicate = 0
var SumApple = 0
var SumEatedApple = 0

var isStartHung = false
var deneme = [1, 2, 3, 4, 5, 6]
# MAIN BLOCK
func _ready():
	add_child(hud)
	
	hud.showScore(score, appleNum)
	hud.showLevel(level)
	hud.showHealth(health)

	random.randomize()

	for _i in range(100):
		createApple()
		
	$dup.start()


# FUCTIONS
func createApple():
	appleIns = appleScene.instance()
	
	# Set random sound to appleIns
	appleIns.get_node("sound").stream = load(
		sounds[random.randi_range(0, sounds.size()-1)]
	)
	
	# Set random image to appleIns
	appleIns.get_node("Sprite").texture = load(
		images[random.randi_range(0, images.size()-1)]
	)
	
	apples.append(appleIns)


func placeRandomPos(body):
	# Set radom position to appleInPlace
	var x = random.randi_range(-xRange, xRange)
	var y = random.randi_range(-yRange, yRange)
	body.position = Vector2(x, y)


func duplicateApple():
	if counterIndex >= 100:
		counterIndex = 0
	appleInPlace = apples[counterIndex].duplicate()
	counterIndex += 1
	
	placeRandomPos(appleInPlace)
	# Activate apple
	add_child(appleInPlace)
	appleInPlace.playCreateAnimation()


func swap(body):
	if SumEatedApple >= maxEatedAppleNum: # Eated apple clear
		eatedApples.front().delete()
		eatedApples.pop_front()
		
	eatedApple = eated.duplicate()
	eatedApple.position = body.position
	eatedApple.vel = body.vel
	# Rotation degres
	eatedApple.rotationDegresVar = body.rotationDegresVar
	eatedApple.rotationVar = body.rotationVar
	
	eatedApples.append(eatedApple)
	SumEatedApple += 1
	
	add_child(eatedApple)
	eatedApple.playSwapAnimation()


func reactive(body):
	body.playBackwards("create")


func addApple(body):
	if not isStartHung: # Hungry is start
		$hungry.start()
		isStartHung = true
	score += 1
	health += 1
	counter -= 1
	
	body.playSound()
	body.playAddAnimation()
	
	swap(body)
	
	hud.showHealth(health)
	hud.showScore(score, appleNum)
	
	checkWin()


func checkWin():
	if score >= appleNum:
		$hungry.stop()
		isStartHung = false
		
		level += 1
		hud.showLevel(level)
		hud.showMsg(str(level) + ".seviye")
		health += appleNum/2
		
		$Timer.start()


func _on_Timer_timeout():
	score = 0
	counterDuplicate = 0
	
	xRange *= 2
	yRange *= 2
	
	appleNum *= 2
	
	hud.showScore(score, appleNum)

#================== Check Is Dead =======================#
func _on_hungry_timeout():
	health -= 3
	if health <= 0:
		health = 0
		get_tree().change_scene("res://scenes/Dead Menu.tscn")

	hud.showHealth(health)


func _on_dup_timeout():
	if counter < maxAppleNum and counterDuplicate < appleNum:
		for _i in range(appleNum/10):
			duplicateApple()
			counterDuplicate += 1
			SumApple += 1
			counter += 1
