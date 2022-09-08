extends Node

var Idioma = "English"
var Volum = 50
var Player_pos = Vector2()

onready var Musica = $Musica


func canvi_idioma(idioma):
	Idioma = idioma
	print(Idioma)

func Clic():
	Musica.play_clic()
