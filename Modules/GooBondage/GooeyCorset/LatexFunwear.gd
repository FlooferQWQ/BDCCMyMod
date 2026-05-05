extends ItemBase

func _init():
	id = "latexfunwear"

func getVisibleName():
	return "Latex Funwear"

func getDescription():
	return "A set of Gooey Lingerie that's lost its potency and is safe to use as outerwear. Like the original, it doesn't cover your crotch."

func getClothingSlot():
	return InventorySlot.Body

func coversBodyparts():
	if(itemState.isRemoved()):
		return {}
	return {
		BodypartSlot.Breasts: true,
		BodypartSlot.Body: true,
	}

func getBuffs():
	return [
		buff(Buff.BreastsMilkProductionBuff, [20]),
		buff(Buff.PregnantBellySizeModifierBuff, [-20.0])
		]

func getPrice():
	return 50

func getSellPrice():
	return 10

func canSell():
	return true

func getTags():
	return [
		ItemTag.SoldByUnderwearVendomat,
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes the latex funwear off"
	else:
		return "take the latex funwear off"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts the latex funwear on"
	else:
		return "put the latex funwear on"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"latex_corset": "res://Modules/GooBondage/GooeyCorset/CorsetUpper.tscn",
		"latex_boobs": "res://Modules/GooBondage/GooBoobs/LatexCups.tscn",
		"latex_panties": "res://Modules/GooBondage/GooeyCorset/PantiesUpper.tscn",
	}
