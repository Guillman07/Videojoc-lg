extends Node

var clic = preload("res://SFX/Clic.wav")
var menu_music = preload("res://SFX/Clic.wav")


func _ready():
	Global.Musica = self
	play_menu_music()

func _process(delta):
	if Global.on_menu == true:
		play_menu_music()

func play_menu_music():
	$Menu.stream = menu_music
	$Menu.play()
	
func play_clic():
	$Clic.stream = clic
	$Clic.play()
