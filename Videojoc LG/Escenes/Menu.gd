extends Control


func _ready():
	idioma()
	Global.on_menu = true
	birds()
	
func idioma():
	if Global.Idioma == "English":
		$Play/AnimatedSprite2.play("idle")
	if Global.Idioma == "Catala":
		$Play/AnimatedSprite2.play("idle_cat")
	if Global.Idioma == "English":
		$Quit/AnimatedSprite.play("idle")
	if Global.Idioma == "Catala":
		$Quit/AnimatedSprite.play("idle_cat")
		
	if Global.Idioma == "English":
		$Configuracio/Label.text = "Options"
	if Global.Idioma == "Catala":
		$Configuracio/Label.text = "Configuracio"



#Boto configuracio
func _on_TextureButton_pressed():
	$Configuracio/AnimatedSprite.play("confirm")
	$Configuracio/Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Escenes/Configuracio.tscn")
	Global.on_menu = true
func _on_TextureButton_mouse_entered():
	Global.Clic()
	$Configuracio/AnimatedSprite.play("select")
	$Configuracio/Label.show()
	
func _on_Configuracio_mouse_exited():
	$Configuracio/AnimatedSprite.play("idle")
	$Configuracio/Label.hide()



#boto play
func _on_Play_pressed():
	if Global.Idioma == "English":
		$Play/AnimatedSprite2.play("confirm")
	if Global.Idioma == "Catala":
		$Play/AnimatedSprite2.play("confirm_cat")
	$Play/TimerPlay.start()

func _on_TimerPlay_timeout():
	get_tree().change_scene("res://Escenes/World.tscn")
	Global.on_menu = false
func _on_Play_mouse_entered():
	Global.Clic()
	if Global.Idioma == "English":
		$Play/AnimatedSprite2.play("select")
	if Global.Idioma == "Catala":
		$Play/AnimatedSprite2.play("select_cat")
	
func _on_Play_mouse_exited():
	if Global.Idioma == "English":
		$Play/AnimatedSprite2.play("idle")
	if Global.Idioma == "Catala":
		$Play/AnimatedSprite2.play("idle_cat")



#boto quit
func _on_Quit_pressed():
	if Global.Idioma == "English":
		$Quit/AnimatedSprite.play("confirm")
	if Global.Idioma == "Catala":
		$Quit/AnimatedSprite.play("confirm_cat")
		
func _on_Quit_mouse_entered():
	Global.Clic()
	if Global.Idioma == "English":
		$Quit/AnimatedSprite.play("select")
	if Global.Idioma == "Catala":
		$Quit/AnimatedSprite.play("select_cat")

func _on_Quit_mouse_exited():
	if Global.Idioma == "English":
		$Quit/AnimatedSprite.play("idle")
	if Global.Idioma == "Catala":
		$Quit/AnimatedSprite.play("idle_cat")

func _on_AnimatedSprite_animation_finished():
	if $Quit/AnimatedSprite.animation == "confirm" :
		get_tree().quit()
	if $Quit/AnimatedSprite.animation == "confirm_cat" :
		get_tree().quit()

func birds():
	if $Node2D/Timer_birds.is_stopped():
		$Node2D/Birds.play("Birds")
		
func _on_Birds_animation_finished():
	if $Node2D/Birds.animation == "Birds":
		$Node2D/Birds.play("Res")
		$Node2D/Timer_birds.start()

func _on_Timer_birds_timeout():
	birds()
