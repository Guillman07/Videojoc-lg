extends KinematicBody2D

const bola_foc_Path = preload("res://Escenes/Bola_foc.tscn")
const conjur_planta_Path = preload("res://Escenes/Conjur_planta.tscn")

onready var Temps_atac = $Temps_atac
onready var CooldownHits = $Cooldown_Hits
var velocitat = 100
var moviment = Vector2()

var max_health : int = 100
var current_health : int = 100
var health_regen : int = 1
var armadura : int = 0
var shield : int = 0 setget shield
var r = 1

var max_poder : int = 100
var current_poder : int = 100
var poder_regen : int = 1

var Atacking = false
var Hits = 0
var stopped = false
var CooldownHit = 10
var CooldownFireball = 5
func _ready():
	pass 

func _process(delta):
	position()
	inputs_check(delta)
	if r == 1:
		$Regenerar.start()
		r -= 1
	idioma()
	
func idioma():
	if Global.Idioma == "Catala":
		$Cooldowns/Hit_c/Info_hit.text = "E : Golpeig simple, si impacta un enemic es pot fer un atac de gran potencia (amb E) i reps una petita porcio d'escut"
		$Cooldowns/Fireball_c/Info_Fireball.text = "Q : Projectil de foc dirigit a la posicio del ratoli"
	if Global.Idioma == "English":
		$Cooldowns/Hit_c/Info_hit.text = "E : Simple hit, if hits an enemy you can do a powered (attack with E) which gives you a little porcion of shield"
		$Cooldowns/Fireball_c/Info_Fireball.text = "Q : Fireball aimed to the mouse position that deals damage"
		
func inputs_check(delta):
	if Global.on_menu == false:
		
		moviment = Vector2()
		if Input.is_action_just_pressed("Q") and Temps_atac.is_stopped(): #and energia >= X
			var direccio_bola_foc = self.global_position.direction_to(get_global_mouse_position())
			bola_foc(direccio_bola_foc)
			
		if Input.is_action_just_pressed("E") and Temps_atac.is_stopped(): #and energia >= X
			pass
			#conjur_planta()
			
		if Input.is_action_pressed("Est"):
			moviment.x += 1
		if Input.is_action_pressed("Oest"):
			moviment.x -= 1
		if Input.is_action_pressed("Nord"):
			moviment.y -= 1
		if Input.is_action_pressed("Sud"):
			moviment.y += 1
		if moviment.length() > 0:
			moviment = moviment.normalized() * velocitat
			
		$Node2D.look_at(get_global_mouse_position())
		position += moviment * delta
		moviment = move_and_slide(moviment, Vector2.UP)
		if Input.is_action_pressed("shift"):
			velocitat = 150
		else:
			if stopped == false:
				velocitat = 100
			
		if Input.is_action_just_pressed("E"): 
			if CooldownHits.is_stopped():
				if Hits == 0:
					stopped = true
					velocitat = 0
					hit_1() 
					
				if Hits == 1:
					stopped = true
					velocitat = 0
					hit_2()
				
		if not Atacking:
			animacio(moviment)
		
		

func animacio(moviment):
	
	if moviment.x > 0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif moviment.x < -0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true

	if abs(moviment.x) < 0.1:
		if moviment.y < -0.1:
			$AnimatedSprite.play("Run_back")
		if moviment.y > 0.1:
			$AnimatedSprite.play("Run")
			
		if moviment.y == 0:
			$AnimatedSprite.play("Idle")

func position():
	var pos = self.position
	Global.Player_pos(pos)
	
	
func bola_foc(direccio_bola_foc : Vector2):
	if bola_foc_Path:
		var bola_foc = bola_foc_Path.instance()
		get_tree().current_scene.add_child(bola_foc) 
		bola_foc.global_position = $Node2D/Position2D.global_position
		
		var rotacio = direccio_bola_foc.angle()
		bola_foc.rotation = rotacio
		
		
		Temps_atac.start()

		#energia -= X
func conjur_planta():

	
	if Input.is_action_just_pressed("Confirmar") and Temps_atac.is_stopped():
		$Conjur_planta.play("Animacio")
		var conjur_planta = conjur_planta_Path.instance()
		get_tree().current_scene.add_child(conjur_planta) 
		conjur_planta.position = get_global_mouse_position()
		
	Temps_atac.wait_time = 3
	Temps_atac.start()


func damage_player(amount):
	var string = "ai: %d\tvi: %d\n" % [shield, current_health]
	if (armadura > 0): amount = amount * ((100 - armadura) * 0.01)
	if shield > 0:
		self.shield -= amount
		if shield < 0:
			amount = shield * (-1)
			shield = 0
		else:
			amount = 0
	if (current_health > amount): current_health -= amount
	else :
		die()
	string += "af: %d\tvf: %d" % [shield, current_health]
	$Label.text = string
	$AnimatedSprite.modulate = "030101"
	$Tween.interpolate_property($Vida,'value',$Vida.value, current_health, 0.2,Tween.TRANS_LINEAR)
	$Tween.start()
	$Rebent.start()
	

func shield(amount):
	shield = amount
	$Tween.interpolate_property($Escut,'value',$Escut.value, shield, 0.2,Tween.TRANS_LINEAR)
	$Tween.start()

func die():
	get_tree().quit()
	
func _on_Rebent_timeout():
	$AnimatedSprite.modulate = "ffffff"

func regen_health():
	if (current_health < max_health):
		if ((health_regen + current_health) > max_health):
			current_health = max_health
		else: current_health += health_regen
	
func _on_Regenerar_timeout():
	regen_health()
	r += 1

func regen_poder():
	if (current_poder < max_poder):
		if ((poder_regen + current_poder) > max_poder):
			current_poder = max_poder
		else: current_poder += poder_regen

func modify_poder(amount):
	var new_poder = current_poder + amount
	if (new_poder < 0): current_poder = 0
	if (new_poder > max_poder): current_poder = max_poder
	else: current_poder += amount
	
func slow(amount):
	velocitat -= amount

func hit_1():
	Atacking = true
	$AnimatedSprite.play("Hit_1")
	$Hit_area_1/TimerHit.start()
	$Hit_area_1/CollisionShape2D.disabled = false

func _on_TimerHit_timeout():
	stopped = false
	Atacking = false
	$Hit_area_1/CollisionShape2D.disabled = true

func hit_2():
	Atacking = true
	$AnimatedSprite.play("Hit_2")
	$Hit_area_2/TimerHit2.start()
	$TimerHits.start()
	$Hit_area_2/CollisionShape2D.disabled = false
	CooldownHits.start()
	
func _on_TimerHit2_timeout():
	stopped = false
	Atacking = false
	$Hit_area_2/CollisionShape2D.disabled = true

func _on_Hit_area_body_entered(body):
		if Atacking == true:
			if body.is_in_group("Enemic"):
				body.damage(5)
				Hits += 1  


func _on_Hit_area_2_body_entered(body):
		if Atacking == true and Hits == 1:
			if body.is_in_group("Enemic"):
				body.damage(40)
				shield(20)
				Hits = 0
				


func _on_TimerHits_timeout():
	Hits = 0

func _on_Cooldown_Hits_timeout():
	CooldownHit = 10

func _on_Timer_timeout():
	if CooldownHits.is_stopped():
		$Cooldowns/Hit_c/Hit2.modulate = "ffffff"
	else:
		$Cooldowns/Hit_c/Hit2.modulate = "96ffffff"
		CooldownHit -= 1
		$Cooldowns/Hit_c/Hit.text = str(CooldownHit)
	if CooldownHit == 0:
		$Cooldowns/Hit_c/Hit.text = ""

func _on_Timer2_timeout():
	if Temps_atac.is_stopped():
		$Cooldowns/Fireball_c/Fireball1.modulate = "ffffff"
	else:
		$Cooldowns/Fireball_c/Fireball1.modulate = "96ffffff"
		CooldownFireball -= 1
		$Cooldowns/Fireball_c/Fireball.text = str(CooldownFireball)
		if CooldownFireball == 0:
			$Cooldowns/Fireball_c/Fireball.text = ""

func _on_Temps_atac_timeout():
	CooldownFireball = 5


func _on_Hit_c_mouse_entered():
	$Cooldowns/Hit_c/Info_hit.show()

func _on_Hit_c_mouse_exited():
	$Cooldowns/Hit_c/Info_hit.hide()

func _on_Fireball_c_mouse_entered():
	$Cooldowns/Fireball_c/Info_Fireball.show()

func _on_Fireball_c_mouse_exited():
	$Cooldowns/Fireball_c/Info_Fireball.hide()
