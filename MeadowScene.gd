extends Node2D

func _ready():
	pass # Replace with function body.

func save_game():
	var save_dict = {}
	var player = get_tree().get_nodes_in_group("Player")[0]
	save_dict["position"] = player.position
	save_dict["level"] = "res://MeadowScene.tscn"
	GameManager.update_info(save_dict)



func _on_Button_pressed():
	save_game()


func _on_Button2_pressed():
	var save_dict = {}
	save_dict["level"]="res://MeadowScene.tscn"
	GameManager.change_scenes(self, "res://Castle.tscn")
