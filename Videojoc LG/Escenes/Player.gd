extends KinematicBody2D

var velocitat = Vector2.ZERO
var velocitat_base = 300
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func physics_process(delta):
	velocitat.x = 0
	velocitat.y = 0
	
	if Input.is_action_just_pressed("Est"):
		print("EST")
		velocitat += Vector2.RIGHT * velocitat_base
	if Input.is_action_just_pressed("Oest"):
		print("OEST")
		velocitat += Vector2.LEFT * velocitat_base
	if Input.is_action_just_pressed("Nord"):
		print("NORD")
		velocitat += Vector2.UP * velocitat_base
	if Input.is_action_just_pressed("Sud"):
		print("SUD")
		velocitat += Vector2.DOWN * velocitat_base
	
	move_and_slide(velocitat)
	animacio(velocitat)
	
func animacio(velocitat):
	
	if velocitat.x > 0:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif velocitat.x < 0:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
		
	elif velocitat.x == 0:
		$AnimatedSprite.play("Idle")
