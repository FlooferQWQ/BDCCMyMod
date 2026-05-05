extends ItemBase

func _init():
	id = "nullbulge_p"

func getVisibleName():
	return "Null Bulge (P)"

func getDescription():
	return "A rubbery glob that latches onto your groin. This variant targets the penis."

func getClothingSlot():
	return InventorySlot.Penis
	
func getRequiredBodypart():
	return BodypartSlot.Penis
	
func getHidesParts(_character):
	return {
		BodypartSlot.Penis: true,
	}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false

func getBuffs():
	return [
		buff(Buff.ChastityPenisBuff),
		buff(Buff.AmbientLustBuff, [40]),
		buff(Buff.PenisCumProductionBuff, [-50]),
		buff(Buff.PenisBallsVolumeBuff, [-50]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Penis, -100.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Penis, -100.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 40

func getSellPrice():
	return 8

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, "NullsWearer"]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/NullBulge/RestraintNullBulgeP.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "frees your penis from the null bulge"
	else:
		return "free your penis from the null bulge"

func getPuttingOnStringLong(withS):
	if(withS):
		return "traps your penis in the null bulge"
	else:
		return "trap your penis in the null bulge"

func getRiggedParts(_character):
	return {
		"null_bulge_p": "res://Modules/GooBondage/NullBulge/NullBulgeP.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck to"])+" your penis. It traps and teases your shaft!"
	else:
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck to"])+" {receiver.nameS} penis. It traps and teases {receiver.his} shaft!"

func getInventoryImage():
	return "res://Modules/GooBondage/NullBulge/nullBulgeIcon.png"

func processTime(_secondsPassed: int):
	var wearer = getWearer()
	if(wearer.getArousal() > 0.5):
		GM.main.addMessage(RNG.pick(["The null bulge limits the pleasure in " + wearer.getName() + "'s penis.", "The lock symbol on " + wearer.getName() + "'s null bulge glows.", wearer.getName() + " approaches orgasm, but the null bulge denies " + wearer.himHer() + "."]))
		wearer.addEffect(StatusEffect.DeniedDesperate)
		wearer.addStamina(1)
	wearer.setArousal(min(0.5, wearer.getArousal()))
