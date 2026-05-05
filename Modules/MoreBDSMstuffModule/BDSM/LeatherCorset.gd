extends ItemBase

var type = {
	"Closed": "res://Modules/MoreBDSMstuffModule/Models/LeatherCorset/LeatherCorset_closed.tscn",
	"Open belly":"res://Modules/MoreBDSMstuffModule/Models/LeatherCorset/LeatherCorset.tscn",
	"Open fully":"res://Modules/MoreBDSMstuffModule/Models/LeatherCorset/LeatherCorset_open.tscn",
	}

var ItemPart = {"Type": type}
var getTransfer = {}

func _init():
	id = "leathercorset"

func getVisibleName():
	return "Corset"
	
func getDescription():
	return "A tight corset that doesn't hide anything"

func getClothingSlot():
	return InventorySlot.UnderwearBottom

func getBuffs():
	return [
		buff(Buff.PregnantBellySizeModifierBuff, [-50.0])
		]

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]

func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your corset"
	else:
		return "take off your corset"

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your corset"
	else:
		return "put on your corset"

func getRiggedParts(_character):
	if getTransfer.has("Type"):
		return {
			"corset": type[getTransfer["Type"]],
		}
	else:
		return {
			"corset": "res://Modules/MoreBDSMstuffModule/Models/LeatherCorset/LeatherCorset.tscn",
		}
	
func getPossibleActions():
		return [
			{
				"name": "Change style",
				"scene": "StyleChange",
				"description": "Let's make it fancy!",
			},
		]
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/LeatherCorset/Leather_Corset_closet_ico.png"
	
func saveData():
	var data = .saveData()
	
	data ["config"] = getTransfer
	return data

func loadData(data):
	.loadData(data)
	
	getTransfer = SAVE.loadVar(data, "config", {})
