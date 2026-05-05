extends ItemBase
	
var hood = {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	#"Mouth": "res://Modules/MoreBDSMstuffModule/Models/Suit/head_mouth/Suit_head_mouth.tscn",
	"Eyes": "res://Modules/MoreBDSMstuffModule/Models/Suit/head_eyes/Suit_head_eyes.tscn",
	"Eyes with hairs": "res://Modules/MoreBDSMstuffModule/Models/Suit/head_eyes/Suit_head_eyes.tscn"
	#"Full head": "res://Modules/MoreBDSMstuffModule/Models/Suit/head_full/Suit_head.tscn"
	}
var tail = {
	"None": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Base": "res://Modules/MoreBDSMstuffModule/Models/Suit/tails/MidTail_latex.tscn"
	}
var fake_ears = {
	"Reset":"",
	"None":"res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
	"Base":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears.tscn",
	"Rabbit 1":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_rabbit1.tscn",
	"Rabbit 2":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_rabbit.tscn",
	"Horse":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_horse.tscn"}

var ItemPart = {"Hood": hood,"Tail":tail,"Ears":fake_ears}

var getTransfer = {}
var output = {}
	
func _init():
	id = "LatexSuitNew"

func getVisibleName():
	return "Latex suit"

func getDescription():
	return "A very shiny catsuit. "+str(getTransfer)

func getClothingSlot():
	return InventorySlot.Ring

func getPrice():
	return 20

func getBuffs():
	var buffs = [
		buff(Buff.AmbientLustBuff, [15]),
		buff(Buff.StatBuff, [Stat.Sexiness, 10])
		]
	if getTransfer.has("Hood"):
		if ["Eyes", "Full head"].has(getTransfer["Hood"]):
			buffs.append(buff(Buff.BlindfoldBuff))
			
	return buffs

func getTags():
	return [ItemTag.SoldByTheAnnouncer]

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your latex suit"
	else:
		return "put on your latex suit"
		
func getRiggedParts(_character):
	output.merge({
		"suit arms": "res://Modules/MoreBDSMstuffModule/Models/Suit/Suit_arms.tscn",
		"suit body": "res://Modules/MoreBDSMstuffModule/Models/Suit/Suit_simple.tscn",
		#"suit legs": "res://Modules/MoreBDSMstuffModule/Models/Suit/Suit_legs.tscn",
		"suit ears": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn",
		#"suit tail": "res://Modules/MoreBDSMstuffModule/Models/Suit/tails/CatTail_latex.tscn"
		},true)
		
	var currentPart
	var currentCharacter = _character.get_name()
	if currentCharacter != "Player":
		currentCharacter = _character.id
	
	#legs part
	
	if GM.main.saveDynamicCharactersData().has(currentCharacter):
		currentPart = _character.saveData()["bodyparts"]["legs"]["id"]
	else:
		currentPart = GM.pc.saveData().bodyparts["legs"]["id"]
		
	if Latex_check()["legs"].has(currentPart):
		output.merge({"suit legs": Latex_check()["legs"][currentPart]},true)
	else:
		output.merge({"suit legs": "res://Modules/MoreBDSMstuffModule/Models/Suit/smash_if_broken/legs/Suit_legs_digi.tscn"},true)
	
	#print(GM.pc.saveData().bodyparts.head["data"])#["pickedBColor"])
	#_character.getBodypart(BodypartSlot.Head).pickedBColor = 7
	#_character.getBodypart(BodypartSlot.Head).pickedGColor = 51
	#_character.getBodypart(BodypartSlot.Head).pickedRColor = 215
	#print(GM.pc.saveData().bodyparts.head["data"]["pickedBColor"])
	
	#head part
	var no_model = ["humanears","dragonears","dragonears2"]
	if getTransfer.has("Hood"):
		output.merge({"hood": hood[getTransfer["Hood"]]},true)
		var ears
		if GM.main.saveDynamicCharactersData().has(currentCharacter):
			ears = _character.saveData()["bodyparts"]["ears"]["id"]
		else:
			ears = GM.pc.saveData().bodyparts["ears"]["id"]
			
		if !no_model.has(ears):
			output.merge({"suit ears": "res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears.tscn"},true)
			if Latex_check()["ears"].has(ears):
				output.merge({"suit ears": Latex_check()["ears"][ears]},true)
		#else:
		#	ItemPart.merge({"Fake ears":fake_ears})
		#	if getTransfer.has("Fake ears"):
		#		output.merge({"suit ears": fake_ears[getTransfer["Fake ears"]]},true)
				
		if getTransfer["Hood"] == "None":
			output.merge({"suit ears": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
			
	if getTransfer.has("Ears"):
		if getTransfer["Ears"] == "Reset":
			getTransfer.erase("Ears")
		else:
			output.merge({"suit ears": fake_ears[getTransfer["Ears"]]},true)
		
	if getTransfer.has("Hood"):
		if ["Eyes with hairs", "Full head"].has(getTransfer["Hood"]):
			output.merge({"suit ears": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
	
	#tail
	if getTransfer.has("Tail"):
		if getTransfer["Tail"] == "Base":
			if GM.main.saveDynamicCharactersData().has(currentCharacter):
				currentPart = GM.main.saveDynamicCharactersData()[currentCharacter]["data"]["bodyparts"]["tail"]["id"]
			else:
				if GM.pc.saveData().bodyparts["tail"] != null:
					currentPart = GM.pc.saveData().bodyparts["tail"]["id"]
				else:
					output.merge({"suit tail": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
			
			for i in range(0, Latex_check()["tail"].keys().size()):
				if Latex_check()["tail"].keys()[i].has(currentPart):
					output.merge({"suit tail": Latex_check()["tail"][Latex_check()["tail"].keys()[i]]},true)
					break
		
				else:
					output.merge({"suit tail": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
		else:
			output.merge({"suit tail": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"},true)
	
	#exclusion
	for id in ["LatexStraitjacket","leatherarmbinder","leatherarmmuffbondage"]:
		if getWearer().getInventory().hasItemIDEquipped(id):
			output.merge({"suit arms": "res://Modules/MoreBDSMstuffModule/Models/LeatherMittens/NONE.tscn"}, true)
			break

	return output

func getHidesParts(_character):
	var removed = {}
	
	removed = {
		BodypartSlot.Arms: true,
		BodypartSlot.Body: true,
		BodypartSlot.Breasts: true,
		BodypartSlot.Legs: true,
		#BodypartSlot.Tail: true
	}
	if getTransfer.has("Tail"):
		if getTransfer["Tail"] != "None":
			removed.merge({BodypartSlot.Tail: true})
		
	if getTransfer.has("Hood"):
		if ["Eyes with hairs"].has(getTransfer["Hood"]):
			if ["humanears","dragonears","dragonears2"].has(_character.saveData()["bodyparts"]["ears"]["id"]):
				removed.merge({BodypartSlot.Ears: true})
			
		elif ["Eyes", "Full head"].has(getTransfer["Hood"]):
			removed.merge({BodypartSlot.Hair: true})
			removed.merge({BodypartSlot.Ears: true})
			
	return removed
	
func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your latex suit"
	else:
		return "take off your latex suit"

func alwaysVisible():
	return true

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Suit/SuitIco.png"

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
		},
		"ears":{
			"rabbitears1":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_rabbit1.tscn",
			"rabbitears2":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_rabbit.tscn",
			"rabbitears3":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_rabbit.tscn",
			"horseears":"res://Modules/MoreBDSMstuffModule/Models/Suit/ears/Suit_ears_horse.tscn"
		},
		"tail":{
			["horsetail","caninetail","fennectail","foxtail"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/MidTail_latex.tscn",
			["dragontail","demontail"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/LongTail_latex.tscn",
			["felinetail","fluffyfelinetail"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/CatTail_latex.tscn",
			["huskytail"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/HuskyTail_latex.tscn",
			["shorttail"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/ShortTail_latex.tscn",
			#mods
			["dusktail","middaytail","midnighttailbig",
			"synthtailspiked","synthtailspiked_skin",]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/MidTail_latex.tscn",
			
			["synthtail","synthtail_skin","synthtailarmored","synthtailarmored_skin"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/LongTail_alt_latex.tscn",
			
			["rabbittail1","rabbittail1custom","rabbittail2","rabbittail2custom"]
			:"res://Modules/MoreBDSMstuffModule/Models/Suit/tails/RabbitTail1.tscn",
		}
	}
