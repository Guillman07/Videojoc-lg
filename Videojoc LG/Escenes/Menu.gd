extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



#Boto configuracio
func _on_TextureButton_pressed():
	$Configuracio/AnimatedSprite.play("confirm")
	$Configuracio/Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Escenes/Configuracio.tscn")

func _on_TextureButton_mouse_entered():
	$Configuracio/AnimatedSprite.play("select")

func _on_Configuracio_mouse_exited():
	$Configuracio/AnimatedSprite.play("idle")

	


func _on_Play_pressed():
	if Global.llengua == "English":
		$Play/AnimatedSprite2.play("confirm")
	if Global.llengua == "Catala":
		$Play/AnimatedSprite2.play("confirm_cat")
	$Play/TimerPlay.start()

func _on_TimerPlay_timeout():
	get_tree().change_scene("res://Escenes/World.tscn")


func _on_Play_mouse_entered():
	if Global.llengua == "English":
		$Play/AnimatedSprite2.play("select")
	if Global.llengua == "Catala":
		$Play/AnimatedSprite2.play("select_cat")
		
func _on_Play_mouse_exited():
	if Global.llengua == "English":
		$Play/AnimatedSprite2.play("idle")
	if Global.llengua == "Catala":
		$Play/AnimatedSprite2.play("idle_cat")
