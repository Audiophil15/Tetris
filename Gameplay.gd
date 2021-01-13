extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Board.connect("changed_piece", self, "change_next_piece")
	change_next_piece($HBoxContainer/Board.next_piece_letter)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_next_piece(letter):
	$HBoxContainer/TextureRect/NextPiece.texture = load("res://Art/"+letter+".png")
	checkScore()

func checkScore():
	$HBoxContainer/TextureRect/Score.text = "Score\n" + str(Global.score)
