extends Control

# "Classe" abstraite pour toutes les pieces

var main_board
var piece_board_size
var visual_right_side
var visual_left_side
var piece_board
var piece_board_old
var old_x_pos
var impossible_position
var c
var time_count = 0
var time_limit = 1
var timer_lateral = 0
var time_repeat = 0.15
var lateral_move = false
#var cell = preload("res://Cell.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	main_board = self.get_parent()
	impossible_position = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_down"):
		time_limit = 0.05
	else:
		time_limit = 1
	lateral_move = 0
	if Input.is_action_pressed("ui_left"):
		lateral_move = -1
	if Input.is_action_pressed("ui_right"):
		lateral_move = 1
	if lateral_move != 0:
		if timer_lateral==0:
			if lateral_move == -1:
				self.left()
			else:
				self.right()
			print(timer_lateral)
			timer_lateral += delta
		else:
			timer_lateral += delta
			if timer_lateral>time_repeat:
				timer_lateral = 0
	else:
		timer_lateral = 0
	time_count += delta
	if Input.is_action_just_pressed("key_a"):
		self.rotateLeft()
	if Input.is_action_just_pressed("key_e"):
		self.rotateRight()
	if time_count > time_limit:
		time_count = 0
		self.down()

func main_idx():
	return int(self.rect_position.x/50)
func main_idy():
	return int(self.rect_position.y/50)

func is_position_free(add_idx=0, new_board=self.piece_board) -> bool:
	return self.main_board.is_position_free(main_idx()+add_idx, main_idy(), new_board)

func manage_soil():
	if self.main_board.is_on_soil(main_idx(), main_idy(), self.piece_board):
		print("landed")
		self.main_board.land_piece(main_idx(), main_idy(), self.piece_board)

func create():
	piece_board_old = piece_board.duplicate(true)

func set_impossible_pos():
#	self.impossible_position = true
	pass

func down():
	$".".rect_position.y+=50
	if not self.is_position_free():
		$".".rect_position.y-=50
	self.manage_soil()
	
#	$".".move_and_collide(Vector2(0, 50))
	
func left():
	if self.is_position_free(-1):
		$".".rect_position.x-=50
	self.manage_soil()
#	clampPosition()

func right():
	if self.is_position_free(+1):
		$".".rect_position.x+=50
	self.manage_soil()
#	clampPosition()
	
func clampPosition():
	pass
#	var cellSize = 50
#	var boardwidth = 500
#	$".".rect_position.x = max(-visual_left_side*cellSize, $".".rect_position.x)
#	$".".rect_position.x = min(boardwidth-visual_right_side*cellSize, $".".rect_position.x)
	
func rotateLeft(): #Sens direct
	var tmpBoard = piece_board.duplicate(true)
	for i in range(piece_board_size):
		for j in range(piece_board_size):
			tmpBoard[piece_board_size-1-j][i] =piece_board[i][j]
	if not self.is_position_free(0, tmpBoard):
		if self.is_position_free(1, tmpBoard):
			$".".rect_position.x+=50
		elif self.is_position_free(-1, tmpBoard):
			$".".rect_position.x-=50
	if self.is_position_free(0, tmpBoard):
		piece_board = tmpBoard
		update()
	else:
		pass
	self.manage_soil()
	#Il faut appeler update() avant clampPosition, on verifie la position de la piece mise a jour
#	clampPosition()
	
func rotateRight(): #Sens indirect
	var tmpBoard= piece_board.duplicate(true)
	for i in range(piece_board_size):
		for j in range(piece_board_size):
			tmpBoard[j][piece_board_size-1-i] =piece_board[i][j]
	if not self.is_position_free(0, tmpBoard):
		if self.is_position_free(1, tmpBoard):
			$".".rect_position.x+=50
		elif self.is_position_free(-1, tmpBoard):
			$".".rect_position.x-=50
	if self.is_position_free(0, tmpBoard):
		piece_board = tmpBoard
		update()
	self.manage_soil()
	#Il faut appeler update() avant clampPosition, on verifie la position de la piece mise a jour
#	clampPosition()

func update():
	var color
	var cellule
	var cellID
	var body
	visual_left_side = piece_board_size
	visual_right_side = 0
	for line in range(piece_board_size):
		for index in range(piece_board_size) :
			color = piece_board[line][index]
			cellID = "VBoxContainer/HBoxContainer%d/Cell%d" %[line+1, index+1]
			cellule = get_node(cellID)
			if typeof(color) == TYPE_INT :
				cellule.disable()
			else :
				# La cellule visuelle a des dimensions differentes de celles du tableau, il faut donc les utiliser elles plutot que celles du tableau
				visual_left_side = min(visual_left_side, index)
				visual_right_side = max(visual_right_side, index)
				cellule.enable(color)
				body = cellule.get_children()[1] 
	visual_right_side += 1 #Needs a +1 because it's at least 1 cell
