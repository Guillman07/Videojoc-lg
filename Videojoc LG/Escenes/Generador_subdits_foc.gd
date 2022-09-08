extends Area2D

const Subdit_foc = preload("res://Escenes/Subdit_foc.tscn")

onready var Timer_gen = $Timer_gen

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Timer_gen.start()


func _on_Generador_subdits_foc_body_entered(body):
	if body.is_in_group("Protagonista"):
		if Subdit_foc:
			var subdit_foc = Subdit_foc.instance()
			get_tree().current_scene.add_child(subdit_foc) 
			subdit_foc.global_position = self.global_position
			print("a")
