extends ItemBase

var originalBreastSize
var originalBreastVolume

func _init():
	id = "gooboobs"
	clothesColor = Color(0.19, 0.19, 0.19)

func getVisibleName():
	return "Goo Boobs"

func getA():
	return ""

func getDescription():
	return "Twin mounds of goo made to expand the wearer's chest. (Un)fortunately, they're very sticky and tough to remove."

func getClothingSlot():
	return InventorySlot.Torso

func getRequiredBodypart():
	return BodypartSlot.Breasts

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [20]),
		buff(Buff.BreastsLactatingSizeLimitBuff, [1]),
		buff(Buff.BreastsMilkProductionBuff, [100]),
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
	return 25

func getSellPrice():
	return 5

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/GooBoobs/RestraintGooBoobs.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "pulls the goo boobs off of your chest"
	else:
		return "pull the goo boobs off of your chest"

func getPuttingOnStringLong(withS):
	if(withS):
		return "sticks the goo boobs to your chest"
	else:
		return "stick the goo boobs to your chest"

func getRiggedParts(_character):
	return {
		"goo_boobs": "res://Modules/GooBondage/GooBoobs/GooBoobs.tscn",
	}

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" were "+RNG.pick(["stuck onto", "glued to", "glazed over", "attached to"])+" your chest. They start lactating!"
	else:
		return getAStackNameCapitalize()+" were "+RNG.pick(["stuck onto", "glued to", "glazed over", "attached to"])+" {receiver.nameS} chest. They start lactating!"

func getInventoryImage():
	return "res://Images/Items/underwear/lacebra.png"

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
