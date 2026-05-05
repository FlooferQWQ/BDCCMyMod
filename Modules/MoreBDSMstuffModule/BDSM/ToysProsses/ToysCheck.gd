extends EventBase

var panties = null

func _init():
	id = "Toys_check"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)
	es.addTrigger(self, Trigger.Waiting)
	es.addTrigger(self, Trigger.WakeUpInCell)
	es.addTrigger(self, Trigger.TakingAShower)
	
	es.addTrigger(self, Trigger.SceneAndStateHook, ["GenericSexScene", ""])
	#es.addTrigger(self, Trigger.SceneAndStateHook, ["SlaveryWalkiesScene", ""])
	
	
func run(_triggerID, _args):
	
	var getStatsChange = GM.main.getCharacter("ToysBox").toysStats
	var character = GM.main.getCurrentScene().saveData()["currentCharactersVariants"].keys()

	if getStatsChange.has(character):
		StatsChange(GM.main.getCharacter(character), getStatsChange)
		
	if getStatsChange.has("Player"):
		StatsChange(GM.pc, getStatsChange)
		#if GM.pc.getArousal() >= 0.9:
		#"Ring_pc"
		if GM.main.getCurrentScene().get_name() != "GenericSexScene": 
			#saynn("You feel how toys stimulate your weak points")
			if GM.pc.getArousal() >= 1:
				if getModuleFlag("BDSMstuff","PetWalk"):
					GM.main.playAnimation(StageScene.PuppySolo, "stand",{npc="pc", pcCum=true, npcbodyState={hard=true}})
				else:
					#GM.pc.orgasmFrom("pc")
					GM.main.playAnimation(StageScene.Solo, "defeat",{npc="pc", pcCum=true, npcbodyState={hard=true}})
					
				GM.pc.addArousal(-1.0)
				sayn("You force to cum by toys")

	#print(GM.main.getCurrentScene().saveData()["currentCharactersVariants"].keys())
	return

func StatsChange(_character, _arg):
	_character.addArousal(_arg[_character.get_name()][2])
	_character.addLust(_arg[_character.get_name()][0])
