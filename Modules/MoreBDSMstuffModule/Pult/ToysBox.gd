extends Character

var toysStats: Dictionary = {}
var charactersList: Array = []


func _init():
	id = "ToysBox"
	
func _getName():
	return "Toys box"

func getCharacterWithItem(character, _itemID):
	
	#print(charactersList)
	#print(toysStats)
	
	var characterID = character.get_name()
	if character.get_name() != "Player":
		characterID = character.id
		
	if charactersList.has(characterID) == false:
		
		#var item = character.getInventory().getEquippedItemByID(itemID)
		
		return charactersList.append(characterID)
		
func removeCharacterWithItem(character, _itemID):
	var characterID = character.get_name()
	if character.get_name() != "Player":
		characterID = character.id
		
	if charactersList.has(characterID) == true:
		var items = character.getInventory().getAllEquippedItems()
		var checkMe = false
				
		for toy in items:
			var itemM:ItemBase = items[toy]
			if itemM.has_meta("Toy"):
				checkMe = true
				break
		if checkMe == false:
			charactersList.erase(characterID)
			toysStats.erase(characterID)
			
		#print(charactersList, characterID, toysStats)
		
		return
		
func setToysStats(characterID, stats, _itemID):
	if toysStats.has(characterID) == false:
		toysStats.merge({characterID:[0,0,0]})
	var statsPerTic = [
		toysStats[characterID][0] + stats["lust"],
		toysStats[characterID][1] + stats["sensitivity"],
		toysStats[characterID][2] + stats["arousal"],
		]
	toysStats.merge({characterID: statsPerTic}, true)
	return
	
func removeToysStats(characterID, stats):
	if charactersList.has(characterID) == false:
		toysStats.erase(characterID)
		return
	var statsPerTic = [
		toysStats[characterID][0] - stats["lust"],
		toysStats[characterID][1] - stats["sensitivity"],
		toysStats[characterID][2] - stats["arousal"],
		]
	toysStats.merge({characterID: statsPerTic}, true)
	
	return
	
func saveData():
	var data = .saveData()
	data["toys"] = toysStats
	data["Chars"] = charactersList
	return data

func loadData(data):
	.loadData(data)
	toysStats = SAVE.loadVar(data, "toys", {})	
	charactersList = SAVE.loadVar(data, "Chars",[])
