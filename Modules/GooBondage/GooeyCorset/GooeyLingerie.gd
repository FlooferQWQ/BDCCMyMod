extends ItemBase

var originalBreastSize
var originalBreastVolume

func _init():
	id = "gooeylingerie"

func getVisibleName():
	return "Gooey Lingerie"

func getDescription():
	return "Now with crotchless panties!"

func getA():
	return ""

func getClothingSlot():
	return InventorySlot.Torso

func getRequiredBodypart():
	return BodypartSlot.Breasts

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [40]),
		buff(Buff.BreastsLactatingSizeLimitBuff, [1]),
		buff(Buff.BreastsMilkProductionBuff, [100]),
		buff(Buff.PregnantBellySizeModifierBuff, [-50.0]),
		buff(Buff.SensitivityRestoreBuff, [BodypartSlot.Breasts, 25.0]),
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Breasts, -25.0]),
		buff(Buff.OverstimulationThresholdBuff, [BodypartSlot.Breasts, 25.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"
	
func getPutOnScene():
	return "PutOnWithEquipEffectScene"

func onEquippedBy(_otherCharacter, _forced = false):
	var wearer = getWearer()
	var breasts = wearer.getBodypart(BodypartSlot.Breasts)
	originalBreastSize = breasts.size
	originalBreastVolume = breasts.getFluidProduction().getFluidAmount()
	
	if(breasts.size > BreastsSize.FOREVER_FLAT):
		if (breasts.size < BreastsSize.DD + 1):
			breasts.size += 1
	else:
		breasts.size += 2
	wearer.induceLactation()
	wearer.removeEffect(StatusEffect.SoreNipplesAfterMilking)

func onUnequipped():
	var wearer = getWearer()
	var breasts = wearer.getBodypart(BodypartSlot.Breasts)
	if(originalBreastSize != null && originalBreastVolume != null):
		breasts.getFluidProduction().drain()
		breasts.size = originalBreastSize
		breasts.getFluidProduction().fillPercent(originalBreastVolume)
	if(itemState != null):
		itemState.resetState()

func getPrice():
	return 50

func getSellPrice():
	return 10

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, "GoopsWearer"]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/GooeyCorset/RestraintGooeyCorset.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "tears the gooey lingerie off"
	else:
		return "tear the gooey lingerie off"

func getPuttingOnStringLong(withS):
	if(withS):
		return "sticks the gooey lingerie on"
	else:
		return "stick the gooey lingerie on"

func getForcedOnMessage(isPlayer = true):
	var message = ""
	if(isPlayer):
		message = getAStackNameCapitalize()+" was "+RNG.pick(["stuck to", "glued to", "forced on"])+" your torso. A sticky warmth oozes over you, and you begin lactating!"
	else:
		message = getAStackNameCapitalize()+" was "+RNG.pick(["stuck to", "glued to", "forced on"])+" {receiver.nameS} torso. A sticky warmth oozes over {receiver.him}, and {receiver.he} {receiver.verbS('begin')} lactating!"
	return message

func processTime(_secondsPassed: int):
	getWearer().coverBodyWithFluid("BlackGoo", RNG.randf_range(1.0, 5.0))

func getRiggedParts(_character):
	return {
		"corset": "res://Inventory/RiggedModels/PuppyCorset/PuppyCorset.tscn",
		"goo_boobs": "res://Modules/GooBondage/GooBoobs/GooBoobs.tscn",
		"crotchless_panties": "res://Modules/GooBondage/GooeyCorset/PantiesLower.tscn",
	}

func saveData():
	var data = {}
	
	data["amount"] = amount
	
	data["originalBreastSize"] = originalBreastSize
	data["originalBreastVolume"] = originalBreastVolume
	
	if(restraintData != null):
		data["restraintData"] = restraintData.saveData()
	if(itemState != null):
		data["itemState"] = itemState.saveData()
	if(fluids != null):
		data["fluids"] = fluids.saveData()
	return data

func loadData(_data):
	amount = SAVE.loadVar(_data, "amount", 1)
	
	originalBreastSize = SAVE.loadVar(_data, "originalBreastSize", null)
	originalBreastVolume = SAVE.loadVar(_data, "originalBreastVolume", null)
	
	if(restraintData != null):
		restraintData.loadData(SAVE.loadVar(_data, "restraintData", {}))
	if(itemState != null && _data.has("itemState")):
		itemState.loadData(SAVE.loadVar(_data, "itemState", {}))
	if(fluids != null):
		fluids.loadData(SAVE.loadVar(_data, "fluids", {}))
