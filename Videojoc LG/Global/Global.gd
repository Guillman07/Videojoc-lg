extends Node

var Idioma = "English"
var Volum = 50
var Player_pos = Vector2()

var Musica


func canvi_idioma(idioma):
	Idioma = idioma
	print(Idioma)

func Clic():
	pass
	Musica.play_clic()

func Player_pos(pos):
	Player_pos = pos

