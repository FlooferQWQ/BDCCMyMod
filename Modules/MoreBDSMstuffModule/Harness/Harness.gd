extends ItemBase

var type = {
	"Hr1": "res://Modules/MoreBDSMstuffModule/Harness/Harness.tscn",
	"Hr2": "res://Modules/MoreBDSMstuffModule/Harness/Harness_2.tscn",
	"Hr3": "res://Modules/MoreBDSMstuffModule/Harness/Harness_3.tscn",
	"Hr4":"res://Modules/MoreBDSMstuffModule/Harness/Harness_4.tscn",
	"Hr5":"res://Modules/MoreBDSMstuffModule/Harness/Harness_5.tscn",#?
	"Hr6":"res://Modules/MoreBDSMstuffModule/Harness/Harness_6.tscn",
	"Hr7":"res://Modules/MoreBDSMstuffModule/Harness/Harness_7.tscn"
	}


var ItemPart = {"Type": type}

var getTransfer = {}

var output = {}

func _init():
	id = "harness"

func getVisibleName():
	return "Harness HR1"
	
func getDescription():
	return "Not a pokeball (yet)"

func getClothingSlot():
	return InventorySlot.Torso

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [20]),
		buff(Buff.StatBuff, [Stat.Sexiness, 8]),
		]

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	getTransfer = {"Type":type.keys()[rand_range(0,type.size())]}
	restraintData = RestraintRopeHarness.new()
	restraintData.setLevel(5)

func getTakingOffStringLong(withS):
	if(withS):
		return "breaks locks and removes your harness"
	else:
		return "breaks locks and remove your harness"

func getPuttingOnStringLong(withS):
	if(withS):
		return "ties your body up with leather belts"
	else:
		return "tie your body up with leather belts"

func getRiggedParts(_character):
	output.merge({"harnessHR1": "res://Modules/MoreBDSMstuffModule/Harness/Harness.tscn"})
	if getTransfer.has("Type"):
		output.merge({"harnessHR1": type[getTransfer["Type"]]},true)
	return output #{
		#"harnessHR1": "res://Modules/MoreBDSMstuffModule/Harness/Harness_2.tscn",
	#}
#func getChains():
#	if getTransfer.has("Type"):
#		if getTransfer["Type"] == "Hr4":
#			return [["res://Modules/MoreBDSMstuffModule/Harness/Hr_chain.tscn", "1", "2"]]
	
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
	
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Harness/Hr.png"
