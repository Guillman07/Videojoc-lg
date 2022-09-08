extends Node

var clic = preload("res://SFX/Clic.wav")
var menu_music = preload("res://SFX/Clic.wav")

func _ready():
	play_menu_music()

func play_clic():
	$Clic.stream = clic
	$Clic.play()

func play_menu_music():
	$Menu.stream = menu_music
	$Menu.play()
