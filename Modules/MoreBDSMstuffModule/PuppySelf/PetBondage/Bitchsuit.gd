extends ItemBase

func _init():
	id = "bitchsuit"

func getVisibleName():
	return "Bitchsuit"
	
func getDescription():
	return "Set of belts and armblinders, to feel your self like a pet!"

#func getClothingSlot():
#	return #InventorySlot.Unique

#func getBuffs():
#	return [
#		buff(Buff.AmbientLustBuff, [20]),
#		]

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]


func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintStocks.new()
	restraintData.setLevel(2)

#func getTakingOffStringLong(withS):
	#GM.main.setModuleFlag("BDSMstuff","PuppyWalk",false)
#	if(withS):
#		return "pulls the butt plug out from your butt"
#	else:
#		return "pull the butt plug out from your butt"

#	if(withS):
#		return "inserts the butt plug into your butt"
#	else:
#		return "insert the butt plug into your butt"
#func getRiggedParts(_character):
#	return {"PetStaff":"res://Inventory/RiggedModels/PuppyRestraints/PuppyRestraints.tscn"}
	
func getPossibleActions():
	return [
			{
				"name": "Put on",
				"scene": "PetWalkiesScene",
				"description": "Last warning, you will not be able to take it off on your own!",
			},
		]
		

func getInventoryImage():
	return "res://Inventory/RiggedModels/PuppyRestraints/armpuppybinder.png"
