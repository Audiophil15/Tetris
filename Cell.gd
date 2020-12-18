extends TextureRect



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable() : 			#Fonction pour cacher ou montrer la case
	$".".set_modulate(Color(1,1,1,0))
	$Area2D/Hitbox.set_disabled(true)
	
func enable(couleur : Color):
	$".".set_modulate(couleur)
	$Area2D/Hitbox.set_disabled(false)
