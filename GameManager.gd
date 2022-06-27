extends Node

# This script doesnt need to be attached to a node we will 
#set it to autoload in the project menu.

var current_player_name
var current_player_pic
func _ready():
	print("Game manager running!")
	

func load_player_data(player_name, current_scene):
	print("Loading player data!")
	current_player_name = player_name
	
	
	current_player_name = format_player_name(current_player_name)
	
	var file_path = "res://Data/" + current_player_name +".json"
	var file = File.new()
	if file.file_exists(file_path):
		var error = file.open(file_path, File.READ)
		if error == OK:
			var data = parse_json(file.get_as_text())
			current_player_pic = data["pic"]
			var next_lv
			if data["level"]:
				next_lv = load(data["level"])
			else:
				next_lv = load("res://Castle.tscn")

			var uselv = next_lv.instance()
			add_child(uselv)
			current_scene.queue_free()
			var player = get_tree().get_nodes_in_group("Player")[0]
			player.set_position_to(data["position"])
			
	file.close()
	
func set_sprite(sprite):
	sprite.texture = load(current_player_pic)
	

func change_scenes(scene_from, scene_to):
	var next_lv = load(scene_to)
	var uselv = next_lv.instance()
	
	add_child(uselv)
	scene_from.queue_free()

func format_player_name(use_name):
	#sam.json becomes sam
	var formatted_name
	if use_name.substr(use_name.length() - 5, use_name.length())==".json":
		formatted_name = use_name.substr(0, use_name.length() - 5)
		return formatted_name
	else:
		return use_name


func update_info(save_dict):
	print("Updating player data!")
	
	current_player_name = format_player_name(current_player_name)
		
	var file_path = "res://Data/" + current_player_name + ".json"
	var file = File.new()
	var data
	if file.file_exists(file_path):
		var error = file.open(file_path, File.READ)
		if error == OK:
			data = parse_json(file.get_as_text())
	file.close()

	# here we have to compare our players json file to the dictionary that we are saving 
	for keys in save_dict:
		if !data.has(keys):
			data[keys] = save_dict[keys]
		else:
			if str(data[keys]) != str(save_dict[keys]):
				print(save_dict[keys])
				data[keys] = save_dict[keys]
			else:
				pass
				
	var player_file = File.new()
	var use_path = "res://Data/" + current_player_name + ".json"
	
	player_file.open(use_path,File.WRITE_READ)
	var use_info = to_json(data)
	player_file.store_line(use_info)
	player_file.close()
	#print()
	

func new_game(start_screen, player_info):
	current_player_name = player_info["name"]
	current_player_pic = player_info["pic"]
	
	var player_file = File.new()
	var use_path = "res://Data/" + player_info["name"] + ".json"
	player_file.open(use_path,File.WRITE_READ)
	
	var use_info = to_json(player_info)
	player_file.store_line(use_info)
	player_file.close()
	change_scenes(start_screen, "res://Castle.tscn")
	
	
	
	
	
	
	
	
