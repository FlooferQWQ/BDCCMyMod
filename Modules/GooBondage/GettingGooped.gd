extends StatusEffectBase

func _init():
	id = "GettingGooped"
	isBattleOnly = false
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 20
	
func shouldApplyTo(_npc):
	if(_npc.inventory.hasEquippedItemWithTag("GoopsWearer")):
		return true
	return false
	
func initArgs(_args = []):
	pass

func processTime(_secondsPassed: int):
	var nullingItems = character.inventory.getEquippedItemsWithTag("GoopsWearer")
	for item in nullingItems:
		if item.has_method("processTime"):
			item.processTime(_secondsPassed)

func getEffectName():
	return "Getting Gooped"

func getEffectDesc():
	return "It's gloppy and viscous and it's getting everywhere."

func getEffectImage():
	return "res://Images/StatusEffects/transparent-slime.png"

func getIconColor():
	return IconColorGray

func getBuffs():
	var nullingItems = character.inventory.getEquippedItemsWithTag("GoopsWearer")
	return [
		buff(Buff.MaxStaminaBuff, [-10 * len(nullingItems)]),
	]
