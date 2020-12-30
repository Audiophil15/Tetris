extends "res://Cell.gd"

func _ready():
	$Area2D/Hitbox.set_disabled(true)

func disable() : 			#Fonction pour cacher ou montrer la case
	$".".set_modulate(Color(1,1,1,0))
	$Area2D/Hitbox.set_disabled(true)
	
func enable(couleur : Color):
	$".".set_modulate(couleur)
	$Area2D/Hitbox.set_disabled(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
