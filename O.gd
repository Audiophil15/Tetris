extends "res://Piece.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	c = Color(1,1,0)
	piece_board_size = 2
	piece_board = [[c,c], [c,c]]
	create()
	self.update()
