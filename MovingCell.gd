extends "res://Cell.gd"

func _ready():
	$VBody/Hitbox.set_disabled(true)
	$HBody/Hitbox.set_disabled(true)

func disable() : 			#Fonction pour cacher ou montrer la case
	$".".set_modulate(Color(1,1,1,0))
	$VBody/Hitbox.set_disabled(true)
	$VBody/Hitbox.set_disabled(true)
	
func enable(couleur : Color):
	$".".set_modulate(couleur)
	$VBody/Hitbox.set_disabled(false)
	$HBody/Hitbox.set_disabled(false)

func test():
	self.get_transform()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
