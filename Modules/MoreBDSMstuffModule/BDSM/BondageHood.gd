extends ItemBase

func _init():
	id = "BondageHood"

func getVisibleName():
	return "Bondage hood"
	
func getDescription():
	return "Maybe too secure for a head bag."

func getClothingSlot():

	return InventorySlot.Eyes

func getPrice():
	return 20

func getBuffs():
	var buffs = [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.BlindfoldBuff),
		buff(Buff.MuzzleBuff),
#		buff(Buff.GagBuff),
		]
	return buffs

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBlindfold.new()
	restraintData.setLevel(5)

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your bondage hood"
	else:
		return "put on your bondage hood"
		
func getTakeOffScene():
	return "RestraintTakeOffNopeScene"
	
func getRiggedParts(_character):
	var output = {
		#"breath":"res://Modules/MoreBDSMstuffModule/Models/BondageHood/Breath.tscn",
		#"BondageHood": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood.tscn"
	}
	
	var curPart
	var cr = _character.get_name()
	
	#head part
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart = GM.main.saveDynamicCharactersData()[cr]["data"]["bodyparts"]["head"]["id"]
	else:
		curPart = GM.pc.saveData().bodyparts["head"]["id"]
		
	for i in range(0, LeatherHood_check()["head"].keys().size()):
		if LeatherHood_check()["head"].keys()[i].has(curPart):
			output.merge({"BondageHood": LeatherHood_check()["head"][LeatherHood_check()["head"].keys()[i]]},true)
			break
		else:
			output.merge({"BondageHood": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood.tscn"},true)
	
	#_character.getInventory().unequipSlot(InventorySlot.Mouth)
	#if LeatherHood_check()["head"].has(curPart):
	#	output.merge({"BondageHood": LeatherHood_check()["head"][curPart]},true)
	#else:
	#	output.merge({"BondageHood": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood.tscn"},true)

	#ears part
	var no_model = ["humanears","dragonears","dragonears2"]
	
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart = GM.main.saveDynamicCharactersData()[cr]["data"]["bodyparts"]["ears"]["id"]
		if no_model.has(curPart) == false:
			output.merge({"BondageHood_ears": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_ears.tscn"},true)
	else:
		curPart = GM.pc.saveData().bodyparts["ears"]["id"]
		if  no_model.has(curPart) == false:
			output.merge({"BondageHood_ears": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_ears.tscn"},true)
	return output
		
func getHidesParts(_character):
	var removed = {}
	
	removed = {
		BodypartSlot.Head: true,
		BodypartSlot.Ears: true,
		BodypartSlot.Hair: true,
	}

	return removed
	
func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your bondage hood"
	else:
		return "take off your bondage hood"

func alwaysVisible():
	return true

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/BondageHood/ico.png"

func LeatherHood_check():
	return {
		"head":{
			#base game
			["humanhead","humanoldhead"]:
				"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_humanhead.tscn",
			
			["horseheadbig"]:
				"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_horseheadbig.tscn",
				
			["cathead","felinehead","fennechead"]:
				"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_cathead.tscn",
			#"dragonhead":"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_dragonhead.tscn",
			#"felinehead":"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_felinehead.tscn",
			#"fennechead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_fennechead.tscn",
			#"foxhead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_foxhead.tscn",
			#"horsehead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_horsehead.tscn",
			#"horseheadbig": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_horseheadbig.tscn",
			#"humanhead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_humanhead.tscn",
			#"humanoldhead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_humanoldhead.tscn",
			#"wolfhead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_wolfhead.tscn",
			#"cathead": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_cathead.tscn",
			#mods?
			["eeveehead","eeveeheadWE",
			"espeonhead","espeonheadWE",
			"flareonhead","flareonheadwe",
			"glaceonhead","glaceonheadwe",
			"jolteonhead","jolteonheadwe",
			"leafeonhead","leafeonheadwe",
			"sylveonhead","sylveonhead3",
			"umbreonhead","umbreonheadwe",
			"vaporeonhead","vaporeonheadwe"]:
				"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_cathead.tscn",
			#"midnighthead":"res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_wolfhead.tscn.tscn"
		},
		"gags":{}
	}
