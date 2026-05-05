extends StatusEffectBase

func _init():
	id = "Nulled"
	isBattleOnly = false
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 1000
	
func shouldApplyTo(_npc):
	if(_npc.inventory.hasEquippedItemWithTag("NullsWearer")):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processSexTurn():	
	var nullingItems = character.inventory.getEquippedItemsWithTag("NullsWearer")
	nullingItems.shuffle()
	for item in nullingItems:
		if item.has_method("processTime"):
			item.processTime(60)

func getEffectName():
	return "Nulled"

func getEffectDesc():
	return "Your genitals are nulled. You can't cum during sex!"

func getEffectImage():
	return "res://Images/StatusEffects/transparent-slime.png"

func getIconColor():
	return IconColorDarkPurple
