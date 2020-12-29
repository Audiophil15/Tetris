extends Control

# "Classe" abstraite pour toutes les pieces

var piece_board_size
var visual_right_side
var visual_left_side
var piece_board
var c
var cell = preload("res://Cell.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func create(type : String):
	if type == "T":
		c = Color(0,0,1)
		piece_board_size = 3
		piece_board = [[0,0,0], [c,c,c], [0,c,0]]


func down():
	$".".rect_position.y+=50

func left():
	$".".rect_position.x-=50
	clampPosition()

func right():
	$".".rect_position.x+=50
	clampPosition()
	
func clampPosition():
	var cellSize = 50
	var boardwidth = 500
	$".".rect_position.x = max(-visual_left_side*cellSize, $".".rect_position.x)
	$".".rect_position.x = min(boardwidth-visual_right_side*cellSize, $".".rect_position.x)
	
func rotateLeft(): #Sens direct
	var tmpBoard = piece_board.duplicate(true)
	for i in range(piece_board_size):
		for j in range(piece_board_size):
			tmpBoard[piece_board_size-1-j][i] =piece_board[i][j]
	piece_board = tmpBoard
	#Il faut appeler update() avant clampPosition, on verifie la position de la piece mise a jour
	update()
	clampPosition()
	
func rotateRight(): #Sens indirect
	var tmpBoard= piece_board.duplicate(true)
	for i in range(piece_board_size):
		for j in range(piece_board_size):
			tmpBoard[j][piece_board_size-1-i] =piece_board[i][j]
	piece_board = tmpBoard
	#Il faut appeler update() avant clampPosition, on verifie la position de la piece mise a jour
	update()
	clampPosition()

func update():
	var color
	var cellule
	var cellID
	visual_left_side = piece_board_size
	visual_right_side = 0
	for line in range(piece_board_size):
		for index in range(piece_board_size) :
			color = piece_board[line][index]
			cellID = "VBoxContainer/HBoxContainer%d/Cell%d" %[line+1, index+1]
			cellule = get_node(cellID)
			if typeof(color) == TYPE_INT :
				cellule.disable()
			else :
				# La cellule visuelle a des dimensions differentes de celles du tableau, il faut donc les utiliser elles plutot que celles du tableau
				visual_left_side = min(visual_left_side, index)
				visual_right_side = max(visual_right_side, index)
				cellule.enable(color)

	visual_right_side += 1 #Needs a +1 because it's at least 1 cell
