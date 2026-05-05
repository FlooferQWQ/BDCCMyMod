extends ItemBase

func _init():
	id = "leatheranklecuffs"

func getVisibleName():
	return "Leather ankle cuffs"
	
func getDescription():
	return "Comfortable and durable leather restraints. Can be locked to bind legs together"

func getClothingSlot():
	return InventorySlot.Ankles

func getBuffs():
	return [
		buff(Buff.RestrainedLegsBuff),
		]

func getPrice():
	return 20

func canSell():
	return true

func getTakeOffScene():
	return "CuffTuggingScene"

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintLegCuffs.new()
	restraintData.setLevel(5)

func getUnriggedParts(_character):
	return {
		"ankle.L": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelL.tscn"],
		"ankle.R": ["res://Modules/MoreBDSMstuffModule/Models/Cuff/CuffModelR.tscn"],
	}

func updateDoll(doll: Doll3D):
	doll.setLegsCuffed(true)

func getChains():
	return [["short", "ankle.L", "ankle.R"]]

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Cuff/cuffIco.png"
