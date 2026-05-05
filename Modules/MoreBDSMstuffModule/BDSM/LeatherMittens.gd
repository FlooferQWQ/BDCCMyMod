extends ItemBase

var sleeve= {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Long": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/SleevesLong.tscn",
	"Too Long": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/SleevesTooLong.tscn"
	}
	
var mitten= {
	"Mitten": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensA.tscn",
	"Paw": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensB.tscn",
	"Glove": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensC.tscn"
	}
	
var paw= {
	"None": false,
	"Base": true
	}
	
var legwear= {
		"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
		"Base": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/thighs.tscn"
	}

var ItemPart = {"Sleeves": sleeve,"Mittens": mitten, "Legwear":legwear, "Paws": paw} #
var ItemDescription = {"Glove": "One gentle twist, and your hands are free again. Your victims don't need to know that..."}

var getTransfer ={}

var currentPaws
var output = {}

var paw_swich = false
var mitten_check = ""

func _init():
	id = "leathermittens"

func getVisibleName():
	return "Leather bondage Mittens"
	
func getDescription():
	return "Black leather Mittens that go on your hands. Once they're on your hands basically become useless. "+str(getTransfer)

func getClothingSlot():
	return InventorySlot.Hands

func getBuffs():
	if (mitten_check == "Glove"):
		return []
	else:
		return [
			buff(Buff.BlockedHandsBuff),
			]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintMittens.new()
	restraintData.setLevel(5)

func getRiggedParts(_character):
	
	var curPart
	var cr = _character.get_name()
	
	output.merge({"curMittens":"res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensA.tscn"})
	output.merge({"curLegwear": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/thighs.tscn"})
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart = _character.saveData()["bodyparts"]["legs"]["id"]
	else:
		curPart = GM.pc.saveData().bodyparts["legs"]["id"]
	if Parts_check()["legs"].has(curPart):
		output.merge({"curLegwear_down": Parts_check()["legs"][curPart]},true)
	else:
		output.merge({"curLegwear_down": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/legs_hoofs.tscn"},true)
			
	if getTransfer.has("Sleeves"):
		output.merge({"curSleeves": sleeve[getTransfer["Sleeves"]]},true)
		if getTransfer["Sleeves"] == "Too Long":
			output.merge({"curSleeves_body": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/SleevesTooLong_body.tscn"},true)
		else:
			output.merge({"curSleeves_body":sleeve["None"]},true)

	if getTransfer.has("Mittens"):
		mitten_check = getTransfer["Mittens"]
		output.merge({"curMittens": mitten[getTransfer["Mittens"]]},true)
				
	if getTransfer.has("Paws"):
		paw_swich = paw[getTransfer["Paws"]]

	if(paw_swich == true):
		match mitten_check:
			
			"Mitten": currentPaws = "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensA_paw.tscn"
			"Paw": currentPaws = "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"
			"Glove": currentPaws = "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/MittensC_paw.tscn"
	else:
		currentPaws = "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"
	output.merge({"curPaws": currentPaws},true)
		
	if getTransfer.has("Legwear"):
		output.merge({"curLegwear": legwear[getTransfer["Legwear"]]},true)
		if getTransfer["Legwear"] == "None":
			output.merge({"curLegwear_down": legwear[getTransfer["Legwear"]]},true)
		else:
			if GM.main.saveDynamicCharactersData().has(cr):
				curPart = _character.saveData()["bodyparts"]["legs"]["id"]
			else:
				curPart = GM.pc.saveData().bodyparts["legs"]["id"]
			
			if Parts_check()["legs"].has(curPart):
				output.merge({"curLegwear_down": Parts_check()["legs"][curPart]},true)
			else:
				output.merge({"curLegwear_down": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/legs_hoofs.tscn"},true)

	
	for id in ["LatexStraitjacket","leatherarmbinder","leatherarmmuffbondage"]:
		if getWearer().getInventory().hasItemIDEquipped(id):
			output.merge({"curSleeves": sleeve["None"], "curMittens": sleeve["None"], "curPaws": sleeve["None"]}, true)
			break
			
	return output

	
func getUnriggedParts(_character):
	print(getTransfer["Sleeves"])
	if(getTransfer["Sleeves"] == "None") or (getTransfer.has("Sleeves") == false):
	#	return #{
		#	"wrist.L": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelbL.tscn"],
		#	"wrist.R": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelbR.tscn"],
		#}
	#elif getTransfer["Sleeves"] == "None":
		return {
			"wrist.L": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelcL.tscn"],
			"wrist.R": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelcR.tscn"],
		}
	else:
		return# {
	#		"wrist.L": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelcL.tscn"],
	#		"wrist.R": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelcR.tscn"],
	#	}
		
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/LeatherMitten.png"

func getPossibleActions():
		return [
			{
				"name": "Change style",
				"scene": "StyleChange",
				"description": "Let's make it fancy!",
			},
		]

func saveData():
	var data = .saveData()
	
	data ["config"] = getTransfer
	return data

func loadData(data):
	.loadData(data)
	
	getTransfer = SAVE.loadVar(data, "config", {})

func Parts_check():
	return {
		"legs":{
			#base game
			"digi": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/legs_hoofs.tscn",
			"hoofs": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/legs_hoofs.tscn",
			"plantilegs": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/Legs/legs_planty.tscn",
			}
		}
