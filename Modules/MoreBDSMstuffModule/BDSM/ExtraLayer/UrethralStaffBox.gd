extends ItemBase

func _init():
	id = "urethralstaffbox"

func getVisibleName():
	return "Urethral staff box"
	
func getDescription():
	return "Сontains a variety of accessories for your penis."

func getRequiredBodypart():
	return BodypartSlot.Penis

func getBuffs():
	return [
		buff(Buff.ChastityPenisBuff),
		buff(Buff.SensitivityGainBuff, [25.0]),
		]

func getTakeOffScene():
	return "RestraintTakeOffNopeScene"

func getPrice():
	return 20

#func canSell():
#	return true

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.ChastityCage]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintChastityCage.new()
	restraintData.setLevel(5)

func getForcedOnMessage(isPlayer = true):
	if(isPlayer):
		return getAStackNameCapitalize()+" was locked onto your penis, making it useless!"
	else:
		return getAStackNameCapitalize()+" was locked onto {receiver.nameS} penis, making it useless!"

func getRiggedParts(_character):
	return {
		"chastity_cage": "res://Modules/MoreBDSMstuffModule/Models/Toys/Penis/Cage_3/Cage_C3.tscn",
	}
	
func getUnriggedParts(_character):
	return {
		"UrBeads": ["res://Modules/MoreBDSMstuffModule/Models/Toys/Penis/Urethral_smf/Simple_enter.tscn"]
	}

func getHidesParts(_character):
	return {
		BodypartSlot.Penis: true,
	}

func shouldBeVisibleOnDoll(_character, _doll):
	if(!_character.isBodypartCovered(BodypartSlot.Penis) || _doll.isForcedExposed(BodypartSlot.Penis)):
		return true
	return false

#func isImportant():
#	return true

func getInventoryImage():
	return "res://Images/Items/bdsm/flatcage.png"
