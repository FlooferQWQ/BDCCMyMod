extends "res://Scenes/SceneBase.gd"

var npcID = ""

func _init():
	sceneID = "PetForseBitchsuit"

func _initScene(_args = []):
	npcID = _args[0]

func resolveCustomCharacterName(_charID):
	if(_charID == "npc2"):
		return npcID

func _run():
	playAnimation(StageScene.PuppyFeetCrotch, {pc=npcID, npc="pc", npcBodyState={naked=true}})
	#{npc.HeShe}
	#{npc.his}
	#{npc.himself}
	#{npc.isAre}
	#{npc.cum}
	#{npc.penis}
	saynn("")
	#
	#{npc.HeShe} противно улыбнулся.
	#что тебе ещё надо?
	#Он достаёт _ и демострирует вам.
	#будь хорошим щенком и лежи смирно
	#Тебе очень подходит.
	#Давай немного поиграем. Будь хорошим пёсиком и попробуй меня найти.
	addButton("Continue", "", "endthescene")
	
func _react(_action: String, _args):
	if(_action == "endthescene"):
		runScene("PetWalkiesScene", true)
		endScene()
	return
		
	
