extends ItemBase

var gloves = {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Base": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LatexGloves.tscn",
	"Reverse bunny": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/Suit_RevBunny_up.tscn"
	}
var legwear = {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Base": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LatexGloves_legs_simple.tscn",
	"Fingerless":"res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LatexGloves_legs_simple.tscn",
	"Reverse bunny":"res://Modules/MoreBDSMstuffModule/Models/LatexGloves/Suit_RevBunny_down.tscn",
	}

var ItemPart = {"Legwear": legwear,"Gloves": gloves}
var getTransfer = {}
var output = {}

func _init():
	id = "Long latex gloves"

func getVisibleName():
	return "Latex gloves"
	
func getDescription():
	return "Black latex gloves complete with stockings. Shiny. "+str(getTransfer)

func getClothingSlot():
	return InventorySlot.Hands
			
func getBuffs():
	return [
		buff(Buff.StatBuff, [Stat.Sexiness, 5])
		]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your gloves"
	else:
		return "take off your gloves"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your gloves"
	else:
		return "put on your gloves"

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.SoldByTheAnnouncer]

func getRiggedParts(_character):
			
	output.merge({
		"LetexGloves": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LatexGloves.tscn",
		"curLegwear":"res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LatexGloves_legs_simple.tscn"
		},true)
	
	var curPart
	var cr = _character.get_name()
	
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart = _character.saveData()["bodyparts"]["legs"]["id"]
	else:
		curPart = GM.pc.saveData().bodyparts["legs"]["id"]

	if Latex_check()["legs"].has(curPart):
		output.merge({"suit legs gloves": Latex_check()["legs"][curPart]},true)
	else:
		output.merge({"suit legs gloves": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_digi.tscn"},true)

	if Latex_check()["legs"].has(curPart):
		output.merge({"suit legs gloves": Latex_check()["legs"][curPart]},true)
	else:
		output.merge({"suit legs gloves": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_digi.tscn"},true)

	if getTransfer.has("Legwear"):
		output.merge({"curLegwear": legwear[getTransfer["Legwear"]]},true)
		if getTransfer["Legwear"] == "None":
			output.merge({"suit legs gloves": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
		
		elif getTransfer["Legwear"] == "Fingerless":
			if Latex_check()["legs_fl"].has(curPart):
				output.merge({"suit legs gloves": Latex_check()["legs_fl"][curPart]},true)
			else:
				output.merge({"suit legs gloves": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/legs_fl/Suit_legs_digi.tscn"},true)

	if getTransfer.has("Gloves"):
		output.merge({"LetexGloves": gloves[getTransfer["Gloves"]]},true)
		if getTransfer["Gloves"] == "Reverse bunny":
			output.merge({"Gloves": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/Suit_RevBunny_up.tscn"},true)
		else:
			output.merge({"Gloves": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)

	for id in ["LatexStraitjacket","leatherarmbinder","leatherarmmuffbondage"]:
		if getWearer().getInventory().hasItemIDEquipped(id):
			output.merge({"LetexGloves": legwear["None"]}, true)
			break
			
	return output
		
func getPossibleActions():
		return [
			{
				"name": "Change style",
				"scene": "StyleChange",
				"description": "Let's make it fancy!",
			},
		]

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/LongGlovesIco.png" #redraw
	
#func shouldBeVisibleOnDoll(_character, _doll):
#	if(!_character.isBodypartCovered(BodypartSlot.Arms)):
#		return true
#	return false
	
func saveData():
	var data = .saveData()
	
	data ["config"] = getTransfer
	return data
	
func loadData(data):
	.loadData(data)
	
	getTransfer = SAVE.loadVar(data, "config", {})
	
func Latex_check():
	return {
		"legs":{
			#base game
			"digi": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_digi.tscn",
			"hoofs": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_hoofs.tscn",
			"plantilegs": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_planty.tscn",
		
			#mods
			"lopunnylegs": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_lopunny.tscn",
			"rabbitlegs": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_rabbit.tscn",
			},
			
		"legs_fl":{
			#base game
			"digi": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/legs_fl/Suit_legs_digi.tscn",
			"plantilegs": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/legs_fl/Suit_legs_planty.tscn",
			"hoofs": "res://Modules/MoreBDSMstuffModule/Models/LatexGloves/legs_fl/Suit_legs_hoofs.tscn"
			},
		"head":{
			
		}
	}
