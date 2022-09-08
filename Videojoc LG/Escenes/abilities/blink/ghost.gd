extends KinematicBody2D

var velocity = Vector2()

var direction = null
var distance = null
var speed = null
var parent = null
var moved = 0

func configure(s = null , my_direction = null, my_distance = null , my_speed = null):
	parent = s 
	direction = my_direction
	distance = my_distance
	speed = my_speed
	look_at(s.position + my_direction)
