extends ItemBase

func _init():
	id = "crotchlesspanties"

func getVisibleName():
	return "Crotchless Panties"

func getDescription():
	return "These forgo practicality for...utility, shall we say."

func getClothingSlot():
	return InventorySlot.UnderwearBottom

func getBuffs():
	return [
		buff(Buff.StatBuff, [Stat.Sexiness, 10]),
		]

func getPrice():
	return 10

func getSellPrice():
	return 2

func canSell():
	return true

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "slips the crotchless panties off"
	else:
		return "slip the crotchless panties off"

func getPuttingOnStringLong(withS):
	if(withS):
		return "slips the crotchless panties on"
	else:
		return "slip the crotchless panties on"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"panties": "res://Inventory/RiggedModels/Panties/Panties.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/lacepanties.png"
