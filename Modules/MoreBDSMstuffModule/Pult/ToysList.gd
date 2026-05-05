extends SceneBase


var toys#: Dictionary
var charInUse

func _init():
	sceneID = "ToysList"
	
func _initScene(_args = []):
	setState("")
	
func _run():
	
	if(state == ""):
		addButton("Done", "End toys set up", "endthescene")
		for character in getCharacters():
			if character != GM.pc:
				addButton(character._getName(), "Show toys", "change", character)
			else:
				addButton("Me", "Show toys", "change", character)

	if(state == "change"):
		addButton("Back", "Done here", "")
		addButton("Turn on all", "Full speed ahead!", "all_on")
		addButton("Turn off all", "Full back!", "all_off")
		for toy in toys:
			var item:ItemBase = toys[toy]
			if item.has_meta("Toy"):
			#toy.get_value()
			#var item = charInUse.getInventory().get
				addButton(item.getVisibleName(), "Current state: "+str(item.turnON), "On_Off", item)
			#else:
			#	continue
		
		
func _react(_action: String, _args):

	if(_action == "endthescene"):
		endScene()
		
	if(_action == "change"):
		toys = _args.getInventory().getAllEquippedItems()
		charInUse = _args
		
	if(_action == "all_on"):
		var box = GM.main.getCharacter("ToysBox")
		for toy in toys:
			var item:ItemBase = toys[toy]
			if item.has_meta("Toy"):
				if item.turnON != "on":
					item.turnON = "on"
					box.setToysStats(charInUse.get_name(), item.toyStats(), item)
					
		charInUse.updateAppearance()
		setState("change")
		return
		
	if(_action == "all_off"):
		var box = GM.main.getCharacter("ToysBox")
		for toy in toys:
			var item:ItemBase = toys[toy]
			if item.has_meta("Toy"):
				if item.turnON != "off":
					item.turnON = "off"
					box.removeToysStats(charInUse.get_name(), item.toyStats())
					
		charInUse.updateAppearance()
		setState("change")
		return
		
	if(_action == "On_Off"):
		var box = GM.main.getCharacter("ToysBox")
		if _args.turnON != "on":
			_args.turnON = "on"
			box.setToysStats(charInUse.get_name(), _args.toyStats(), _args)
		else:
			_args.turnON = "off"
			box.removeToysStats(charInUse.get_name(), _args.toyStats())
			
		charInUse.updateAppearance()
		#playAnimation(StageScene.Solo, "stand", {bodyState={naked=true}})

		setState("change")
		return
	
	setState(_action)
	return

func getCharacters():
	#print(GM.main.getCharacter("ToysBox").charactersList)
	#print(GM.main.getCharacter("ToysBox").id)
	var charactersList = []
	for character in GM.main.getCharacter("ToysBox").charactersList:
		if character != "Player":
			if GM.main.getCharacter(character) != null:
				charactersList.append(GM.main.getCharacter(character))
		else:
			charactersList.append(GM.main.getCurrentPC())
	return charactersList #GM.main.getCharacter("ToysBox").charactersList
