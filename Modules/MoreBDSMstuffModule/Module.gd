extends Module

func getFlags():
	return {
			"Ring_pc": flag(FlagType.Bool),
			"Ring_npc": flag(FlagType.Anything),
			
			"PetWalk": flag(FlagType.Bool),
			"PetWalkForsed": flag(FlagType.Bool),
			#"Pup_init_possible": flag(FlagType.Bool),
			
			"PetWalkEventCooldown": flag(FlagType.Number)
			#"test": flag(FlagType.Anything)
		}

func _init():
	
	id = "BDSMstuff"
	author = "DrDurka"

	items = [
	#Toys
	"res://Modules/MoreBDSMstuffModule/Pult/ToysPult.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/Toys/Dildo.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/Toys//Plug_1.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/Toys//Plug_2.gd",
	#"res://Modules/MoreBDSMstuffModule/BDSM/Toys/Plug_3.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/Toys//BreastMassager.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/Ring.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/ChastityCage_C1.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/ChastityCage_C2.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/ChastityCage_C3.gd",
	
	#Leather
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherWristCuffs.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherAnkleCuffs.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/BondageHood.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherBlindfold.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherMuzzle.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherMittens.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherArmbinder.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherArmMuffBondage.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LeatherCorset.gd",
	"res://Modules/MoreBDSMstuffModule/Harness/Harness.gd",
	
	
	#Latex
	"res://Modules/MoreBDSMstuffModule/BDSM/Suit.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LatexMittens.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LatexGloves.gd",
	#"res://Modules/MoreBDSMstuffModule/BDSM/LatexMuzzle.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/LatexMuzzleRing.gd",
	
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/Bitchsuit.gd",
	
	]
	
	characters = [
	"res://Modules/MoreBDSMstuffModule/Pult/ToysBox.gd",]
		
	scenes = [
	"res://Modules/MoreBDSMstuffModule/Pult/ToysList.gd",
	"res://Modules/MoreBDSMstuffModule/Pult/SimpleOffOn.gd",
	"res://Modules/MoreBDSMstuffModule/Z_ItemChangeMenu/StyleChange.gd",
		
	#puppy
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetScene.gd",
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetWalkiesScene.gd",
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetLookingAroundScene2.gd",
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetSex.gd",
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PuppyEvents/PetForseBitchsuit.gd",
		
	]
	
	events = [
	"res://Modules/MoreBDSMstuffModule/BDSM/ToysProsses/RingCheck.gd",
	"res://Modules/MoreBDSMstuffModule/BDSM/ToysProsses/ToysCheck.gd",
		
	#puppy
	#"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetWalkiesEvent.gd",
	#"res://Modules/MoreBDSMstuffModule/PuppySelf/PetBondage/PetDefeat.gd"
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PuppyEvents/PetLose.gd",
	"res://Modules/MoreBDSMstuffModule/PuppySelf/PuppyEvents/PetForseRandomRestraints.gd",
	]
	
	stageScenes = [
	#"res://Modules/MoreBDSMstuffModule/stage/Beg_1.tscn"
	#"res://Modules/MoreBDSMstuffModule/PuppySelf/PuppySolo.tscn"
	#"res://Modules/MoreBDSMstuffModule/stage/SexFeetPlay_1.tscn"
	]
	#buffs = [
	#	"res://Modules/IssixModule/Buffs/NaturallyObedient.gd",
	#]
	
	gameExtenders = [
	#"res://Modules/MoreBDSMstuffModule/PuppySelf/PuppyEvents/Extends.gd",
	]
