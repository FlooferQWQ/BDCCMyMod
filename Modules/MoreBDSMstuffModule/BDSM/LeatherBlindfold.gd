extends ItemBase

func _init():
	id = "leatherblindfold"

func getVisibleName():
	return "Leather Blindfold"
	
func getDescription():
	return "Comfortable and durable leather blindfold"

func getClothingSlot():
	return InventorySlot.Eyes

func getBuffs():
	return [
		buff(Buff.BlindfoldBuff),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBlindfold.new()
	restraintData.setLevel(5)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was forced over your eyes. You are blind!"
	else:
		return getAStackNameCapitalize()+" was forced over {receiver.nameS} eyes! {receiver.He} {receiver.is} blind!"

func getUnriggedParts(_character):

	return {
		"blindfold": ["res://Modules/MoreBDSMstuffModule/Models/Blindfold/BlindfoldModel.tscn"],
	}

func getInventoryImage():
	return "res://Images/Items/bdsm/blindfold.png"
