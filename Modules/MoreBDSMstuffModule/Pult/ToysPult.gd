extends ItemBase
	
func _init():
	id = "ToysPult"

func getVisibleName():
	return "Toy pult"

func getDescription():
	return "Allows you to control toys remotely."

func getPrice():
	return 10

func getTags():
	return [ItemTag.SoldByTheAnnouncer]


func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Pult/Pult_ico.png"

func getPossibleActions():
		return [
			{
				"name": "Toys List",
				"scene": "ToysList",
				"description": "One pult to rule them all.",
			},
		]
