extends Area2D

#var direccio = Vector2(1,0)
var velocitat = 300
var dmg = 20
func _physics_process(delta):
	
	#var collision_info = move_and_collide(direccio.normalized() * delta * velocitat)
	
	#if collision_info != null:
		#queue_free()
	
	var direccio = Vector2.RIGHT.rotated(rotation)
	global_position += velocitat * direccio * delta
	
func destruir():
	queue_free()

func _on_Area2D_area_entered(area):
	destruir()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Protagonista"):
		body.damage_player(dmg)
		destruir()
	if body.is_in_group("Enemic"):
		pass
	else:
		destruir()
