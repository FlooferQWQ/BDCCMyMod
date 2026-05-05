extends ItemBase

var turnON:String = "off"
var character
var timeOld

const ToyStatic = preload("res://Modules/MoreBDSMstuffModule/Pult/ToysStatic.gd")

func _init():
	id = "PlugL2"
	set_meta("Toy",1)

func getVisibleName():
	return "Plug L2"
	
func getDescription():
	return "A butt plug out of black silicon. Now "+turnON

func getClothingSlot():
	return InventorySlot.Anal

func getRequiredBodypart():
	return BodypartSlot.Anus

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [20]),
		buff(Buff.SensitivityGainBuff, [10.0]),
		buff(Buff.MinLoosenessAnusBuff, [2.0]),
		buff(Buff.BlocksAnusLeakingBuff),
		#buff(Buff.InflatedBellyBuff, [50])
		]

func getPrice():
	return 10

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]#ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards
	
func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintButtplug.new()
	restraintData.setLevel(2)

func getTakingOffStringLong(withS):
	var box = GM.main.getCharacter("ToysBox")
	if turnON == "on":
		turnON = "off"
		box.removeToysStats(character.get_name(), toyStats())
	
	box.removeCharacterWithItem(character, id)
	
	if(withS):
		return "pulls the butt plug out from your butt"
	else:
		return "pull the butt plug out from your butt"

func getPuttingOnStringLong(withS):
	if(withS):
		return "inserts the butt plug into your butt"
	else:
		return "insert the butt plug into your butt"

func getRiggedParts(_character):
	GM.main.getCharacter("ToysBox").getCharacterWithItem(_character, id)
	character = _character
	
	if turnON == "on":
		ToyStatic.getToySensitivity(_character, getRequiredBodypart(), timeOld, toyStats())
	
	return {
		"points": "res://Modules/MoreBDSMstuffModule/Models/Toys/BodyEx.tscn",
	}

func getUnriggedParts(_character):
	#print(putOn)
	if turnON == "on":
		return {
			"Anusus":["res://Modules/MoreBDSMstuffModule/Models/Toys/Anal/Plug_2/Plug_L2_anim.tscn"]
		}
		
	else:
		return {
			"Anusus":["res://Modules/MoreBDSMstuffModule/Models/Toys/Anal/Plug_2/Plug_L2.tscn"]
		}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Anus) || _doll.isForcedExposed(BodypartSlot.Anus)):
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
	return "res://Modules/MoreBDSMstuffModule/Models/Toys/Anal/Plug_2/L2.png"

func saveData():
	var data = .saveData()
	
	data ["Turn"] = turnON
	return data
	
func loadData(data):
	.loadData(data)
	
	turnON = SAVE.loadVar(data, "Turn", "off")

func toyStats():
	return {
		"lust": 10,
		"sensitivity": 0.05,
		"arousal": 0.01,
	}
