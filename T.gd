extends "res://Piece.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	create("T")
	self.update()
	print($".".rect_position, visual_left_side, visual_right_side)
	var maxx = 0
	for i in range(22):
		maxx = max(maxx, rect_position.x)
		yield(get_tree().create_timer(1), "timeout")
#		yield(get_tree().create_timer(0.1), "timeout")
		down()
		rotateLeft()
		if maxx > 200 :
			left()
		else :
			right()
		print($".".rect_position, visual_left_side, visual_right_side)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
