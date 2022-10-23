extends Node2D

var Easter_egg = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Cofre_Easter_Egg_body_entered(body):
	if Easter_egg == 1:
		Global.Money += 1000
		Easter_egg -= 1
