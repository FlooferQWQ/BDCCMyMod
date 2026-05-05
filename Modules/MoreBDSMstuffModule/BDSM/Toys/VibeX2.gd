extends ItemBase

var turnON:String = "off"
var character
var timeOld

func _init():
	id = "dildo"
	set_meta("Toy",1)

func getVisibleName():
	return "Vibro dildo"
	
func getDescription():
	return "Pink vibrator with vibro-motor inside"

func getClothingSlot():
	return InventorySlot.Vagina

func getRequiredBodypart():
	return BodypartSlot.Vagina

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [30]),
		buff(Buff.SensitivityGainBuff, [30.0]),
		buff(Buff.MinLoosenessVaginaBuff, [3.0]),
		buff(Buff.BlocksVaginaLeakingBuff),
		]

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer,]# ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintVaginalplug.new()
	restraintData.setLevel(5)

func getTakingOffStringLong(withS):
	turnON = "off"
	GM.main.getCharacter("ToysBox").removeCharacterWithItem(character, id)
	if(withS):
		return "slides the dildo out from your pussy"
	else:
		return "slide the dildo out from your pussy"

func getPuttingOnStringLong(withS):
	if(withS):
		return "inserts the dildo into your pussy"
	else:
		return "insert the dildo into your pussy"

func getRiggedParts(_character):
	
	GM.main.getCharacter("ToysBox").getCharacterWithItem(_character, id)
	character = _character
	
	var sensitiveZone:SensitiveZone = _character.getBodypart(getRequiredBodypart()).getSensitiveZone()
	
	if turnON == "on":
		var timeNew = GM.main.getTime()
		if timeOld != null:
			if timeOld != timeNew:
				if abs(round(timeNew/60)-round(timeOld/60)) > 0:
					for _i in range(round(timeNew/60)-round(timeOld/60)):
						sensitiveZone.stimulate(1)
						sensitiveZone.onDenyTick()
						if sensitiveZone.getSensitivity() >= 3:
							_character.getEffect(StatusEffect.InHeat)
							break
					for _i in range((round(timeNew/60)-round(timeOld/60))/10):
						if _character.getArousal() >= 0.90:
							_character.getEffect(StatusEffect.InHeat)
							break
						_character.addArousal(0.05)
		timeOld = timeNew

	return {
		"dildo": "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/Dl1.tscn",
	}
	
func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Vagina) || _doll.isForcedExposed(BodypartSlot.Vagina)):
		return true
	return false
	
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/dl.png"

func saveData():
	var data = .saveData()
	
	data ["turnON"] = turnON
	return data
	
func loadData(data):
	.loadData(data)
	
	turnON = SAVE.loadVar(data, "turnON", "")

func toyStats():
	return {
		"lust": 20,
		"sensitivity": 5,
		"arousal": 0.03,
	}
