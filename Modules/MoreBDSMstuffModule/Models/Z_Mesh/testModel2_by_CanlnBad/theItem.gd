extends ItemBase

func _init():
	id = "testModel"

func getVisibleName():
	return "Test"
	
func getDescription():
	return "What? These are just squares attached to your hands???? How are they preventing you from using your hands????"

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"hands": "res://Modules/testModel/SquareHands.tscn" # the key can be anything from what I have been observing, I don't know what function uses this exactly
	}

func getClothingSlot():
	return InventorySlot.Hands

func getBuffs():
	return [
		buff(Buff.BlockedHandsBuff),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 4

func getSellPrice():
	return 1

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintMittens.new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was forced onto you. Hands, now!"
	else:
		return getAStackNameCapitalize()+" was forced onto {receiver.name}! No more biting for {receiver.him}!"

func getInventoryImage():
	return "res://Modules/testModel/cube.png"
