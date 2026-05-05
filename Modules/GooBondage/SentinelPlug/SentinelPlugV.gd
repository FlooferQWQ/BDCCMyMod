extends ItemBase

var hidePlug = false

func _init():
	id = "sentinel_plug_v"

func getVisibleName():
	return "Sentinel Plug (V)"

func getDescription():
	return "A highly experimental model of dildo plug with vibration, lubrication, and electrostim features. This version befits a vagina."

func getClothingSlot():
	return InventorySlot.Vagina
	
func getRequiredBodypart():
	return BodypartSlot.Vagina

func shouldBeVisibleOnDoll(_character, _doll):
	if(hidePlug == true && !GM.main.getCurrentScene().supportsSexEngine()):
		hidePlug = false
	if((!_character.isBodypartCovered(BodypartSlot.Vagina) || _doll.isForcedExposed(BodypartSlot.Vagina)) && !hidePlug):
		return true
	return false
	
func onSexEvent(_event):
	if(_event.getType() == "HolePenetration"
	&& _event.getTargetChar() == getWearer()
	&& _event.getField("hole") == "vagina"):
		hidePlug = true
		getWearer().updateAppearance()
	
	if(restraintData != null):
		restraintData.handleSexEvent(_event)

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [40]),
		buff(Buff.MinLoosenessVaginaBuff, [3.5]),
		buff(Buff.BlocksVaginaLeakingBuff),
		buff(Buff.GenitalElasticityBuff, [100.0]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Vagina, 25.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Vagina, 50.0]),
		buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Vagina, 25.0]),
		]

func processTime(_secondsPassed: int):
	getWearer().getBodypart(BodypartSlot.Vagina).addFluidOrifice("BlackGoo", RNG.randf_range(3.0, 6.0))

func getPrice():
	return 50

func getSellPrice():
	return 10

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedByGuards, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, "GoopsWearer"]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/SentinelPlug/RestraintSentinelPlugV.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "pulls the Sentinel plug out of your vagina"
	else:
		return "pull the Sentinel plug out of your vagina"

func getPuttingOnStringLong(withS):
	if(withS):
		return "presses the Sentinel plug into your vagina"
	else:
		return "press the Sentinel plug into your vagina"

func getRiggedParts(_character):
	return {
		"sentinel_plug_v": "res://Modules/GooBondage/SentinelPlug/SentinelPlugV.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was stuffed into your "+RNG.pick(["pussy", "vagina", "slit"])+". It starts filling you with goo!"
	else:
		return getAStackNameCapitalize()+" was stuffed into {receiver.nameS} "+RNG.pick(["pussy", "vagina", "slit"])+". It starts filling {receiver.him} with goo!"

func getInventoryImage():
	return "res://Modules/GooBondage/SentinelPlug/sentinelPlugIconV.png"
