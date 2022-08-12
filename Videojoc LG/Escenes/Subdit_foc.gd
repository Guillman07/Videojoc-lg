extends KinematicBody2D

const Bola_foc = preload("res://Escenes/Bola_foc.tscn")
var energia = 0
var velocitat_base = 200
var velocitat = Vector2.ZERO

var cami: Array = [] 
var LevelNavigation: Navigation2D = null
var Player = null

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	if tree.has_group("Navigation2D"):
		LevelNavigation = tree.get_nodes_in_group("Navigation2D")[0]
	if tree.has_group("Protagonista"):
		Player = tree.get_nodes_in_group("Protagonista")[0]

func _process(delta):
	if Player and LevelNavigation:
		genera_cami()
		busca_seguent_pos()
	moviment()
#aproparse al prota per arribar al rango suicient de atac simple

func busca_seguent_pos():
	if cami.size() > 0:
		velocitat = global_position.direction_to(cami[1]) * velocitat_base
		
		if global_position == cami[0]:
			cami.pop_front()
	

func genera_cami():
	if LevelNavigation != null and Player != null:
		cami = LevelNavigation.get_simple_path(global_position,Player.global_position, false)
	
func atac_simple():
	pass
	#Mini bola de foc, que no es pot fallar, de dany casi nul,carrega energia
	#amb temps de reload
func bola_foc():
	
	if energia == 100:
		var Subjecte = Bola_foc.instance()
		add_child(Subjecte)
		Subjecte.position = $Position2D.position
		
# no fa gaire mal d'impacte pero si que fa bastant de quemadura.
func moviment():
	velocitat = move_and_slide(velocitat)
