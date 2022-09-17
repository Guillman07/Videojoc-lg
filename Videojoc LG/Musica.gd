extends Node

var clic = preload("res://SFX/Clic.wav")
onready var Menu = $Menu


func _ready():
	Global.Musica = self
	

func _process(delta):
	if Global.on_menu == true and Menu.playing == false :
		play_menu_music()

func play_menu_music():
	$Menu.play()
	
func play_clic():
	$Clic.stream = clic
	$Clic.play()
