extends KinematicBody2D

const bola_foc_Path = preload("res://Escenes/Bola_foc.tscn")
const conjur_planta_Path = preload("res://Escenes/Conjur_planta.tscn")

onready var Temps_atac = $Temps_atac
var velocitat = 200
var moviment = Vector2()

func _ready():
	pass 

func _process(delta):
	moviment = Vector2()
	if Input.is_action_just_pressed("Q") and Temps_atac.is_stopped(): #and energia >= X
		var direccio_bola_foc = self.global_position.direction_to(get_global_mouse_position())
		bola_foc(direccio_bola_foc)
		
	if Input.is_action_just_pressed("E") and Temps_atac.is_stopped(): #and energia >= X
		conjur_planta()
		
	if Input.is_action_pressed("Est"):
		moviment.x += 1
	if Input.is_action_pressed("Oest"):
		moviment.x -= 1
	if Input.is_action_pressed("Nord"):
		moviment.y -= 1
	if Input.is_action_pressed("Sud"):
		moviment.y += 1
	if moviment.length() > 0:
		moviment = moviment.normalized() * velocitat
		
	$Node2D.look_at(get_global_mouse_position())
	position += moviment * delta
	moviment = move_and_slide(moviment, Vector2.UP)
	animacio(moviment)
	
func animacio(moviment):
	
	if moviment.x > 0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif moviment.x < -0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
		
	if abs(moviment.x) < 0.1:
		$AnimatedSprite.play("Idle")

func bola_foc(direccio_bola_foc : Vector2):
	if bola_foc_Path:
		var bola_foc = bola_foc_Path.instance()
		get_tree().current_scene.add_child(bola_foc) 
		bola_foc.global_position = $Node2D/Position2D.global_position
		
		var rotacio = direccio_bola_foc.angle()
		bola_foc.rotation = rotacio
		
		Temps_atac.wait_time = 3
		Temps_atac.start()

		#energia -= X
func conjur_planta():
	#get_parent().get_child("software_cursor") NI IDEA     CANVIAR ANIMACIO DEL CURSOR
	
	if Input.is_action_just_pressed("Confirmar") and Temps_atac.is_stopped():
		$Conjur_planta.play("Animacio")
		var conjur_planta = conjur_planta_Path.instance()
		get_tree().current_scene.add_child(conjur_planta) 
		conjur_planta.position = get_global_mouse_position()
		
	Temps_atac.wait_time = 3
	Temps_atac.start()

func posicio():
	self.position == Global.Player_pos
