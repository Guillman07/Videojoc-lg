extends KinematicBody2D

var velocitat = 300
var moviment = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moviment = Vector2()
	
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
		
	position += moviment * delta
	
	animacio(moviment)
	
func animacio(moviment):
	
	if moviment.x > 0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif moviment.x < -0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
		
	if abs(moviment.x) < 0.1:
		$AnimatedSprite.play("Idle")
