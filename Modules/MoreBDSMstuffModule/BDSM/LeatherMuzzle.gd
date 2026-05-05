extends ItemBase

func _init():
	id = "leathermuzzle"

func getVisibleName():
	return "Leather muzzle gag"
	
func getDescription():
	return "Durable leather muzzle for your pet."

func getClothingSlot():
	return InventorySlot.Mouth

func getBuffs():
	return [
		#buff(Buff.RingGagBuff),
		buff(Buff.MuzzleBuff),
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
	restraintData = RestraintMuzzle.new()
	restraintData.setLevel(5)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was forced over your eyes. You are blind!"
	else:
		return getAStackNameCapitalize()+" was forced over {receiver.nameS} eyes! {receiver.He} {receiver.is} blind!"

func getRiggedParts(_character):
	return {
		"breath":"res://Modules/MoreBDSMstuffModule/Models/BondageHood/Breath.tscn"
	}

func getUnriggedParts(_character):
	var output = {
		"blindfold": ["res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle_bigger.tscn"],
	}
	
	var curPart
	var cr = _character.get_name()
		
	if GM.main.saveDynamicCharactersData().has(cr):
		curPart = GM.main.saveDynamicCharactersData()[cr]["data"]["bodyparts"]["head"]["id"]
	else:
		curPart = GM.pc.saveData().bodyparts["head"]["id"]
		
	for i in range(0, LeatherHood_check()["head"].keys().size()):
		if LeatherHood_check()["head"].keys()[i].has(curPart):
			output.merge({"blindfold": [LeatherHood_check()["head"][LeatherHood_check()["head"].keys()[i]]]},true)
			break
		#if LeatherHood_check()["head"].has(curPart):
			#output.merge({"blindfold": [LeatherHood_check()["head"][curPart]]},true)
		else:
			output.merge({"blindfold": ["res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle_bigger.tscn"]},true)

	return output

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Muzzle/muzzle_ico.png"


func LeatherHood_check():
	return {
		"head":{
			#base game
			["dragonhead","horseheadbig"]
			:"res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle_much_bigger.tscn",
			
			["felinehead","fennechead","humanhead","humanoldhead","cathead"]
			#:"res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle.tscn",
			:"res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle.tscn",
			#"foxhead":
			#"horsehead":
			#"wolfhead":
			#mods?
			#"midnighthead":
			["eeveehead","eeveeheadWE",
			"espeonhead","espeonheadWE",
			"flareonhead","flareonheadwe",
			"glaceonhead","glaceonheadwe",
			"jolteonhead","jolteonheadwe",
			"leafeonhead","leafeonheadwe",
			"sylveonhead","sylveonhead3",
			"umbreonhead","umbreonheadwe",
			"vaporeonhead","vaporeonheadwe"]
			:"res://Modules/MoreBDSMstuffModule/Models/Muzzle/Muzzle.tscn",
		},
	}
