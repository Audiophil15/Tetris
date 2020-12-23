extends Control

var board_size
var visual_right_side
var visual_left_side
var board
var c
var cell = preload("res://Cell.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func create(type : String):
#	var instance = cell.instance()
	if type == "T":
		c = Color(0,0,1)
		board_size = 3
		board = [[0,0,0], [c,c,c], [0,c,0]]
	
#	update()
#	$".".add_child(VBoxContainer.new())
#	$VboxContainer.add_child(HBoxContainer.new())
#	$VBoxContainer/HboxContainer.name = "Line1"
#	$VBoxContainer/HboxContainer.add_child(instance)
#	$VBoxContainer/HboxContainer/Cell.name = "Cell1"
#	for i in range(board_size-1):
#		$VBoxContainer/HboxContainer/Cell.duplicate()
#	for i in range(board_size-1):
#		$VBoxContainer/HBoxContainer.duplicate()
	
	
	
func down():
	$".".rect_position.y+=50

func left():
	$".".rect_position.x-=50
	clampPosition()

func right():
	$".".rect_position.x+=50
	clampPosition()
	
func clampPosition():
	$".".rect_position.x = max(-visual_left_side*50, $".".rect_position.x)
	$".".rect_position.x = min(500-visual_right_side*50, $".".rect_position.x)
	
func rotateLeft(): #Sens direct
	var tmpBoard = board.duplicate(true)
	for i in range(board_size):
		for j in range(board_size):
			tmpBoard[board_size-1-j][i] = board[i][j]
	board = tmpBoard
	update()
	clampPosition()
	
func rotateRight(): #Sens indirect
	var tmpBoard = board.duplicate(true)
	for i in range(board_size):
		for j in range(board_size):
			tmpBoard[j][board_size-1-i] = board[i][j]
	board = tmpBoard
	update()
	clampPosition()

func update():
	var color
	var cellule
	var cellID
	visual_left_side = board_size
	visual_right_side = 0
	for line in range(board_size):
		for index in range(board_size) :
			color = board[line][index]
			cellID = "VBoxContainer/HBoxContainer%d/Cell%d" %[line+1, index+1]
			cellule = get_node(cellID)
			if typeof(color) == TYPE_INT :
				cellule.disable()
			else :
				# La cellule visuelle a des dimensions differentes de celles du tableau, il faut donc les utiliser elles plutot que celles du tableau
#				print(line, index) #debug
				visual_left_side = min(visual_left_side, index)
				visual_right_side = max(visual_right_side, index)
#				print(visual_left_side, visual_right_side) #debug
				cellule.enable(color)
	visual_right_side += 1 #Needs a +1 because it's at least 1 cell
