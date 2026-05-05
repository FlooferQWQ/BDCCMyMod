extends ItemBase

func _init():
	id = "gooeycorset"

func getVisibleName():
	return "Gooey Corset"

func getDescription():
	return "A shiny corset that...drips with goo? No problem here."

func getClothingSlot():
	return InventorySlot.Torso

func getBuffs():
	return [
		buff(Buff.PregnantBellySizeModifierBuff, [-50.0])
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 30

func getSellPrice():
	return 6

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, "GoopsWearer"]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/GooeyCorset/RestraintGooeyCorset.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "tears the gooey corset off"
	else:
		return "tear the gooey corset off"

func getPuttingOnStringLong(withS):
	if(withS):
		return "sticks the gooey corset on"
	else:
		return "stick the gooey corset on"

func getForcedOnMessage(isPlayer = true):
	var message = ""
	if(isPlayer):
		message = getAStackNameCapitalize()+" was "+RNG.pick(["stuck", "glued", "forced", "placed"])+" around your waist. A sticky warmth oozes over you!"
	else:
		message = getAStackNameCapitalize()+" was "+RNG.pick(["stuck", "glued", "forced", "placed"])+" around {receiver.nameS} waist. A sticky warmth oozes over {receiver.him}!"
	return message

func processTime(_secondsPassed: int):
	getWearer().coverBodyWithFluid("BlackGoo", RNG.randf_range(1.0, 5.0))

func getRiggedParts(_character):
	return {
		"corset": "res://Inventory/RiggedModels/PuppyCorset/PuppyCorset.tscn",
	}
