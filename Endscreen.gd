extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.text = str(Global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Try_again_pressed():
	get_tree().change_scene("res://Gameplay.tscn")

func _on_Quit_pressed():
	get_tree().quit()
