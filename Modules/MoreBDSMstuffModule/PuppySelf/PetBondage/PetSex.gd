extends SceneBase

var npcID = ""
var npc:DynamicCharacter
var pc = GM.pc

func _init():
	sceneID = "PetSex"

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)
	setState("")
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID
		
func _run():
	if(state == ""):
		saynn("Your escape failed.")
		saynn("No matter how hard you try, you can't escape in the restraints, and now he's already pounding you far away, repeating in this movement")
		saynn("[say=npc]Never.. mess.. with.. me![/say]")
		saynn("As soon as you start moaning, he picks up the pace, you feel his cock sliding inside you while you're constrained and helpless.")
		saynn("Now you're his toy and nothing more, and he'll decide only when it's over")
		#ваш побег провалился.
		#Как бы вы не старались, в ограничителях далеко не убежать, и вот он уже долбит вас повторяя в такт движениям
		#Никогда... не шути... со... мной.
		#Вскоре вы начинаете стонать, он набирает темп, вы чувствете как его член скользит внутрит вас, пока вы скованы и беспомощны.
		#Сейчас вы его игрушка и не более, и только ему решать когда это закончится
		playAnimation(StageScene.PuppySexAllFours, "fast", {pc=npc, npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		if RNG.chance(50):
			addButton("Continue", "See what happens next", "phase2_in")
		else:
			addButton("Continue", "See what happens next", "phase2_out")
		
	if(state == "phase2_in"):
			playAnimation(StageScene.PuppySexAllFours, "inside", {pc=npc, npc="pc", pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			
			saynn("You feel his cock pulsating as he thrusts it all the way in and shoots a load deep inside you.")
			#Вы чувтыуете как его член пульсирует, он загоняет его в на всю длинну и выстреливает заряд, заполняя вас.
			saynn("You tremble as much as the restraints allow, greedily milking his friend. The sensations of his cock deep inside and the warmth of the filling sperm bring you to the peak.")
			#Вы дрожите насколько позволяют ограничители, жадно выдаивая его дружка. Ощущения его члена глубоко внутри и тепло заполняющей спермы доводят вас до пика.
			saynn("[say=npc]Hope you learned your lesson, pervert.[/say]")
			#Надеюсь ты усвоил урок, извращенец.
			saynn("[say=pc]wo..oo..f![/say]")
			saynn("Perhaps you wouldn't mind repeating this lesson...")
			#Возможно, вы не против повторить этот урок...
			addButton("Leave", "Run while you have a chance.", "endthescene")
			addButton("Beg","Beg him.","phase3_beg")
			
	if(state == "phase2_out"):
			playAnimation(StageScene.PuppySexAllFours, "tease", {pc=npc, npc="pc", pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			saynn("You feel his cock pulsating. At the last moment he pulls his cock out, a relieved sigh flies out of his mouth and he covers your back with sticky cum.")
			saynn("You tremble as much as the restraints allow. This asshole... you've almost reached the peak, just a little more, you can barely stand, but you want more, you want to cum.")
			saynn("[say=npc]What's wrong? Didn't like the treat?")
			saynn("[say=pc]...[/say]")
			saynn("[say=npc]Oh, look at you, someone didn't cum, huh? BEG.[/say]")
			##Вы чувствуете как его член пульсирует. В последний момент он вытаскивает свой член, из его рта вылетает облегченный выдох и он покрывает вашу спину липким семенем.
			##Вы дрожите насколько позволяют ограничители. Этот козёл.. вы почти достигли пика, ещё бы чуть чуть, вы еле стоите, но хотите ещё, хотите кончить.
			#Что такое? Выглядишь растроенным
			#...
			#Ах кто-то не кончил? Проси. 
			addButton("Leave","Run while you have a chance.","endscene")
			addButton("Beg","Beg him.","phase3_beg")
	
	if(state == "phase3_beg"):
			playAnimation(StageScene.PuppyDuo, "stand", {pc=npc, npc="pc", npcAction="sad", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			saynn("[say=npc] Now I like it. We won't need this anymore.[/say]")
			saynn("He removes your restraints.")
			saynn("[say=npc] Show me your ass, slut.[/say]")
			#Вот теперь мне это нравиться. Это нам больше не понадобиться.
			#Он снимает с вас ограничители.
			#Покажи мне свою задницу, шлюшка.
			addButton("Continue", "See what happens next.","phase3_sex")
	if(state == "phase3_sex"):
			GM.pc.getInventory().removeItemFromSlot(InventorySlot.Static1)
			playAnimation(StageScene.SexLowDoggy, "fast", {pc=npc, npc="pc", bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
			saynn("You obey, lie down on your stomach and lift your ass, slightly commanding it with impatience.")
			saynn("[say=npc]Good boy.[/say]")
			saynn("He pins you to the floor and inserts his cock.")
			saynn("[say=npc]Let's have some fun.[/say]")
			saynn("He roughly pounds you like a doll and you completely surrender to the pleasure, responding with a loud moan to each of his thrusts.")
			saynn("You are his toy again, not tied up but still powerless, and this time he will make sure that you are satisfied.")
			#Вы подчиняетесь, ложитесь на живот и поднимаете задницу, слегка веляя ей от нетерпения.
			#Хороший мальчик.
			#Он приживет вас к полу и вставляет член.
			#Повеселимся.
			#Он грубо долбит вас как куклу и вы полностью отдаётесь удовольствию, отвечая громким стоном на каждый его толчок.
			#Вы снова его игрушка, не связаны но всё также бессильны, и на этот раз он убедится что удовлетворены.
			addButton("Continue", "Fuck until one of you passes out.","phase3_end")
	if(state == "phase3_end"):
		
		playAnimation(StageScene.Sleeping, "sleep", {pc=pc, bodyState={naked=true}})
		
		saynn("When you woke up, he was gone, but everything he did to you echoed in your body, and the pleasure was still rolling in wave after wave")
		saynn("Perhaps it's worth repeating this sometime...")
			#Когда вы очнулись, его уже не было, но всё что он с вами сделал эхом отдавалось в вашем теле.
			#Возможно, стоит как-нибудь это повторить...
		addButton("Leave","Time to go.","endthescene")
		#
		#
		#
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "phase2_out"):
		processTime(10*60)
		pc.cummedOnBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.5))
	
	if(_action == "phase2_in"):
		processTime(10*60)
		if pc.hasVagina():
			pc.cummedInVaginaBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.5))
		else:
			pc.cummedInAnusBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.7))

	if(_action == "phase3_end"):
		var timePass = RNG.randi_range(1, 3)
		setModuleFlag("BDSMstuff","PetWalk",false)
		processTime(timePass*60*60)
		if pc.hasVagina():
			pc.gotVaginaFuckedBy(npcID)
			for cummed in timePass*3:
				pc.cummedInVaginaBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.5))
				pc.gotVaginaFuckedBy(npcID, false)
		else:
			pc.gotAnusFuckedBy(npcID)
			for cummed in timePass*3:
				pc.cummedInAnusBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.7))
				pc.gotAnusFuckedBy(npcID, false)
		
		pc.gotThroatFuckedBy(npcID)
		for inMouth in RNG.randi_range(1, timePass):
			#pc.cummedOnBy(pc)
			pc.cummedInMouthBy(npcID)
			pc.gotThroatFuckedBy(npcID, false)
			pc.cummedOnBy(npcID, FluidSource.Penis, RNG.randf_range(0.3, 0.5))
	
	setState(_action)
