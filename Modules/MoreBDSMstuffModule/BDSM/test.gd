extends ItemBase

func _init():
	id = "dildo2"

func getVisibleName():
	return "vibro dildo"
	
func getDescription():
	return "Pink vibrator with vibro-motor inside"

func getClothingSlot():
	return InventorySlot.Hands

func getBuffs():
	return [
		buff(Buff.AmbientLustBuff, [30]),
		buff(Buff.SensitivityGainBuff, [30.0]),
		buff(Buff.MinLoosenessVaginaBuff, [3.0]),
		buff(Buff.BlocksVaginaLeakingBuff),
		]

func getPrice():
	return 20

func canSell():
	return true

func getTags():
	return [ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks]#[ItemTag.BDSMRestraint]

func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintVaginalplug.new()
	restraintData.setLevel(5)

func getTakingOffStringLong(withS):
	if(withS):
		return "slides the vaginal plug out from your pussy"
	else:
		return "slide the vaginal plug out from your pussy"

func getPuttingOnStringLong(withS):
	if(withS):
		return "inserts the vaginal plug into your pussy"
	else:
		return "insert the vaginal plug into your pussy"

func getRiggedParts(_character):
	GM.main.playAnimation(StageScene.PuppySolo, "walk")
	return {
		"dildo": "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/Dl1.tscn",
	}

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/Toys/Vag/Dildo/dl.png"
