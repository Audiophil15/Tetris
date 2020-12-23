extends Control

var lines = [3,5,8]
var board = []
var width = 10
var height = 20

# Called when the node enters the scene tree for the first time.
func _ready():
#	for i in range(height):
#		board.append([])
#		for j in range (width):
#			if i != 3 :
#				board[i].append(0)
#			else :
#				board[i].append(Color(0.7,0,0.65,1))
#	updateCells()
#	animation(lines)
#
#	var piece = load("res://Piece.gd")
#	piece.new("T")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_board():
	return board

func animation(deletedLines : Array):
	var nblines = deletedLines.size()
	var line
	var i = 1
	while nblines > 0 :
		line = get_node("VBoxContainer/Line"+str(i))
		if i in deletedLines :
			line.disable()
			nblines -= 1
		else :
			line.animation(nblines)

		i+=1

func updateBoard():
	var linesToRemove = []
	for line in range(height) :
		if not (0 in board[line]) :
			linesToRemove.append(line)
	for i in linesToRemove :
		board.remove(i)
		board.insert(0,[0,0,0,0,0,0,0,0,0,0])

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
