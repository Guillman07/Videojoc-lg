extends Control

onready var ResOptionButton = $Control/Pantalla/HBoxContainer2/OptionButton
onready var FullscreenToggle  = $Control/Pantalla/HBoxContainer/FullscreenToggle
onready var LanguageOptionButton = $Control/HBoxContainer/Language

var Resolutions: Dictionary = {"1920x1080":Vector2(1920,1080),
								"1280x720":Vector2(1280,720),
								"1024x600":Vector2(1024,600),
								"800x600":Vector2(800,600)}
var Idiomes_disp = ["English","Catala"]

func _ready():
	AddResolutions()
	AddIdioma()
	FullscreenToggle.pressed = OS.is_window_fullscreen()
	
func _process(delta):
	idioma()

func idioma():
	if Global.Idioma == "Catala":
		$Control/Pantalla/HBoxContainer/Label.text = "Pantalla completa"
		$Control/Pantalla/HBoxContainer2/Resolution.text = "Resolucio"
		$Control/HBoxContainer/Label_Language.text = "Idioma"
		$Control/HBoxContainer2/Label_volume.text = "Volum"
	if Global.Idioma == "English":
		$Control/Pantalla/HBoxContainer/Label.text = "Fullscreen"
		$Control/Pantalla/HBoxContainer2/Resolution.text = "Resolution"
		$Control/HBoxContainer/Label_Language.text = "Language"
		$Control/HBoxContainer2/Label_volume.text = "Volume"

func AddResolutions():
	var CurrentResolution = get_viewport().get_size()
	
	var Index = 0
	
	for r in Resolutions:
		ResOptionButton.add_item(r,Index)
		
		if Resolutions[r] == CurrentResolution:
			ResOptionButton._select_int(Index)
		Index += 1

func AddIdioma():
	for i in Idiomes_disp:
		LanguageOptionButton.add_item(i)

func _on_OptionButton_item_selected(index):
	var size = Resolutions.get(ResOptionButton.get_item_text(index))
	OS.set_window_size(size)

func _on_FullscreenToggle_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	
	if button_pressed == false:
		var size = get_viewport().get_size()
		OS.set_window_size(size)
		OS.center_window()







func _on_Language_item_selected(index):
	Global.canvi_idioma(Idiomes_disp[index])
	

#REVISAR
func _on_SpinBox_value_changed(value):
	Global.Volum = value


func _on_TextureButton_pressed():
	$Control/TextureButton/AnimatedSprite.play("confirm")
	

func _on_AnimatedSprite_animation_finished():
	if $Control/TextureButton/AnimatedSprite.animation == "confirm" :
		get_tree().change_scene("res://Global/Global.tscn")

