extends Node


#ghost is a kinematicbody 2d
var ghost = load("res://Escenes/abilities/blink/ghost.tscn")

var distance = 60
var speed = 200
var cooldown = 5

func execute(s, direction = null):
	if  !direction: direction = (s.get_global_mouse_position() - s.position).normalized()
	var look_at = s.get_global_mouse_position()
	
	var g = ghost.instance()
	g.position.x = s.position.x + direction.x * 50
	g.position.y = s.position.y + direction.y * 50
	g.configure(s,direction,distance,speed)
	get_node("/root").add_child(g)
