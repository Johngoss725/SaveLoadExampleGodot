extends Control

onready var player_info = {}

func _ready():
	populate_loading_screen()

func show_load_menu():
	$LoadingScreen.visible = true
	
func hide_load_menu():
	$LoadingScreen.visible = false

func show_newgame_menu():
	$NewScreen.visible = true
	
func hide_newgame_menu():
	$NewScreen.visible = false



func _on_LoadGame_pressed():
	show_load_menu() 
	

func load_new_game(filename):
	print("We are loading the game with the filename " + filename)
	GameManager.load_player_data(filename, self)

func create_new_game():
	if player_info["class"]:
		match player_info["class"]:
			"ORC":
				player_info["pic"]="res://Pics/ORC.jpeg"
				
			"WARRIOR":
				player_info["pic"]="res://Pics/WARRIOR.jpeg"
				
			"ASSASIN":
				player_info["pic"]="res://Pics/ASSASIN.jpeg"
				
		GameManager.new_game(self,player_info)
	else:
		print("You didn't select a class yet.")

func _on_Class_pressed(use_class):
	print("We are the " + use_class + " class.")
	player_info["class"] = use_class
	player_info["name"] = $NewScreen/TextEdit.text
	player_info["level"] = "res://Castle.tscn"
	player_info["position"] = Vector2(0,0)
	
	create_new_game()
	
func populate_loading_screen():
	
	var dir = Directory.new()
	
	var available_load = []
	
	if dir.open("res://Data") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
				#print("Found directory: " + file_name)
			else:
				available_load.append(file_name)
				#print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

	for files in available_load:
		var button = Button.new()
		button.text = files
		button.connect("pressed", self, "load_new_game", [files])
		
		$LoadingScreen/VBoxContainer.add_child(button)
		
	
	
func _on_NewGameshow_pressed():
	show_newgame_menu()
