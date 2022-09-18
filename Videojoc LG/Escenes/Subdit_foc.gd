extends KinematicBody2D

const Bola_foc = preload("res://Escenes/Bola_foc.tscn")
var energia = 0
var velocitat_base = 200
var velocitat = Vector2.ZERO
var dead = false
var cami: Array = [] 
var LevelNavigation: Navigation2D = null
var Player = null
var player_detectat: bool = false 
var current_health = 100

onready var Ldv = $Linea_de_visio
onready var Temps_atac = $Temps_atac

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	if tree.has_group("Navigation2D"):
		LevelNavigation = tree.get_nodes_in_group("Navigation2D")[0]
	if tree.has_group("Protagonista"):
		Player = tree.get_nodes_in_group("Protagonista")[0]

func _physics_process(delta):
	if Temps_atac.is_stopped(): 
		var direccio_bola_foc = self.global_position.direction_to(Global.Player_pos)
		bola_foc(direccio_bola_foc)
	$Node2D.look_at(Global.Player_pos)
	
	if Player: #and LevelNavigation
		Ldv.look_at(Player.global_position)
		check_player_in_detection()
		if player_detectat: 
			genera_cami()
			busca_seguent_pos()
	moviment()
#aproparse al prota per arribar al rango suicient de atac simple

func check_player_in_detection() -> bool:
	var collider = Ldv.get_collider()
	if collider and collider.is_in_group("Protagonista"):
		player_detectat = true
		print("raycast collided")
		return true
	return false
		
func busca_seguent_pos():
	if cami.size() > 0:
		velocitat = global_position.direction_to(cami[1]) * velocitat_base
		
		if global_position == cami[0]:
			cami.pop_front()
	

func genera_cami():
	if LevelNavigation != null and Player != null:
		cami = LevelNavigation.get_simple_path(global_position,Player.global_position, false)
	

func moviment():
	velocitat = move_and_slide(velocitat)

func bola_foc(direccio_bola_foc):
	if Bola_foc:
		var bola_foc = Bola_foc.instance()
		get_tree().current_scene.add_child(bola_foc) 
		bola_foc.global_position = $Node2D/Position2D.global_position
		
		var rotacio = direccio_bola_foc.angle()
		bola_foc.rotation = rotacio
		bola_foc.dmg = 20
		
		Temps_atac.wait_time = 5
		Temps_atac.start()
func damage(amount):
	current_health -= amount
	$Tween.interpolate_property($Vida,'value',$Vida.value, current_health, 0.2,Tween.TRANS_LINEAR)
	$Tween.start()
	die()
	
func die():
	if current_health <= 0:
		velocitat_base = 0
		$AnimatedSprite.play("Die")
		dead = true

func _on_AnimatedSprite_animation_finished():
	if dead == true:
		queue_free()
