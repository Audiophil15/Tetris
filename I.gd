extends "res://Piece.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	c = Color(0,1,0)
	piece_board_size = 4
	piece_board = [[0,c,0,0], [0,c,0,0], [0,c,0,0], [0,c,0,0]]
	create()
	self.update()
