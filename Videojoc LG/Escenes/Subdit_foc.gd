extends KinematicBody2D

const Bola_foc = preload("res://Escenes/Bola_foc.tscn")
var energia = 0
var velocitat_base = 40
var velocitat = Vector2.ZERO
func _ready():
	pass 

func _process(delta):
	moviment()
#aproparse al prota per arribar al rango suicient de atac simple
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
	velocitat = move_and_slide(velocitat_base)
