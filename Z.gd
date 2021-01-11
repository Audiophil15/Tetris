extends "res://Piece.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	c = Color(1,0,0)
	piece_board_size = 3
	piece_board = [[0,0,c], [0,c,c], [0,c,0]]
	create()
	self.update()
