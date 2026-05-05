extends SceneBase

var npcID = ""
var pc #= GM.pc#:DynamicCharacter
var npc2ID = ""
var npc2:DynamicCharacter
var whoStr = "inmate"
var npcVariation = "mean"

var keyFetish = ""
var countIteractions = 0
var countTreat = 0
var _biteCount = 0

func _init():
	sceneID = "Pet"
	
func _initScene(_args = []):
	pc = GM.pc
	npc2ID = _args[0]

func _reactInit():
	
	npc2 = getCharacter(npc2ID)
	addCharacter(npc2ID)
		
	var personality:Personality = npc2.getPersonality()
	
	var biggestStat = PersonalityStat.Mean
	var biggestStatNum = personality.getStat(PersonalityStat.Mean)
	var lowestStat = PersonalityStat.Mean
	var lowestStatNum = personality.getStat(PersonalityStat.Mean)
	var statsToCheck = [PersonalityStat.Subby, PersonalityStat.Coward]
	for theStat in statsToCheck:
		var theValue = personality.getStat(theStat)
		if(theValue > biggestStatNum):
			biggestStatNum = theValue
			biggestStat = theStat
		if(theValue < lowestStatNum):
			lowestStatNum = theValue
			lowestStat = theStat
	
	if(biggestStatNum > (-lowestStatNum)):
		#Big stat
		if(biggestStat == PersonalityStat.Mean):
			npcVariation = "mean"
		if(biggestStat == PersonalityStat.Subby):
			npcVariation = RNG.pick(["kind", "subby"])
		if(biggestStat == PersonalityStat.Coward):
			npcVariation = RNG.pick(["kind", "subby"])
	else:
		#Low stat
		if(lowestStat == PersonalityStat.Mean):
			npcVariation = "kind"
		if(lowestStat == PersonalityStat.Subby):
			npcVariation = RNG.pick(["kind", "mean"])
		if(lowestStat == PersonalityStat.Coward):
			npcVariation = "mean"

func resolveCustomCharacterName(_charID):
	if(_charID == "npc2"):
		return npc2ID



func _run():
	#debug
	#npcVariation = "mean"
	
	if(state == ""):
		#addButton("Continue", "Enough for now", "mean_run")
		#playAnimation(StageScene.Beg_1, {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})

		saynn("As you walk your puppy around the station, you walk into one of the "+str(whoStr)+"s.")
		if(npcVariation == "kind"):
			saynn("[say=npc2]"+RNG.pick([
				"Oh, what a cute little pup.",
				"That is an adorable pup!",
				"What a cutie!",
				"I see a pup out on walkies, hah.",
				"Oh wow, cute pup.",
			])+"[/say]")
			
		if(npcVariation == "mean"):
			saynn("[say=npc2]"+RNG.pick([
				"Hey, I'm walking here.",
				"Get out of the way.",
				"Looks like someone's in trouble."
			])+"[/say]")
			
			saynn("The "+whoStr+"'s furrows {npc2.his} brows.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Don't sniff me.",
				"Don't look at me, stupid dog.",
				"The fuck do you want? Fuck off.",
				"Go away before I step on you.",
			])+"[/say]")
			
		if(npcVariation == "subby"):
			saynn("[say=npc2]"+RNG.pick([
				"Oh.. What a cute puppy.",
				"Ohh..",
				"Oh wow. Don't mind me..",
				"Puppy!",
			])+"[/say]")
			
			saynn("The "+whoStr+"'s blushes a bit.")
			
			saynn("[say=npc2]"+RNG.pick([
				"Wish I'd be on a leash like that..",
				"I like walkies a lot. Do you bite, little one?",
				#"I'm not drooling.. Does {npc.he} bite?",
			])+"[/say]")
		if !GM.pc.isOralBlocked():
			addButton("Bite", "Bite them", "bite")
		else:
			addDisabledButton("Bite", "Your mouth is bloked!")
			
		addButton("Play", "Maybe make some fun with them?", "play")
		addButton("Ask for help", "Ask to remove pup gear", "help")
		addButton("Leave", "Just walk past", "endthescene")
		#addButton("Debug","","mean_run")
	if state == "bite":
		addButton("Сontinue", "Do something else", "")
		#playAnimation(StageScene.PuppySexOral, "tease", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
		if(npcVariation == "kind"):
			playAnimation(StageScene.PuppyDuo, "dodge", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
			saynn("[say=npc2]"+RNG.pick([
				"What a lively puppy!",
				"Calm down, little one",
				"Oh wow. Easier, easier.",
			])+"[/say]")
			
		if(npcVariation == "mean"):
			#print(_biteCount)
			playAnimation(StageScene.PuppyDuo, "hurt", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
			_biteCount += 1
			saynn("[say=npc2]"+RNG.pick([
				"Ouch! Fuck off stupid dog!",
				"Oh, fuck off.",
				"Ouch, you want to die stupid dog?! ",
			])+"[/say]")
			if _biteCount >= 3 and npc2.hasPenis():
				if npc2.hasPenis():
					saynn("[say=npc2] Better run, little shit.[/say]")
					addButton("Run", "Try to run away.","mean_run")
				else:
					saynn("[say=npc2] Fuck off![/say]")
					GM.pc.addPain(40)
			
		if(npcVariation == "subby"):
			playAnimation(StageScene.PuppyDuo, "defeat", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
			saynn("[say=npc2]"+RNG.pick([
				"Ah, don't be so rude.",
				"Ouch, why?",
				"Ouch, don't do that",
				])+"[/say]")
				
				
	if state == "play":

		saynn("You sit up on your hind legs and wag your tail, excited for all the mischief you can get up to.")
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npcAction="sit", npc=pc, npcBodyState={naked=true}})
		
		if countIteractions >= 5 and npcVariation == "mean":
			sayn("He seems to have become more favorable after your actions.")
		if countIteractions >= 2 and npcVariation == "subby":
			sayn("He seems to have become more favorable after your actions.")
			
		if countIteractions != countTreat and countIteractions !=0:
			addButton("Paw", "You can get a treat.", "paw")
		else:
			addDisabledButton("Paw", "You don’t deserve the treat, yet.")
		addButton("Lick", "Lick their crotch.", "lick")
		addButton("Pat", "Let them pat you.","pat")
		if countIteractions >= 2:
			addButton("Roll back", "Let them pat your belly or...", "feetplay")
		addButton("Back", "Or maybe not.", "")

		#if(npcVariation == "subby"):
		#	addButton("More","Play little bit more agressive", "subby_play")

	if state == "paw":
		var _getStat
		countTreat +=1
		saynn("You lift your front paw and scratch at his leg, begging for a treat.")
		saynn("[say=pc]woof woof?[/say]")
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npcAction="paw", npc=pc, npcBodyState={naked=true}})
		addButton("Сontinue", "Do something else", "play")
		
		if(npcVariation == "kind"):
			saynn("[say=npc2]"+RNG.pick([
				"Do you want a treat? A good treat for a good dog",
				"Yes, yes, you deserve it, here you go",
				"Who's a good dog? Who's a good dog? You're a good dog, here’s a treat.",
				])+"[/say]")
				
			saynn("[say=pc]woof![/say]")
			saynn("You happily wag your tail.")
			pc.addPain(-80)
			_getStat = "-80 pain"
			
		if(npcVariation == "mean"):
			saynn("You happily wag your tail.")
			saynn("[say=npc2]"+RNG.pick([
				"Do you want a treat? Here’s what you’ve earned",
				"A treat? Hah, well, here you go",
				"You really think you'll get something decent from me? You wish, but now there's no way out",
				])+"[/say]")
			saynn("[say=pc]wo..of?[/say]")
			saynn("The tail wagging stops...")
			pc.addLust(60)
			_getStat = "60 lust"
			
		if(npcVariation == "subby"):
			saynn("[say=npc2]"+RNG.pick([
				"Oh, you want a treat? Here you go, cutie",
				"A treat? Hmm, I have something special",
				"A good treat for a good little puppy",
				])+"[/say]")
			saynn("[say=pc]woof![/say]")
			saynn("You happily wag your tail.")
			pc.addStamina(30)
			_getStat = "30 stamina"
			
		saynn("{npc2.name} give you a pill, you get " + _getStat + ".") #кормит вас (таблетка), вы получили (getStat)
		
	
	if state == "help":
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npcAction="sad", npc=pc, npcBodyState={naked=true}})
		#if pc.isOralBlocked():
		sayn("You scratch the bonds and whimper, with your tail lowered.")
		
		addButton("Back","Do something else.","")
		
		if(npcVariation == "kind"):
			if countIteractions == 0:
				saynn("[say=npc2]"+RNG.pick([
					"Hm? Was that unintentional? Well, alright, I'll take it off",
					"Someone got carried away and can't get out? Alright, come here.",
					"And how did you end up like this? Okay, I'll help you now."
					])+"[/say]")
				saynn("[say=pc]woof![/say]")
				saynn("You happily wag your tail.")
				addButton("Remove", "Remove the restraints.", "remove")
			else:
				saynn("[say=npc2]"+RNG.pick([
					"Oh, I wish I could play with you a little longer, come here.",
					"It's a pity, you look so cute in them, so sweet and adorable... ahem, come here, I'll help you take them off.",
					"Oh, you want to take them off? Of course, come to me, puppy."
					])+"[/say]")
				saynn("[say=pc]woof![/say]")
				saynn("You happily wag your tail.")
				addButton("Remove", "Remove the restraints.", "remove")
				
		if(npcVariation == "mean"):
			if countIteractions >= 5:
					sayn("[say=npc2] Good job, little whore. You deserve some help. [/say]")
					sayn("{npc2.name} bends and begins to stretch the belts on your pet suit.")
					addButton("Сontinue", "","remove")
					
			#elif countIteractions >= 2 and RNG.chance(50): 
			#		sayn("[say=npc2] Not so fast, pup, you make me hard, so, time for consequences.")
					#you want to get rid of it?
					
			else:
				playAnimation(StageScene.PuppyPinned, "pinned", {pc=npc2ID, npc="pc", npcBodyState={naked=true, hard=true}})
				saynn("[say=npc2]"+RNG.pick([
				"Someone's stuck, huh? Better ask nicely, and I'll think about it.",
				"You may suck. Get yourself out of this on your own.",
				"Are you tired of being a dog, huh?"
					])+"[/say]")
				saynn("You need to earn his favor if you want him to help you.")
				
		if(npcVariation == "subby"):
			if countIteractions >= 2:
				saynn("[say=npc2]"+RNG.pick([
				"Oh, it's so mmm... tight... is it squeezing? Let me take it off.",
				"Come here, little puppy, let me help.",
				"Looks too tight, let me loosen it a bit..."
					])+"[/say]")
				addButton("Remove", "Remove the restraints.", "remove")
			else:
				saynn("[say=npc2]"+RNG.pick([
				"Sorry, but I don't want any trouble.",
				"No, I can't do that.",
				"I don't know what you did wrong, but don't involve me."
					])+"[/say]")
				saynn("Maybe play with him to make him more cooperative?") 


	if state == "lick":
		countIteractions +=1
		saynn("You move closer and sniff"+whoStr+"'s crotch.")
		playAnimation(StageScene.PuppySexOral, "grind", {pc=npc2ID, npc=pc, npcBodyState={naked=true}})
		if(npcVariation == "kind"):
			saynn("Barking playfully, you wait for permission to go further.")
			saynn("[say=npc2]"+RNG.pick([
				"Oh what a slutty pup, wanna taste me?",
				"Wow, what a naughty puppy, let's see what you can.",
				"Horny pup, let's evaluate your skills."
				])+"[/say]")
				
			if pc.isOralBlocked():
				GM.pc.getInventory().removeItemFromSlot("mouth")
				saynn("[say=npc2] I think this will hinder us.[/say]")
				saynn("{npc2.name}, carefully unfastens the clasps and frees your mouth.")
				
			saynn("You come closer and start licking your partner's crotch. {npc2.name} puts hand on your head and strokes it while you work your tongue hard.")
			saynn("[say=npc2]Good boy...[/say]")
			
		if(npcVariation == "mean"):
			saynn("Playfully barking, you obediently wait for permission to go further.")
			saynn("[say=npc2]"+RNG.pick([
				"Little slut, wanna taste me?",
				"Hah, let's evaluate your skills.",
				"The naughty puppy knows how to properly appease."
				])+"[/say]")
				
			if pc.isOralBlocked():
				GM.pc.getInventory().removeItemFromSlot("mouth")
				saynn("[say=npc2] I think this will hinder us.[/say]")
				saynn("{npc2.name}, carefully unfastens the clasps and frees your mouth.")
				
			saynn("{npc2.name} takes your head and presses it to his groin, you obediently begin to lick your new master's crotch.")
			saynn("[say=npc2]Lick it thoroughly...[/say]")
			
		if(npcVariation == "subby"):
			if pc.isOralBlocked():
				GM.pc.getInventory().removeItemFromSlot("mouth")
				saynn("[say=npc2] Let me help you.[/say]")
				saynn("{npc2.name}, carefully unfastens the clasps and frees your mouth.")
			sayn("Without waiting for permission, you start licking. He doesn't resist")
			saynn("It seems you've hit a weak spot, he presses your head closer and starts moaning.")
			saynn("[say=npc2]"+RNG.pick([
				"Oh, not so suddenly! What a... dirty dog.",
				"Oh, yes here...",
				"Mmm a little deeper mmm... yes like this.."
				])+"[/say]")
			sayn("You feel how he reacts to every movement of your tongue, he is completely in your power...")

		if npc2.hasPenis():
			addButton("Continue", "Go a little further...", "Lick_suck")
		elif npc2.hasVagina():
			addButton("Continue", "Go a little further...", "Lick_lick")
			
		addButton("Back","Enough for now", "play")
	
	if state == "Lick_lick":
		countIteractions += 1
		saynn("You penetrate {npc2.name}'s pussy deeper, working your tongue hard. In response, she presses your head closer, you feel how her tremble.")
		saynn("[say=npc2] Mmm... yes.. uh.. yes, deeper, right here... mmh![/say]")
		playAnimation(StageScene.PuppySexOral, "grind", {pc=npc2ID, npc=pc, bodyState={naked=true}, npcBodyState={naked=true}})
		addButton("Continue", "See what happens next", "Lick_lick_cum")
		
	if state == "Lick_lick_cum":
		playAnimation(StageScene.PuppySexOral, "grind", {pc=npc2ID, npc=pc, pcCum=true, bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("You stimulate her weak spots, taking her to the edge. She cums and her love juices flow down your face.")
		sayn("[say=npc2] Damn... you're so good at this.. pervert...[/say]")
		sayn("She heavily breathes")
		sayn("[say=npc2] Ah... that was good.. good boy...[/say]")
		
		addButton("Continue", "It seems you did a good job. He become more compliant", "play")
		
		
	if state == "Lick_suck":
		countIteractions += 1
		playAnimation(StageScene.PuppySexOral, "fast", {pc=npc2ID, npc=pc, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		sayn("You feel how his penis begins to respond to your movements, it becomes hard, sticking out more and more under clothes.")
		saynn("You both feel aroused. The smell is intoxicating, you involuntarily try to get your tongue under the clothes to get what you want")
		saynn("[say=npc2] Ah, you so good at it, slutty pup. Let me use your mouth proprly [/say]")
		sayn("You obediently opens maw and lets the "+whoStr+" fuck it raw.")
		
		addButton("Continue", "See what happens next", "Lick_suck_fast")
		
	if state == "Lick_suck_fast":
		playAnimation(StageScene.PuppySexOral, "fast", {pc=npc2ID, npc=pc, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("You feel his cock pulsating in your mouth, he's almost finished. He grabs your head harder, pushing you down onto his cock up to your throat and picks up the pace.")
		sayn("Resisting is useless, he roughly fucks you up to your throat. His cock pulsates harder and you obediently prepare to take the load while you're used like a toy.")
		if RNG.chance(70):
			addButton("Continue", "See what happens next", "Lick_suck_fast_cum_in")
		else:
			addButton("Continue", "See what happens next", "Lick_suck_fast_cum_out")
		
	if state == "Lick_suck_fast_cum_in":
		saynn("He presses your head to his groin, entering his entire length, and cums filling your throat.")
		saynn("[say=npc2]"+RNG.pick([
			"Oh yeah, that's a good slutty pet.",
			"Swallow it all, cutie.",
			"There we go. Such a nice mouth.",
			])+"[/say]")
		if RNG.chance(30):
			saynn("Feeling his cum filling your mouth and his cock filling your throat brings you to your peak")
			playAnimation(StageScene.PuppySexOral, "fast", {pc=npc2ID, npc=pc, pcCum=true, npcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		playAnimation(StageScene.PuppySexOral, "fast", {pc=npc2ID, npc=pc, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		addButton("Continue", "It seems you did a good job. He become more compliant", "play")
	#	addButton("Continue", "See what happens next", "Lick_suck_fast") again
	
	if state == "Lick_suck_fast_cum_out":
		saynn("He stops pushing your head onto his cock to cum all over your face. You stick your tongue out lustfully, obediently taking all of his sticky cum.")
		#Он перестаёт насаживать вашу голову на член чтобы кончить вам на лицо. Вы похотливо высовываете язык, послушно принимая всю его липкую сперму.
		playAnimation(StageScene.PuppySexOral, "tease", {pc=npc2ID, npc=pc, pcCum=true, bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		
		saynn("[say=npc2]"+RNG.pick([
			"Enjoy being messy, pup.",
			"You like cum, don't you?",
			"Oops, marked you with my cum.",
			"You lick it off if you want.",
		])+"[/say]")
		addButton("Continue", "It seems you did a good job. He become more compliant", "play")
	#	addButton("Continue", "It seems you did a good job.", "Lick_suck_fast")
	
	if state == "pat":
		countIteractions += 1
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=pc, npcAction="sit", npcBodyState={naked=true, hard=true}})
		#playAnimation(StageScene.Beg, "beg", {pc=pc, npc=npc2ID, npcBodyState={naked=true, hard=true}})
		#if countIteractions <=2:
		saynn("[say=pc]woof![/say]")
		saynn("You friendly wag your tail and playfully rub against {npc2.his} hand.")
		addButton("Continue", "See what happend next", "pat_end")
			
	if state == "feetplay":
		saynn("After the previous games, you feel more relaxed and lustful. You roll over onto your back and whine playfully")
		saynn("[say=pc]woof..-f[/say]")
		playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=pc, npcAction="back", npcBodyState={naked=true, hard=true}})
		addButton("Continue", "See what happens next", "pat_feetplay")
		#playAnimation(StageScene.PuppyDuo, "kneel", {pc=npc2ID, npc=pc, npcAction="sit", npcBodyState={naked=true, hard=true}})
		
	if state == "pat_end":
			if(npcVariation == "kind"):
				playAnimation(StageScene.Beg, "pat", {pc=pc, npc=npc2ID, pcBodyState={naked=true, hard=true}})
				saynn("[say=npc2]"+RNG.pick([
					"Do you want me to pet you? What a cutie.",
					"Pet you? Of course I want to pet you!",
					"Pet, pet, pet..."
				])+"[/say]")
			saynn("He carefully pats your head.")
			saynn("[say=npc2] What a cute pup[/say]")
		
			if(npcVariation == "mean"):
				saynn("{npc2.HeShe} hits you and pinn you head to the ground")
				playAnimation(StageScene.PuppyPinned,{pc=npc2ID, npc=pc, npcBodyState={naked=true, hard=true}})
				saynn("[say=npc2]"+RNG.pick([
					"Fuck off!",
					"Don't even try.",
					"Fuck off, you stupid dog!"
					])+"[/say]")
				
			if(npcVariation == "subby"):
				saynn("You friendly wag your tail and playfully rub against his hand.")
				playAnimation(StageScene.Beg, "pat", {pc=pc, npc=npc2ID, pcBodyState={naked=true, hard=true}})
				#playAnimation(StageScene.PuppyDuo, "stand", {pc=npc2ID, npc=pc, npcAction="sit", npcBodyState={naked=true, hard=true}})
				saynn("[say=npc2]"+RNG.pick([
					"It's hmm... nice, what a cutie",
					"Soft... nice to pet",
					"You won't bite?"
					])+"[/say]")
				sayn("He pets you with undisguised pleasure.")

			addButton("Continue", "It seems he likes it. He become more compliant", "play")

	if state == "pat_feetplay":
		playAnimation(StageScene.PuppyFeetCrotch, "crotch", {pc=npc2ID, npc=pc, npcBodyState={naked=true, hard=true}})
		saynn("{npc2.HeShe} putting {npc2.his} foot on your crotch.")
		
			#if(npcVariation == "kind"):
		if (pc.isWearingChastityCage()):
				saynn("Your caged up cock responds instantly to the touch, and the cage becomes tight and damp.")
				saynn("[say=npc2] Oh, what a lecherous dog you are, you really wanted me to pet you here, didn't you?[/say]")
				saynn("{npc2.HeShe} slowly plays with his foot around your cage, pressing on it with his fingers, then playing with your balls as you squirm from each touch.")
				saynn("[say=npc2] It's a pity to be locked up and unable to give yourself pleasure.[/say]")
				saynn("{npc2.HeShe} presses harder, you twitching, but the restraints hold you securely. You are helpless. The cage has become unbearably tight, and your perineum is wet from pre. You are on the edge, and your 'master' sees it.")
				saynn("[say=npc2] You're so sweet, so helpless, and so aroused...[/say]")
				#saynn("[say=pc]wo-of...[/say]")
					#Be a good boy, ask nicely. What do you want?
					#Woo-oof! Wooo-of!
					#Ваш член мгновенно реагирует на прикоснование, клетка становиться тесной и влажной.
					#Охо, что за похотливый пес, ты оочень хотел чтобы я погладил тебя здeсь, да?
					#Он неторопливо играет своей ногой с вашей клеткой то надавливая на неё пальцами, то поигравая с вашими яйцами, пока вы извивается от каждого прикосновения.
					#Какая жалость, быть запертым, и не иметь возможности доставить себе удовольствие.
					#Он надавливает сильнее, вы дёргаетесь, но ограничители надёжно держат вас, вы беспомощны. Клетка стала невыносимо тесной, а промежность влажной от предэкуляра. Вы на грани, и ваш "хозяин" это видит.
					#Ты такой сладкий, такой беспомощный и так возбуждён..
					#wo-of...
					#Будь хорошим мальчиком, проси лучше. Что ты хочешь?
					#Wo-oof! Wooo-of!
		elif (pc.hasReachablePenis()):
				saynn("Your {pc.penis} instantly reacts, getting hard and leaking a drop of pre.")
				saynn("[say=npc2] Oh, what a lecherous dog you are, you really wanted me to pet you here, didn't you? [/say]")
				saynn("{npc2.HeShe} begins to slowly run his foot along your member, teasing the tip with his fingers. You squirm under his foot with each movement, your cock pulsating and leaking, and the sensitive head driving you crazy.")
				saynn("[say=npc2] What an exciting show.[/say]")
				saynn("{npc2.HeShe} presses harder, you twitching, but the restraints hold you securely. You are helpless. With each press, your member jerks more strongly, ejecting pre. You're on the edge, and your 'master' sees it.")
				saynn("[say=npc2]You're so sweet, so helpless, and so aroused...[/say]")
					#wo-of...
					#Be a good boy, ask nicely. What do you want?
					#Woo-oof! Wooo-of!
					#ваш член сразу реагирует, становясь твёрдым и выделяя преэкуляр
					#Охо, что за похотливый пес, ты оочень хотел чтобы я погладил тебя здeсь, да?
					#Он начинает медленно водить ногой по вашему члену(), подразнивая пальцами кончик. Вы извиваетесь под его ногой от каждого движения ваш член пульсирует и течёт, а раздраженная головка сводит с ума.
					#Что за увлекательное шоу
					#Он надавливает сильнее, вы дёргаетесь, но ограничители надёжно держат вас, вы беспомощны. С каждым нажатием ваш член дёргается всё сильнее выплёскивая предэкуляр, вы на грани, и ваш "хозяин" это видит.
					#Ты такой сладкий, такой беспомощный и так возбуждён..
					#wo-of...
					#Будь хорошим мальчиком, проси лучше. Что ты хочешь?
					#Wo-oof! Wooo-of!
		elif (pc.hasReachableVagina()):
				saynn("Your vagina instantly reacts, becoming wet.")
				saynn("[say=npc2] Ohoh, what a horny dog you really wanted me to pet you here, didn't you?[/say]")
				saynn("{npc2.HeShe} plays his foot leisurely with your hole and teases your clitoris with fingers as you squirm from every touch undersaynn {npc2.his} foot.")
				saynn("[say=npc2] Look at you, so wet, and we haven’t even started yet.[/say]")
				saynn("{npc2.HeShe} presses harder, you twitching, but the restraints hold you securely, you’re helpless. With each tap, more juice comes out of your vagina. You’re on the edge, and your 'master' sees it.")
				saynn("[say=npc2] You’re so sweet, so helpless and so aroused...[/say]")
					#wo-of...
					#Be a good boy, ask better. What do you want?
					#Wo-oof! Wooo-of!
					#Ваша вагина сразу реагирует, становясь мокрой.
					#Охо, что за похотливый пес, ты оочень хотел чтобы я погладил тебя здeсь, да?
					#Он неторопливо играет своей ногой с вашей дырочкой и дразнить ваш клитор пальцами, пока вы извивается от каждого прикосновения под его ногой.
					#Посмотри на себя, так промокла, а мы ещё даже не начали.
					#Он надавливает сильнее, вы дёргаетесь, но ограничители надёжно держат вас, вы беспомощны. С каждым нажатием из вашей вагины вытекает всё больше соков. Вы на грани, и ваш "хозяин" это видит.
					#Ты такой сладкий, такой беспомощный и так возбуждён..
					#wo-of...
					#Будь хорошим мальчиком, проси лучше. Что ты хочешь?
					#Wo-oof! Wooo-of!
				#saynn("[say=npc2]"+RNG.pick([
				#])
		saynn("[say=pc]wo-of...[/say]")
		saynn("[say=npc2] Be a good boy, ask nicely. What do you want?[/say]")
			
		#saynn("You slouch, trying to rub yourself against his foot, whine and look plaintively into his eyes.")
		#saynn("[say=pc]Woo-oof! Wooo-of![/say]")
		#saynn("You slouch, trying to rub yourself against his foot, whine and look plaintively into his eyes.")
			#Вы извиваетесь, стараясь самому потереться о его ногу, скулите и жалобно смотрите ему в глаза.+
			#Good boy
			
			#Cum! Let me cum! Pliese! I begging you! -
			#Wrong!
			#
			#if(npcVariation == "mean"):
			#
			#
			#
			#if(npcVariation == "subby"):
			#
			#
			#

		
		addButton("Whimp", "Show that you a good puppy.", "feetplay_allowcum")
		addButton("Beg", "Beg them.", "feetplay_deny")
		
	if(state == "feetplay_deny"):
		saynn("[say=pc]Cum! Let me cum! Please![/say]")
		saynn("[say=npc2]Not this time.[/say]")
		if (pc.isWearingChastityCage()):
			saynn("{npc2.HeShe} steps on you harder, bringing you to peak with {npc2.his} foot.. just to stop, exactly when your locked away cock began twitching behind its little cage.")

		elif (pc.hasReachablePenis()):
			saynn("{npc2.HeShe} steps on you harder, bringing you to peak with {npc2.his} foot.. just to stop, exactly when your {pc.penis} began twitching and throbbing.")

		elif (pc.hasReachableVagina()):
			saynn("{npc2.HeShe} steps on you harder, bringing you to peak with your foot.. just to stop, exactly when your {pc.pussyStretch} pussy began twitching subtly.")

		saynn("Your whining and squirming a lot, desperate for release.. that never comes.. {npc2.he} keep you pinned to the floor with {npc2.his} foot, waiting for you to cool down.")

		saynn("[say=npc2]So cute.[/say]")
		
		addButton("Continue", "See what happens next", "play")
	
	if(state == "feetplay_allowcum"):
		saynn("You slouch, trying to rub yourself against his foot, whine and look plaintively into his eyes.")
		saynn("[say=pc]wooo-of...[/say]")
		saynn("[say=npc2] Good puppy...[/say]")
		playAnimation(StageScene.PuppyFeetCrotch, "crotch", {pc=npc2ID, npc=pc, npcCum=true, npcBodyState={naked=true, hard=true}}) 
		if (pc.isWearingChastityCage()):
			saynn("{npc2.HeShe} keep rubbing and caressing your chastity cage and balls.. until the your member inside suddenly starts throbbing and shooting cum past the little hole in the cage, all of it landing on your own belly.")

		elif (pc.hasReachablePenis()):
			saynn("{npc2.HeShe} keep rubbing and caressing your cock, balls and tip.. until the spasm passes through your entire body, you throbbing and shooting strings of thick cum, with all of them landing on on your own belly.")

		elif (pc.hasReachableVagina()):
			saynn("{npc2.HeShe} keep rubbing and caressing your slick needy pussy.. until you releases a passionate cute noise, your petals pulsing while a stream of transparent girlcum hits your own thighs, making them look quite wet.")

		saynn("After all of that, {npc2.he} left you panting and squirming, the forced orgasm making your cheeks look red.")

		addButton("Continue", "See what happens next", "play")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "remove"):
		setModuleFlag("BDSMstuff","PetWalk",false)
		GM.pc.getInventory().removeItemFromSlot(InventorySlot.Static1)
		#GM.pc.getInventory().removeEquippedItem("bitchsuit_not_for_use")
		endScene()
		return
	if(_action == "Lick_lick_cum"):
		processTime(5*60)
		pc.cummedOnBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.5))
		pc.cummedInMouthBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.7))
		
	if(_action == "Lick_suck_fast_cum_in"):
		processTime(5*60)
		pc.cummedInMouthBy(npc2ID)
		pc.gotThroatFuckedBy(npc2ID)

	if(_action == "Lick_suck_fast_cum_out"):
		processTime(5*60)
		pc.cummedOnBy(npc2ID)
		pc.gotThroatFuckedBy(npc2ID)

	if(_action == "Lick_Lick_fast_cum_out"):
		processTime(5*60)
		pc.cummedOnBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.5))
		pc.cummedInMouthBy(npc2ID, FluidSource.Vagina, RNG.randf_range(0.3, 0.7))
	
	if(_action == "feetplay_allowcum"):
		processTime(5*60)
		#pc.cummedOnBy(GM.pc)
		
	if(_action == "feetplay_deny"):
		processTime(5*60)
		pc.addLust(100)
		
	if(_action == "mean_run"):
		#if RNG.chance(50):
			endScene()
			runScene("PetSex",[npc2ID])
			return

	setState(_action)



func saveData():
	var data = .saveData()
	
	#data["npcID"] = npcID
	data["npc2ID"] = npc2ID
	data["whoStr"] = whoStr
	data["npcVariation"] = npcVariation

	return data
	
func loadData(data):
	.loadData(data)
	
	#npcID = SAVE.loadVar(data, "npcID", "")
	#pc = GM.pc
	
	npc2ID = SAVE.loadVar(data, "npc2ID", "")
	npc2 = GlobalRegistry.getCharacter(npc2ID)
	whoStr = SAVE.loadVar(data, "whoStr", "")
	npcVariation = SAVE.loadVar(data, "npcVariation", "")


		#if(npcVariation == "kind"):
		#if(npcVariation == "mean"):
		#if(npcVariation == "subby"):
		
	
