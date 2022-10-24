extends Node2D

var Easter_egg = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	idioma()

func idioma():
	if Global.Idioma == "Catala":
		$Cofre_Easter_Egg/Made_by.text = "Fet per : Lluc i Guillem"
	if Global.Idioma == "English":
		$Cofre_Easter_Egg/Made_by.text = "Done by : Lluc and Guillem"
		
func _on_Cofre_Easter_Egg_body_entered(body):
	if Easter_egg == 1:
		Global.Money += 1000
		Easter_egg -= 1
		$Cofre_Easter_Egg/Made_by.show()
		$Cofre_Easter_Egg/Label.show()
		$Cofre_Easter_Egg/Sprite.show()
		$Cofre_Easter_Egg/Timer_cofre.start()

func _on_Timer_cofre_timeout():
	$Cofre_Easter_Egg/Label.hide()
	$Cofre_Easter_Egg/Sprite.hide()


func _on_wsad_body_entered(body):
	$wsad/Label.hide()
