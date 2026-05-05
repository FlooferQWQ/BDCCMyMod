extends ItemBase

var originalSkin = null
var originalPrimaryColor = null
var originalSecondaryColor = null
var originalTertiaryColor = null
var properlySet = false

func _init():
	id = "goomask"

func getVisibleName():
	return "Goo Mask"

func getA():
	return ""

func getDescription():
	return "A constrictive mask that stretches over your whole head. It even forms itself to fill your mouth."

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		buff(Buff.BlindfoldBuff),
		buff(Buff.RingGagBuff),
		buff(Buff.NoRecoverThroatBuff),
		buff(Buff.AmbientLustBuff, [20]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPutOnScene():
	return "PutOnWithEquipEffectScene"

func onEquippedBy(_otherCharacter, _forced = false):
	var wearer = getWearer()
	var head = wearer.getBodypart(BodypartSlot.Head)
	originalSkin = head.pickedSkin
	originalPrimaryColor = head.pickedRColor
	originalSecondaryColor = head.pickedGColor
	originalTertiaryColor = head.pickedBColor
	head.applyAttribute("skin", "WoonaSkin")
	head.applyAttribute("skinPrimaryColor", Color(0.25, 0.25, 0.25))
	head.applyAttribute("skinSecondaryColor", Color(0.15, 0.15, 0.15))
	head.applyAttribute("skinTertiaryColor", Color(0.45, 0.45, 0.45))
	properlySet = true

func onUnequipped():
	var wearer = getWearer()
	var head = wearer.getBodypart(BodypartSlot.Head)
	if(properlySet):
		head.applyAttribute("skin", originalSkin)
		head.applyAttribute("skinPrimaryColor", originalPrimaryColor)
		head.applyAttribute("skinSecondaryColor", originalSecondaryColor)
		head.applyAttribute("skinTertiaryColor", originalTertiaryColor)
	if(itemState != null):
		itemState.resetState()

func updateDoll(doll: Doll3D):
	doll.setState("mouth", "ringgag")

func processTime(_secondsPassed: int):
	getWearer().getBodypart(BodypartSlot.Head).addFluidOrifice("BlackGoo", RNG.randf_range(5.0, 10.0))

func getPrice():
	return 20

func getSellPrice():
	return 4

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.CanBeForcedInStocks, ItemTag.SoldByTheAnnouncer, "GoopsWearer"]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = load("res://Modules/GooBondage/GooMask/RestraintGooMask.gd").new()
	restraintData.setLevel(calculateBestRestraintLevel())

func getTakingOffStringLong(withS):
	if(withS):
		return "pulls the goo mask off of your face"
	else:
		return "pull the goo mask off of your face"

func getPuttingOnStringLong(withS):
	if(withS):
		return "pulls the goo mask over your face"
	else:
		return "pull the goo mask over your face"

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was "+RNG.pick(["stuck over", "glued to", "pulled over", "locked onto"])+" your face. It blinds and gags you!"
	else:
		return getAStackNameCapitalize()+" was "+RNG.pick(["stuck over", "glued to", "pulled over", "locked onto"])+" {receiver.nameS} face. It blinds and gags {receiver.him}!"

func getInventoryImage():
	return "res://Images/Items/bdsm/ringgag.png"

func saveData():
	var data = {}
	
	data["amount"] = amount
	
	data["originalSkin"] = originalSkin
	data["originalPrimaryColor"] = originalPrimaryColor
	data["originalSecondaryColor"] = originalSecondaryColor
	data["originalTertiaryColor"] = originalTertiaryColor
	data["properlySet"] = properlySet
	
	if(restraintData != null):
		data["restraintData"] = restraintData.saveData()
	if(itemState != null):
		data["itemState"] = itemState.saveData()
	if(fluids != null):
		data["fluids"] = fluids.saveData()
	return data

func loadData(_data):
	amount = SAVE.loadVar(_data, "amount", 1)
	
	originalSkin = SAVE.loadVar(_data, "originalSkin", null)
	originalPrimaryColor = SAVE.loadVar(_data, "originalPrimaryColor", null)
	originalSecondaryColor = SAVE.loadVar(_data, "originalSecondaryColor", null)
	originalTertiaryColor = SAVE.loadVar(_data, "originalTertiaryColor", null)
	properlySet = SAVE.loadVar(_data, "properlySet", null)
	
	if(restraintData != null):
		restraintData.loadData(SAVE.loadVar(_data, "restraintData", {}))
	if(itemState != null && _data.has("itemState")):
		itemState.loadData(SAVE.loadVar(_data, "itemState", {}))
	if(fluids != null):
		fluids.loadData(SAVE.loadVar(_data, "fluids", {}))
