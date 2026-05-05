extends ItemBase

func _init():
	id = "latexcups"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Latex Cups"

func getA():
	return ""

func getDescription():
	return "Goo Boobs that have been rendered inert and safe to wear!"

func getClothingSlot():
	return InventorySlot.UnderwearTop

func coversBodyparts():
	if(itemState.isRemoved()):
		return {}
	return {
		BodypartSlot.Breasts: true,
	}

func getBuffs():
	return [
		buff(Buff.LustArmorBuff, [20]),
		buff(Buff.BreastsLactatingSizeLimitBuff, [1]),
		buff(Buff.BreastsMilkProductionBuff, [25]),
		]

func getPrice():
	return 15

func getSellPrice():
	return 3

func canSell():
	return true

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes the latex cups off your chest"
	else:
		return "take the latex cups off your chest"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts the latex cups on your chest"
	else:
		return "put the latex cups on your chest"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"bra": "res://Modules/GooBondage/GooBoobs/LatexCups.tscn",
	}

func getInventoryImage():
	return "res://Images/Items/underwear/lacebra.png"
