extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable() : 			#Fonction pour cacher ou montrer la case
	$".".set_modulate(Color(1,1,1,0))
	$Body/Hitbox.set_disabled(true)
	
func enable(couleur : Color):
	$".".set_modulate(couleur)
	$Body/Hitbox.set_disabled(false)


func _cell_hit(body):
	print("Called ", body)
	pass # Replace with function body.


func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print("Called 2", body)
	pass # Replace with function body.
