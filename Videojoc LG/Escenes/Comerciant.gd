extends KinematicBody2D

var no = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	idioma()
	
func idioma():
	if no == false:
		if Global.Idioma == "Catala":
			$Label.text = "Hola forastera! Vols comerciar?"
			$Yes.text = "Esclar que si!"
			$No.text = "Un altre dia potser..."
		if Global.Idioma == "English":
			$Label.text = "Hi foreigner! Do you want to trade?"
			$Yes.text = "Let's see what do you have"
			$No.text = "No, thanks..."
		
func _on_Interact_body_entered(body):
	if body.is_in_group("Protagonista"):
		$Label.show()
		$Yes.show()
		$No.show()


func _on_Interact_body_exited(body):
	$Label.hide()
	$Yes.hide()
	$No.hide()


func _on_Yes_pressed():
	get_tree().change_scene("res://Escenes/Shop.tscn")
	

func _on_No_pressed():
	$Yes.hide()
	$No.hide()
	no = true
	if Global.Idioma == "Catala":
		$Label.text = "Adeu, fins la proxima!"
	if Global.Idioma == "English":
		$Label.text = "Bye then, bless the path and never go away"
	$Timer.start()

func _on_Timer_timeout():
	$Label.hide()
