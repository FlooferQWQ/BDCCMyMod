extends "res://Scenes/Item/PutOnAnyItemScene.gd"

func _init():
	sceneID = "PutOnWithEquipEffectScene"

func _run():
	if(state == ""):
		if(uniqueItemID == null || uniqueItemID == ""):
			addButton("Continue", "Oops", "endthescene")
			return
		
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("Error: no item found")
		else:
			saynn("You "+item.getPuttingOnStringLong(false))
			item.onEquippedBy(GM.pc, false)
			GM.pc.updateAppearance()
		
		addButton("Continue", "You put on an item", "endthescene")

	if(state == "awkwardputon"):
		if(uniqueItemID == null || uniqueItemID == ""):
			addButton("Continue", "Oops", "endthescene")
			return
		
		var item: ItemBase = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item == null):
			saynn("Error: no item found")
		else:
			saynn("It's very awkward to do with bound arms but you just about managed. You "+item.getPuttingOnStringLong(false))
			item.onEquippedBy(GM.pc, false)
			GM.pc.updateAppearance()
		
		addButton("Continue", "You put on an item", "endthescene")

	if(state == "blockedhands"):
		saynn("You really try to put that on but your blocked hands prevent you from doing so")
		
		addButton("Continue", "Aww", "endthescene")
		
