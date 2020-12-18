extends HBoxContainer

var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = $".".rect_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable():
	var cellID
	for i in range(1, 11) :
		cellID = "Cell"+str(i)
		get_node(cellID).disable()

func animation(height : int):
	var tween = $Tween
	tween.interpolate_property($".", "rect_position", $".".rect_position, $".".rect_position + Vector2(0,50*height), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func remettreenplace():
	$".".rect_position = pos
