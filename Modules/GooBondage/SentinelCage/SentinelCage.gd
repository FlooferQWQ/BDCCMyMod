extends ItemBase

func _init():
	id = "sentinel_cage"

func getVisibleName():
	return "Sentinel Cage"

func getDescription():
	return "A rubbery cock cage that encases a penis and prevents breeding while still allowing its use."

func getClothingSlot():
	return InventorySlot.Penis
	
func getRequiredBodypart():
	return BodypartSlot.Penis

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [50]),
		buff(Buff.PenisCumProductionBuff, [-999]),
		buff(Buff.PenisBallsVolumeBuff, [-999]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Penis, -100.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Penis, -100.0]),
		buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Penis, -100.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 80

func getSellPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/SentinelCage/RestraintSentinelCage.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "frees your penis from the Sentinel cage"
	else:
		return "free your penis from the Sentinel cage"

func getPuttingOnStringLong(withS):
	if(withS):
		return "traps your penis in the Sentinel cage"
	else:
		return "trap your penis in the Sentinel cage"

func getRiggedParts(_character):
	return {
		"penis": "res://Modules/GooBondage/SentinelCage/SentinelCage.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck onto"])+" your penis. It drains your cum and encases your shaft!"
	else:
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck onto"])+" {receiver.nameS} penis. It drains {receiver.his} cum and encases {receiver.his} shaft!"

func getInventoryImage():
	return "res://Modules/GooBondage/SentinelCage/sentinelCageIcon.png"
