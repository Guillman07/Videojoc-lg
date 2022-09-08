extends CanvasLayer

onready var ResOptionButton = $Control/Pantalla/HBoxContainer2/OptionButton
onready var FullscreenToggle  = $Control/Pantalla/HBoxContainer/FullscreenToggle
onready var LanguageOptionButton = $Control/HBoxContainer/Language

var Resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1440),
								"1920x1080":Vector2(1920,1080),
								"1366x768":Vector2(1366,768),
								"1536x864":Vector2(1536,864),
								"1280x720":Vector2(1280,720),
								"1440x900":Vector2(1440,900),
								"1600x900":Vector2(1600,900),
								"1024x600":Vector2(1024,600),
								"800x600":Vector2(800,600)}
var Idiomes_disp = ["English","Catala"]

func _ready():
	set_visible(false)
	AddResolutions()
	AddIdioma()
	FullscreenToggle.pressed = OS.is_window_fullscreen()
func _process(delta):
	idioma()

func idioma():
	if Global.Idioma == "English":
		$Control/Button.text = "Continue"
		$Control/Pantalla/HBoxContainer/Label.text = "Fullscreen"
		$Control/Pantalla/HBoxContainer2/Resolution.text = "Resolution"
		$Control/HBoxContainer/Label_Language.text = "Language"
		$Control/HBoxContainer2/Label_volume.text = "Volume"
	if Global.Idioma == "Catala":
		$Control/Button.text = "Seguir jugant"
		$Control/Pantalla/HBoxContainer/Label.text = "Pantalla completa"
		$Control/Pantalla/HBoxContainer2/Resolution.text = "Resolucio"
		$Control/HBoxContainer/Label_Language.text = "Idioma"
		$Control/HBoxContainer2/Label_volume.text = "Volum"
		

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

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused


func _on_OptionButton_item_selected(index):
	var size = Resolutions.get(ResOptionButton.get_item_text(index))
	OS.set_window_size(size)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)

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


func _on_Button_pressed():
	print("a")
	get_tree().paused = false
	set_visible(false)
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible



	

