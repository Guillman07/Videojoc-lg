extends Node2D

func execute(s, dir):
	s.velocity = Vector2()
	
	if dir == "up":
		s.velocity.y -= 1
	if dir == "down":
		s.velocity.y += 1
	if dir == "right":
		s.velocity.y += 1
	if dir == "left":
		s.velocity.y -= 1
		
	s.velocity = s.velocity.normalized()
	s.velocity = s.move_and_slide(s.velocity * s.max_speed)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
