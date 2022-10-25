extends Control


func _ready():
	pass # Replace with function body.

func _process(delta):
	idioma()
	
func idioma():
	pass

func _on_TextureButton_pressed():

	$Back/AnimatedSprite.play("confirm")
	
func _on_AnimatedSprite_animation_finished():
	if $Back/AnimatedSprite.animation == "confirm" :
		get_tree().change_scene("res://Escenes/World.tscn")
