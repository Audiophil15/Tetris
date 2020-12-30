extends Control

var lines_to_delete = []
var board = []
var width = 10
var height = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	create_board()
	updateCells()
	pieceFell()
	
	var pieceT = load("res://T.tscn").instance()
	$".".add_child(pieceT)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_board():
	for i in range(height):
		board.append([])
		for j in range (width):
			if i == 17 :
				board[i].append(Color(0.7,0.7,0))
			else: 
				board[i].append(0)
	board.append([])
	for j in range (width):
		board[height].append(Color(0,0,0))
	for i in range(3):
		board[15][i] = Color(0.7,0.9,0)

func get_board():
	return board
	
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


func _on_Area2D_body_exited(body):
#	print("eeeeeee", body.get_name()) # Replace with function body.
	pass

func _on_Area2D_body_entered(body):
	if body.get_name()=="HBody":
		print("ooooo", body.get_name())
		print(body.get_parent().get_parent().get_parent().get_parent().get_name())
		body.get_parent().get_parent().get_parent().get_parent().set_impossible_pos()
