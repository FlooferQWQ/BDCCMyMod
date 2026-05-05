extends SceneBase


var uniqueItemID#: Dictionary
var charInUse

func _init():
	sceneID = "ToySwitch"
	
func _initScene(_args = []):
	uniqueItemID = _args[0]
	setState("")
	
func _run():
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	var box = GM.main.getCharacter("ToysBox")
	if item.turnON != "on":
		item.turnON = "on"
		box.setToysStats(GM.pc.get_name(), item.toyStats(), item)
		GM.pc.updateAppearance()
	else:
		item.turnON = "off"
		box.removeToysStats(GM.pc.get_name(), item.toyStats())
		GM.pc.updateAppearance()
		#playAnimation(StageScene.Solo, "stand", {bodyState={naked=true}})
		#setTransfer.merge({current_part: current_style},true)
		#item.getTransfer = setTransfer
		
		#playAnimation(StageScene.Solo, "stand")
	
	endScene()
	return

func getCharacters():
	var charactersList = []
	for character in GM.main.getCharacter("ToysBox").charactersList:
		if character != "Player":
			charactersList.append(GM.main.getCharacter(character))
		else:
			charactersList.append(GM.main.getCurrentPC())
	return charactersList #GM.main.getCharacter("ToysBox").charactersList
