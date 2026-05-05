extends ItemBase

#var length = {
#	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
#	"Long": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/SleevesLong.tscn",
#	"Rev. bunny": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/SleevesTooLong.tscn"
#	}
	
var mitten = {
	"Mitten": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/mittens/mitten/LatexMittens_mittens.tscn",
	"Paw": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/mittens/paw/LatexMittens_paws.tscn",
	"Big paw": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/mittens/paw_big/LatexMittens_paws_big.tscn",
	"Hoof": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/mittens/hoof/LatexMittens_hoofs.tscn"
	}
	
var legwear = {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Base": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/LatexMittens_legs_simple.tscn"
	}

var ItemPart = {"Mittens": mitten,"Legwear": legwear}

var getTransfer ={}

var currentLength

func _init():
	id = "Long latex mittens"

func getVisibleName():
	return "Long latex mittens"
	
func getDescription():
		return "Black latex mittens that go on your hands. Once they're on your hands basically become useless. "+str(getTransfer)

func getClothingSlot():
	return InventorySlot.Hands

func getBuffs():
	return [
		buff(Buff.BlockedHandsBuff),
		buff(Buff.StatBuff, [Stat.Sexiness, 5])
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
	var output = {}
	
	currentLength = "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/LatexMittens_arms.tscn"
	output.merge({"curLength": currentLength}, true)
	output.merge({
		"curMittens": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/mittens/mitten/LatexMittens_mittens.tscn",
		"curLegwear": "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/LatexMittens_legs_simple.tscn"
		})
	
	var curPart
	var cr = _character.get_name()
	
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart= _character.saveData()["bodyparts"]["legs"]["id"]
	else:
		curPart = GM.pc.saveData().bodyparts["legs"]["id"]
	
	if Latex_check()["legs"].has(curPart):
		output.merge({"suit legs mittens": Latex_check()["legs"][curPart]},true)
	else:
		output.merge({"suit legs mittens": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_digi.tscn"},true)
		
	#		"Sleeves":
#			if sleeve.has(current_style):
#				currentSleeves = sleeve[current_style]
#				sleeves_check = current_style
#				
#			output.merge({"curPaws": currentSleeves},true)
	
	if getTransfer.has("Mittens"):
		output.merge({"curMittens": mitten[getTransfer["Mittens"]]},true)
			
	if getTransfer.has("Legwear"):
		output.merge({"curLegwear": legwear[getTransfer["Legwear"]]},true)
		if getTransfer["Legwear"] == "None":
			output.merge({"suit legs mittens": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
			
	for id in ["LatexStraitjacket","leatherarmbinder","leatherarmmuffbondage"]:
		if getWearer().getInventory().hasItemIDEquipped(id):
			output.merge({"curMittens": legwear["None"], "curLength": legwear["None"]}, true)
			break
	
	return output
		
func getHidesAttachments(_character):
	if getTransfer.has("Mittens") == true:
		if getTransfer["Mittens"] == "Big paw":
			return {
				"wrist.R": true,
				"wrist.L": true,
			}	

func getUnriggedParts(_character):
	
	var outputUnRig = {}
	var cuffUseR = "res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelbR.tscn"
	var cuffUseL = "res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelbL.tscn"
	
	if getWearer().getInventory().hasItemIDEquipped("LatexStraitjacket"):
		return null
		
	if (getTransfer.has("Mittens")):
		#print(getTransfer)
		if(getTransfer["Mittens"] == "Big paw"):
			return null
		
	outputUnRig = {
		"Wrist.L_latex_mittens": [cuffUseL],
		"Wrist.R_latex_mittens": [cuffUseR],
		}
	return outputUnRig
	

#func shouldBeVisibleOnDoll(_character, _doll):
#	if(!_character.isBodypartCovered(BodypartSlot.Arms)):
#		return true
#	return false
	
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/LatexMittens/LatexMittensIco.png"
	
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
		"head":{
			
		}
	}
