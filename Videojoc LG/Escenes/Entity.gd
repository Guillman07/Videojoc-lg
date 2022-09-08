extends KinematicBody2D
class_name Entity

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()

var max_health : int = 100
var current_health : int = 100
var health_regen : int = 1
var armor : int = 0

var max_poder : int = 100
var current_poder : int = 100
var poder_regen : int = 1

var max_speed : float = 200
var current_speed : float = 0
var acceleration : float = 4

var agility : int = 1

var global_cooldown = 30
var is_busy : bool = false
var last_ability : int = 0

func regen_health():
	if (current_health < max_health):
		if ((health_regen + current_health) > max_health):
			current_health = max_health
		else: current_health += health_regen

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
	
func apply_damage(amount):
	if (armor > 0): amount = amount * ((100 - armor)* .01)
	if (current_health > amount): current_health -= amount
	else: print("death")
	
	
func _physics_process(delta):
	last_ability += 1
	if ((game_master.count % 60) == 0):#every 1 sec
		regen_health()
		regen_poder()
		
func load_ability(name):
	var scene = load("res://Escenes/abilities/" + name + "/" + name + ".tscn")
	var sceneNode = scene.instance()
	add_child(sceneNode)
	return sceneNode
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
