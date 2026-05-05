extends ItemBase

func _init():
	id = "nullbulge_v"

func getVisibleName():
	return "Null Bulge (V)"

func getDescription():
	return "A rubbery glob that latches onto your groin. This variant targets the vagina."

func getClothingSlot():
	return InventorySlot.Vagina
	
func getRequiredBodypart():
	return BodypartSlot.Vagina
	
func getHidesParts(_character):
	return {
		BodypartSlot.Vagina: true,
	}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Vagina) || _doll.isForcedExposed(BodypartSlot.Vagina)):
		return true
	return false

func getBuffs():
	return [
		buff(Buff.ChastityVaginaBuff),
		buff(Buff.AmbientLustBuff, [40]),
		buff(Buff.BlocksVaginaLeakingBuff),
		buff(Buff.MinLoosenessVaginaBuff, [2.5]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Vagina, -100.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Vagina, -100.0]),
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
	restraintData = load("res://Modules/GooBondage/NullBulge/RestraintNullBulgeV.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "frees your vagina from the null bulge"
	else:
		return "free your vagina from the null bulge"

func getPuttingOnStringLong(withS):
	if(withS):
		return "traps your vagina in the null bulge"
	else:
		return "trap your vagina in the null bulge"

func getRiggedParts(_character):
	return {
		"null_bulge_v": "res://Modules/GooBondage/NullBulge/NullBulgeV.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck to"])+" your "+RNG.pick(["pussy", "vagina", "slit"])+". It fits a dildo into your vagina as it teases your clit!"
	else:
		return getAStackNameCapitalize()+" was "+RNG.pick(["forced over", "put on", "stuck to"])+" {receiver.nameS} "+RNG.pick(["pussy", "vagina", "slit"])+". It fits a dildo into {receiver.his} vagina as it teases {receiver.his} clit!"

func getInventoryImage():
	return "res://Modules/GooBondage/NullBulge/nullBulgeIconV.png"

func processTime(_secondsPassed: int):
	var wearer = getWearer()
	if(wearer.getArousal() > 0.5):
		GM.main.addMessage(RNG.pick(["An orgasm-suppressing pressure clamps down around " + wearer.getName() + "'s pussy.", "The heart symbol on " + wearer.getName() + "'s null bulge glows.", wearer.getName() + " starts getting close to orgasm, but the null bulge keeps " + wearer.himHer() + " edged."]))
		wearer.addEffect(StatusEffect.DeniedDesperate)
		wearer.addStamina(1)
	wearer.setArousal(min(0.5, wearer.getArousal()))
