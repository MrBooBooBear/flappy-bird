extends Node

var gameRunning : bool
var gameOver : bool
var scroll
var score
const scrollSpeed : int = 4
var screenSize : Vector2i
var groundHeight : int
var pipes : Array
const pipeDelay : int = 100
const pipeRange : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newGame()

func newGame():
	#reset variables
	gameRunning = false
	gameOver = false
	scroll = 0 
	score = 0
	$Bird.reset()

func _input(event):
	if gameOver == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				startGame()
			else:
				if $Bird.flying:
					$Bird.flap()

func startGame():
	gameRunning = true
	$Bird.flying = true
	$Bird.flap()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
