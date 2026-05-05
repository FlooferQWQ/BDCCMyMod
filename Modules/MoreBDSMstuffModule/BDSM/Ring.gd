extends ItemBase

func _init():
	id = "Cockring"
	#GM.main.setFlag("Ring_pc", false)

func getVisibleName():
	return "Cock ring"
	
func getDescription():
	return "Not allow you to cum."

func getClothingSlot():
#	InventorySlot.getAll().append("hi")
#	if GM.pc.getInventory().hasItemIDEquipped("LatexSuitNew"):
	#return InventorySlot.hi
#	else:
		return InventorySlot.Penis

func getRequiredBodypart():
	return BodypartSlot.Penis

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [20]),
		buff(Buff.SensitivityGainBuff, [20])
		]

func getPrice():
	return 5

func canSell():
	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer]#ItemTag.CanBeForcedInStocks, ItemTag.CanBeForcedByGuards

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintChastityCage.new()
	restraintData.setLevel(3)

func getRiggedParts(_character):
#	GM.main.setFlag("Ring_npc", false)
#	GM.main.setFlag("Ring_pc", false)
	var cr = _character.get_name()
	if _character != GM.pc:
		GM.main.setModuleFlag("BDSMstuff", "Ring_npc", cr)
	else:
		GM.main.setModuleFlag("BDSMstuff","Ring_pc", true)

	#if GM.main.saveDynamicCharactersData().has(cr):
	#print(GM.main.getFlag("Ring_pc"))
			
	if _character.getArousal() <= 0.1:
		_character.setArousal(0.1)

	return {
		"chastity_cage": "res://Modules/MoreBDSMstuffModule/Models/Toys/Penis/Ring_1/Ring.tscn",
		#"tec": "res://Modules/MoreBDSMstuffModule/Models/Toys/BodyEx.tscn",
	}
#func getHidesParts(_character):
#	return {BodypartSlot.Penis: true}
	
func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false
	
func updateDoll(doll: Doll3D):
	doll.setState("cock", "hard")

	
func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Toys/Penis/Ring_1/ring_ico.png"
