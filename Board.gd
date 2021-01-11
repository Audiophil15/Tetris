extends Control

var lines_to_delete = []
var board = []
var width = 10
var height = 20
var piece
var next_piece
var piece_names = ["T", "L", "I", "O", "S", "Z"]

# Called when the node enters the scene tree for the first time.
func _ready():
	create_board()
	updateCells()
#	pieceFell()
	
	self.new_piece()

func new_piece():
	piece = load("res://"+ piece_names[randi()%len(piece_names)] +".tscn").instance()
	$".".add_child(piece)

func create_board():
	for i in range(height):
		board.append([])
		for j in range (width):
			board[i].append(0)
	board.append([])

func get_board():
	return board
	
func land_piece(left_id : int, up_id : int, other_board : Array):
	var color
	for line in range(len(other_board)):
		for index in range(len(other_board[0])) :
			color = other_board[line][index]
			if typeof(color) != TYPE_INT:
				board[up_id + line][left_id + index] = color
	piece.queue_free()
	self.updateCells()
	pieceFell()
	self.new_piece()

func is_on_soil(left_id : int, up_id : int, other_board : Array) -> bool:
	var empty
	var cell
	var cellID
	for line in range(len(other_board)):
		for index in range(len(other_board[0])) :
			empty = typeof(other_board[line][index]) == TYPE_INT
			if not empty:
				if up_id + line >= height-1:
					return true
				if typeof(board[up_id + line+1][left_id + index]) != TYPE_INT:
					return true
	return false


func is_position_free(left_id : int, up_id : int, other_board : Array) -> bool:
	var empty
	var cell
	var cellID
	for line in range(len(other_board)):
		for index in range(len(other_board[0])) :
			empty = typeof(other_board[line][index]) == TYPE_INT
			if not empty:
				if left_id + index < 0 or left_id + index >= width:
					return false
				if up_id + line >= height:
					return false
				if typeof(board[up_id + line][left_id + index]) != TYPE_INT:
					return false
	return true

func pieceFell():
	updateBoard()
	print(lines_to_delete)
	animateLinesDown(lines_to_delete)
	yield(get_tree().create_timer(1), "timeout") #Il faut attendre que l animation soit finie
	updateCells()

# A appeler en premier lors de la mise a jour des tableaux
func updateBoard():
	lines_to_delete = []
	for line in range(height) :
		if not (0 in board[line]) :
			lines_to_delete.append(line)
	for i in lines_to_delete :
		board.remove(i)
		board.insert(0,[0,0,0,0,0,0,0,0,0,0])

# A appeler en 2e, cree l animation des lignes
func animateLinesDown(deletedLines : Array):
	var nblines = deletedLines.size()
	var line
	var i = 0
	while nblines > 0 :
		line = get_node("VBoxContainer/Line"+str(i+1)) #Les noms des noeuds commencent a 1
		if i in deletedLines :
			line.disable()
			nblines -= 1
		else :
			line.animationDown(nblines)
		i+=1

# A appeler en 3e, met a jour les lignes visuelles
func updateCells():
	var color
	var cell
	var cellID
	for line in range(height):
		for index in range(width) :
			color = board[line][index]
			cellID = "VBoxContainer/Line%d/Cell%d" %[line+1, index+1]
			cell = get_node(cellID)
			if typeof(color) == TYPE_INT :
				cell.disable()
			else :
				cell.enable(color)
