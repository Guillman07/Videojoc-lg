extends Area2D

const Bola_foc = preload("res://Escenes/Bola_foc.tscn")
var energia = 0

func _ready():
	pass 

#func _process(delta):
#	pass
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
		
# no fa gaire mal de quemadura pero si que fa bastant de impacte.
#Bola de foc es mes gran que la dels subdits

func _on_Area_potenciadora_area_entered(area):
	pass 
#Potencia el mal de quemadura dels subdits (sha de fer que quan surtin de larea ja no estiguin potenciats)
