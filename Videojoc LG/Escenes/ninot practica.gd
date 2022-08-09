extends StaticBody2D

var vida = 1000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Curar_timeout():
	vida = 1000


func dany(dany):
	vida -= dany
	$AnimatedSprite.play("Hit")
	$Tween.interpolate_property($Vida,'value',$Vida.value, vida, 0.2,Tween.TRANS_LINEAR)
	$Tween.start()
	$Timer_Animacio.start()
	$Curar.start()

func _on_Timer_Animacio_timeout():
	$AnimatedSprite.play("Idle")
