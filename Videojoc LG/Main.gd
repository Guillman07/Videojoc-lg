extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var joc_info = $joc_info.get_data("")
	
	joc_info["Idioma"] = {
		"idioma" : "English"
	}
	
	joc_info["Info_Jugador"] = {
		"monedes" : "3"
	}
	 
	$joc_info.save_data()
	
	print_debug(joc_info["Idioma"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
