extends ItemBase

func _init():
	id = "leatherarmmuffbondage"

func getVisibleName():
	return "Leather muff bondage"
	
func getDescription():
	return "Comfortable and durable leather restraints. Can be locked to bind arms together"

func getClothingSlot():
	return InventorySlot.Wrists

func getBuffs():
	return [
		buff(Buff.RestrainedArmsBuff),
		buff(Buff.BlockedHandsBuff),
		buff(Buff.ExposureBuff, [10])
		]

func getTakeOffScene():
	return "CuffTuggingScene"

func getPrice():
	return 20

func canSell():
	return true
	
func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintHandCuffs.new()
	restraintData.setLevel(7)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" were locked onto your arms, just below your elbows, with a belts connecting them"
	else:
		return getAStackNameCapitalize()+" were locked onto {receiver.nameS} arms, just below {receiver.his} elbows, with a belts connecting them"
		
func getRiggedParts(_character):
	return {"back_point":"res://Modules/MoreBDSMstuffModule/Models/LeatherArmMuffBondage/LeatherArmMuffBondage_point.tscn"}
	
func getUnriggedParts(_character):

	return {
		"back_moreBDSMstuff": ["res://Modules/MoreBDSMstuffModule/Models/LeatherArmMuffBondage/LeatherArmMuffBondage.tscn"],
	}
#func getChains():
	#if(isWornByWearer()):
	#	if(getWearer().getInventory().hasItemIDEquipped("inmateanklecuffs")) or (getWearer().getInventory().hasItemIDEquipped("leatheranklecuffs")):
	#		return [["short", "Armbinder", "ankle.R"],["short", "Armbinder", "ankle.L"]]
	
func getHidesParts(_character):
	return {BodypartSlot.Arms: true,}
	
#func coversBodyparts():
#	return {
#		BodypartSlot.Arms: true,
#		}

func getHidesAttachments(_character):
	return {
		"wrist.R": true,
		"wrist.L": true,
	}

#func updateDoll(doll: Doll3D):
#	doll.setArmsCuffed(true)
	
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/LeatherArmMuffBondage/ico.png"
