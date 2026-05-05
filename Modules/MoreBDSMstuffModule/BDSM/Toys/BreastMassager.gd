extends ItemBase

var turnON:String = "off"
var character
var timeOld

const ToyStatic = preload("res://Modules/MoreBDSMstuffModule/Pult/ToysStatic.gd")

func _init():
	id = "BreastMassager"
	set_meta("Toy",1)

func getVisibleName():
	return "Breast massager"
	
func getDescription():
	return "Рair nipple pads with movable rollers inside. Now "+turnON

func getClothingSlot():
	return InventorySlot.UnderwearTop
	
func getRequiredBodypart():
	return BodypartSlot.Breasts

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [30]),
		buff(Buff.SensitivityGainBuff, [25])
	]

func getTakingOffStringLong(withS):
	var box = GM.main.getCharacter("ToysBox")
	if turnON == "on":
		turnON = "off"
		box.removeToysStats(character.get_name(), toyStats())
		
	box.removeCharacterWithItem(character, id)
		
	if(withS):
		return "takes it off your nipples"
	else:
		return "take it off your nipples"

func getPuttingOnStringLong(withS):

	if(withS):
		return "sticks it on your nipples"
	else:
		return "stuck it on your nipples"

func getPrice():
	return 10

func canSell():
	return true
		
func getTags():
	return [ItemTag.SoldByTheAnnouncer]
	
func getUnriggedParts(_character):
	
	GM.main.getCharacter("ToysBox").getCharacterWithItem(_character, id)
	character = _character
		
	if turnON == "on":
		ToyStatic.getToySensitivity(_character, getRequiredBodypart(), timeOld, toyStats())
	
		#cum count
		#toys count in menu
		#dialogs

	var output:Array = []
	if _character.saveData().bodyparts["breasts"]["id"] == "malebreasts":
		output = ["res://Modules/MoreBDSMstuffModule/Models/Toys/Breast/BreastMassager/BreastMassager_m.tscn"]
	else:
		output = ["res://Modules/MoreBDSMstuffModule/Models/Toys/Breast/BreastMassager/BreastMassager.tscn"]
	
	#if turnON == "on":
		#output.append("res://Modules/MoreBDSMstuffModule/Models/Toys/Breast/BreastMassager/BreastMassager_anim.tscn")

	return {"nipples":output}
	
func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Breasts) || _doll.isForcedExposed(BodypartSlot.Breasts)):
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
	
	return "res://Modules/MoreBDSMstuffModule/Models/Toys/Breast/BreastMassager/toy1.png"

func saveData():
	var data = .saveData()
	
	data ["turnON"] = turnON
	return data
	
func loadData(data):
	.loadData(data)
	
	turnON = SAVE.loadVar(data, "turnON", "off")

func toyStats():
	return {
		"lust": 10,
		"sensitivity": 0.05,
		"arousal": 0.01,
	}
