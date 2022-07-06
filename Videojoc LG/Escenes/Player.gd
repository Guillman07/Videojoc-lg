extends KinematicBody2D

var velocitat = Vector2.ZERO
var velocitat_base = 300
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocitat = Vector2.ZERO
	if Input.is_action_pressed("Est"):
		velocitat += Vector2.RIGHT * velocitat_base
	if Input.is_action_pressed("Oest"):
		velocitat += Vector2.LEFT * velocitat_base
	if Input.is_action_pressed("Nord"):
		velocitat += Vector2.UP * velocitat_base
	if Input.is_action_pressed("Sud"):
		velocitat += Vector2.DOWN * velocitat_base
	
	
	
		animacio(velocitat)
	
func animacio(velocitat):
	
	if velocitat.x > 0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif velocitat.x < -0.1:
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
		
	if abs(velocitat.x) < 0.1:
		$AnimatedSprite.play("Idle")
