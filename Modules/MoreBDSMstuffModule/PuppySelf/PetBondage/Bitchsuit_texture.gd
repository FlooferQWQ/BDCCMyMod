extends ItemBase

func _init():
	id = "bitchsuit_not_for_use"
	#set_meta("Toy",1)

func getVisibleName():
	return "Bitchsuit"
	
func getDescription():
	return "Set of belts and armblinders, to feel your self like a pet!"

func getClothingSlot():
	return InventorySlot.Static1

#func getBuffs():
#	return [
#		buff(Buff.AmbientLustBuff, [20]),
#		]

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ]


func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintStraitjacket.new()
	restraintData.setLevel(2)

#func getTakingOffStringLong(withS):
	#GM.main.setModuleFlag("BDSMstuff","PuppyWalk",false)
#	if(withS):
#		return "pulls the butt plug out from your butt"
#	else:
#		return "pull the butt plug out from your butt"

func getTakingOffStringLong(withS):
	GM.main.setModuleFlag("BDSMstuff","PetWalk", false)
	if(withS):
		return "takes it off your nipples"
	else:
		return "take it off your nipples"

func getPuttingOnStringLong(withS):

	if(withS):
		return "sticks it on your nipples"
	else:
		return "stuck it on your nipples"
	
#	if(withS):
#		return "inserts the butt plug into your butt"
#	else:
#		return "insert the butt plug into your butt"
func getRiggedParts(_character):
	return {"PetStaff":"res://Inventory/RiggedModels/PuppyRestraints/PuppyRestraints.tscn"}


func getInventoryImage():
	return "res://Inventory/RiggedModels/PuppyRestraints/armpuppybinder.png"
