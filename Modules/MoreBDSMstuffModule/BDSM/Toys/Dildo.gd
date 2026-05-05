extends ItemBase

var turnON:String = "off"
var character
var timeOld

const ToyStatic = preload("res://Modules/MoreBDSMstuffModule/Pult/ToysStatic.gd")

func _init():
	id = "dildo"
	set_meta("Toy",1)

func getVisibleName():
	return "Vibro dildo"
	
func getDescription():
	return "Pink vibrator with vibro-motor inside. Now "+turnON

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
	return 10

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
	#_subInfo.hasTag(SexActivityTag.VaginaPenetrated)
	var box = GM.main.getCharacter("ToysBox")
	if turnON == "on":
		turnON = "off"
		box.removeToysStats(character.get_name(), toyStats())
		
	box.removeCharacterWithItem(character, id)
		
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
	
	if turnON == "on":
		ToyStatic.getToySensitivity(_character, getRequiredBodypart(), timeOld, toyStats())
		return {
			"dildo": "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/Dl1_anim.tscn",
		}
	return {
		"dildo": "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/Dl1.tscn",
	}
	
func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Vagina) || _doll.isForcedExposed(BodypartSlot.Vagina)):
		return true
	return false

func getPossibleActions():
	var desc = turnON
	var output = [
			{
				"name": "Switch it",
				"scene": "ToySwitch",
				"description": "Turn it "+str(desc),
			},
		]
		
	if turnON == "off":
		desc = "on"
		output[0].merge({"description": "Turn it "+str(desc)}, true)
	
	else:
		desc = "off"
		output[0].merge({"description": "Turn it "+str(desc)}, true)
		
	return output

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
		"sensitivity": 0.05,
		"arousal": 0.03,
	}
