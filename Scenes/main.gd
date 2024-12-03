extends Node

@export var pipeScene : PackedScene

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
	screenSize = get_window().size
	groundHeight = $Ground.get_node("Sprite2D").texture.get_height()
	newGame()

func newGame():
	# Reset variables
	gameRunning = false
	gameOver = false
	scroll = 0 
	score = 0
	pipes.clear()
	$Bird.reset()
	# Generates first pipes
	generatePipes()

# Getting input to start game for the first time
func _input(event):
	if gameOver == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				startGame()
			else:
				if $Bird.flying:
					$Bird.flap()

# Starting game
func startGame():
	# Set variables
	gameRunning = true
	$Bird.flying = true
	$Bird.flap()
	# Start pipe timer
	$PipeTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameRunning:
		scroll += scrollSpeed
		# Reset scroll
		if scroll >= screenSize.x:
			scroll = 0
		# Move ground node
		$Ground.position.x = -scroll
		# Move pipes
		for pipe in pipes:
			pipe.position.x -= scrollSpeed

# Generating pipes based on the timer
func _on_pipe_timer_timeout() -> void:
	generatePipes()

# Randomly generated pipes
func generatePipes():
	var pipe = pipeScene.instantiate()
	 # Added delay so pipes don't just appear on screen
	pipe.position.x = screenSize.x + pipeDelay
	# Randomly generate heighted based on costant range defined
	pipe.position.y = (screenSize.y - groundHeight) / 2 + randi_range(-pipeRange, pipeRange) 
	# Connecting hit signal
	pipe.hit.connect(birdHit)
	# Adding and managing pipes in array 
	add_child(pipe)
	pipes.append(pipe)

func birdHit():
	pass
