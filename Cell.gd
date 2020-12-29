extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$Body/Hitbox.set_disabled(true)
	$Area2D/Hitbox.set_disabled(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable() : 			#Fonction pour cacher ou montrer la case
	$".".set_modulate(Color(1,1,1,0))
	$Body/Hitbox.set_disabled(true)
	$Area2D/Hitbox.set_disabled(true)
	
func enable(couleur : Color, falling : bool):
	$".".set_modulate(couleur)
	if falling:
		$Body/Hitbox.set_disabled(false)
	else:
		$Area2D/Hitbox.set_disabled(false)

func _cell_hit(body):
	print("Called ", self)
	pass # Replace with function body.

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
#	print("Called 2 ", self, self.get_rect().position, self.get_parent(), self.get_parent().get_parent())
	print("Called 2 ", self.get_rect().position, self.get_parent().get_rect().position, self.get_parent().get_parent().get_parent().name)
	print("Body ", body.get_parent().get_rect().position, body.get_parent().get_parent().get_rect().position, body.get_parent().get_parent().get_parent().get_parent().name)
	$".".set_modulate(Color(1,0,0))
	pass # Replace with function body.
