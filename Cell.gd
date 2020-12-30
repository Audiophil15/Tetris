extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable() : 			#Fonction pour cacher ou montrer la case
	pass
	
func enable(couleur : Color):
	pass

func _cell_hit(body):
	print("Called ", self)
	pass # Replace with function body.

func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_name()=="HBody":
		print("impossible_position !")
		print(body.get_parent().get_parent().get_parent().get_parent().get_name())
		body.get_parent().get_parent().get_parent().get_parent().set_impossible_pos()
		$".".set_modulate(Color(1,0,0))
#	print("Called 2 ", self, self.get_rect().position, self.get_parent(), self.get_parent().get_parent())
#	print("Called 2 ", self.get_rect().position, self.get_parent().get_rect().position, self.get_parent().get_parent().get_parent().name)
#	print("Body ", body.get_parent().get_rect().position, body.get_parent().get_parent().get_rect().position, body.get_parent().get_parent().get_parent().get_parent().name)
#	$".".set_modulate(Color(1,0,0))
	pass # Replace with function body.
