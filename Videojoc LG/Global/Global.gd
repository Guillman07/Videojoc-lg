extends Node

var Idioma = "English"
var Volum = 50
var Player_pos = Vector2()
var on_menu = true
var Musica 


func canvi_idioma(idioma):
	Idioma = idioma
	print(Idioma)

func Clic():
	Musica.play_clic()

func Player_pos(pos):
	Player_pos = pos

