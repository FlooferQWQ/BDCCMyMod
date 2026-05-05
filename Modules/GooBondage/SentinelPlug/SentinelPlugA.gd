extends ItemBase

var hidePlug = false

func _init():
	id = "sentinel_plug_a"

func getVisibleName():
	return "Sentinel Plug (A)"

func getDescription():
	return "A highly experimental model of dildo plug with vibration, lubrication, and electrostim features. This version goes up the ass."

func getClothingSlot():
	return InventorySlot.Anal
	
func getRequiredBodypart():
	return BodypartSlot.Anus

func shouldBeVisibleOnDoll(_character, _doll):
	if(hidePlug == true && !GM.main.getCurrentScene().supportsSexEngine()):
		hidePlug = false
	if((!_character.isBodypartCovered(BodypartSlot.Anus) || _doll.isForcedExposed(BodypartSlot.Anus)) && !hidePlug):
		return true
	return false
	
func onSexEvent(_event):
	if(_event.getType() == "HolePenetration"
	&& _event.getTargetChar() == getWearer()
	&& _event.getField("hole") == "anus"):
		hidePlug = true
		getWearer().updateAppearance()
	
	if(restraintData != null):
		restraintData.handleSexEvent(_event)

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [40]),
		buff(Buff.MinLoosenessAnusBuff, [3.5]),
		buff(Buff.BlocksAnusLeakingBuff),
		buff(Buff.GenitalElasticityBuff, [100.0]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Anus, 25.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Anus, 50.0]),
		buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Anus, 25.0]),
		]

func processTime(_secondsPassed: int):
	getWearer().getBodypart(BodypartSlot.Anus).addFluidOrifice("BlackGoo", RNG.randf_range(3.0, 6.0))

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
	restraintData = load("res://Modules/GooBondage/SentinelPlug/RestraintSentinelPlugA.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "pulls the Sentinel plug out of your butt"
	else:
		return "pull the Sentinel plug out of your butt"

func getPuttingOnStringLong(withS):
	if(withS):
		return "inserts the Sentinel plug into your butt"
	else:
		return "insert the Sentinel plug into your butt"

func getRiggedParts(_character):
	return {
		"sentinel_plug_a": "res://Modules/GooBondage/SentinelPlug/SentinelPlugA.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was stuffed into your "+RNG.pick(["anus", "rear hole", "rear", "butt", "tailhole"])+". It starts filling you with goo!"
	else:
		return getAStackNameCapitalize()+" was stuffed into {receiver.nameS} "+RNG.pick(["anus", "rear hole", "rear", "butt", "tailhole"])+". It starts filling {receiver.him} with goo!"

func getInventoryImage():
	return "res://Modules/GooBondage/SentinelPlug/sentinelPlugIconA.png"
