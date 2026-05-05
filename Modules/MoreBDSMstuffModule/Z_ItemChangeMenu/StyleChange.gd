extends SceneBase

var uniqueItemID = ""

var current_part
var current_style
var setTransfer = {}

func _init():
	
	sceneID = "StyleChange"
	

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func _run():
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID) # referring to an item node in the inventory 
	var description: String = ""
	
	if(state == ""):
		playAnimation(StageScene.Solo, "stand")
		for part in item.ItemPart.keys():
			addButton(part, "", "change", part)
			
		addButton("Done", "Looks better now!", "endthescene")
		
	if(state == "change"):
		for style in item.ItemPart[current_part]:
			if item.has_meta("ItemDescription"):
				if item.ItemDescription.has(style):
					description = item.ItemDescription[style]
				else:
					description = ""
			addButton(style, description, "style", style)
			
		addButton("Back", "Done here", "")
		
func _react(_action: String, _args):
	var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
	
	if(_action == "endthescene"):
		endScene()
		
	if(_action == "change"):
		current_part = _args

	if(_action == "style"):
		
		playAnimation(StageScene.Solo, "stand", {bodyState={naked=true}}) #обновляет модель предмета
		
		current_style = _args
		
		setTransfer.merge({current_part: current_style},true)
		item.getTransfer.merge(setTransfer, true)
		
		playAnimation(StageScene.Solo, "stand")
		setState("change")
		return
	
	setState(_action)
	return

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
		
	return null
