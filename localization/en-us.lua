return {
	descriptions = {
		Joker = {
			--167
			j_stall_spinarak = {
				name = 'Spinarak',
				text = {
					"Cards held in hand give {C:chips}+#1#{}",
					"Chips if both their adjacent",
					"{C:attention}Ranks{} are also held",
					"{C:inactive,s:0.8}(Evolves after giving {C:chips,s:0.8}#2#{C:inactive,s:0.8} Chips)"
				}
			},
			j_stall_ariados = {
				name = 'Ariados',
				text = {
					"Cards held in hand give {C:chips}+#1#{}",
					"Chips if both their adjacent",
					"{C:attention}Ranks{} are also held",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:green}#2# in #3#{} chance to {C:attention}enhance{} cards",
					"held in hand with {C:attention}Toxic{} if",
					"both adjacent ranks also trigger",
				}
			},
			--194
			j_stall_paldean_wooper = {
				name = '{s:0.6}Paldean{}Wooper',
				text = {
					"Earn {C:money}$#1#{} when a {C:attention}face{} card is destroyed",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#2#{C:inactive,s:0.8})",
				}
			},
			j_stall_clodsire = {
				name = 'Clodsire',
				text = {
					"Earn {C:money}$#1#{} and enhance a random card in hand",
					"with {C:attention}Toxic{} when a {C:attention}face{} card is destroyed",
				}
			},
			--453
			j_stall_croagunk = {
				name = 'Croagunk',
				text = {
				"If scored hand has exactly {C:attention}1{}", 
				"scoring {C:hearts}Heart{}, each played card",
				"gives {C:mult}+#1#{} Mult when scored",
				"{C:inactive,s:0.8}(Evolves after triggering {C:attention,s:0.8}#2#{C:inactive,s:0.8} times)",
				}
			},
			j_stall_toxicroak = {
				name = 'Toxicroak',
				text = {
				"{C:attention}Toxic",
				"If scored hand has exactly {C:attention}1{}", 
				"scoring {C:hearts}Heart{}, each played card",
				"gives {C:mult}+#1#{} Mult when scored",
				"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Toxic Mult)",
				}
			},
			--540
			j_stall_sewaddle = {
				name = 'Sewaddle',
				text = {
					"Other played cards give {C:attention}half{}",
					"the total {C:chips}Chips{} of first",
					"scored card when scored",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#1#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_swadloon = {
				name = 'Swadloon',
				text = {
					"Other played cards give {C:attention}half{}",
					"the total {C:chips}Chips{} of first",
					"scored card when scored",
					"{br:2}ERROR - CONTACT STEAK",
					"First played card permanently",
					"gains {C:chips}+#1#{} Chips when scored",
					"{C:inactive,s:0.7}(Evolves after giving {C:attention,s:0.7}#2#{C:inactive,s:0.7} scored cards {C:chips,s:0.7}+#3#{C:inactive,s:0.7} Chips)",
				}
			},
			j_stall_leavanny = {
				name = 'Leavanny',
				text = {
					"Other played cards give",
					"the total {C:chips}Chips{} of first",
					"scored card when scored",
					"{br:2}ERROR - CONTACT STEAK",
					"First played card permanently",
					"gains {C:chips}+#1#{} Chips when scored",
				}
			},
			--543
			j_stall_venipede = {
				name = 'Venipede',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}enhance{} first",
					"scoring card with {C:attention}Toxic{}, increase odds",
					"per played hand with {C:attention}5{} scoring cards",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_whirlipede = {
				name = 'Whirlipede',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}enhance{} first",
					"scoring card with {C:attention}Toxic{}, increase odds",
					"per played hand hand with {C:attention}5{} scoring cards",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:attention}Retrigger{} first scoring card if",
					"extra {C:attention}Toxic{} Mult is at least {X:mult,C:white}X#3#",
					"{C:inactive,s:0.8}(Evolves after giving Toxic cards {C:attention,s:0.8}#4#{C:inactive,s:0.8} retriggers)",
				}
			},
			j_stall_scolipede = {
				name = 'Scolipede',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}enhance{} first",
					"scoring card with {C:attention}Toxic{}, increase odds",
					"per played hand hand with {C:attention}5{} scoring cards",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:attention}Retrigger{} first scoring card {C:attention}1{} additional ",
					"time per {X:mult,C:white}X#4#{} extra {C:attention}Toxic{} Mult",
					"{C:inactive,s:0.8} (Max 5 retriggers)"
				}
			},
			--562
			j_stall_galarian_yamask = {
				name = '{s:0.6}Galarian{}Yamask',
				text = {
					"Sell this card to remove {C:pink}Energy{} and",
					"{C:attention}Edition{} of {C:attention}Joker{} to the left and give",
					"them to the {C:attention}Joker{} to the right",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#1#{{C:inactive,s:0.8} rounds)",
				}
			},	
			j_stall_runerigus = {
				name = 'Runerigus',
				text = {
					"Sell this card to copy {C:pink}Energy{} and",
					"{C:attention}Edition{} of {C:attention}Joker{} to the left and give",
					"them to the {C:attention}Joker{} to the right",
				}
			},			
			--585
			j_stall_deerling = {
				name = 'Deerling',
				text = {
					"{C:attention}Nature:{} {C:inactive}({V:1}#4#{C:inactive})",
					"Gain {C:mult}+#1#{} Mult per {C:attention}consecutive{} played",
					"hand with only scoring {C:attention}Nature{} cards",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#3#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_sawsbuck = {
				name = 'Sawsbuck',
				text = {
					"{C:attention}Nature:{} {C:inactive}({V:1}#3#{C:inactive})",
					"Gain {C:mult}+#1#{} Mult per {C:attention}consecutive{} played",
					"hand with only scoring {C:attention}Nature{} cards",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				}
			},
			--590
			j_stall_foongus = {
				name = 'Foongus',
				text = {
					"{C:attention}Holding {C:item}Black Sludge{}",
					"{C:attention}Toxic{} cards gain {X:mult,C:white}X#1#{} at round start",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#2#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_amoonguss = {
				name = 'Amoonguss',
				text = {
					"{C:attention}Holding {C:item}Black Sludge{}",
					"{C:attention}Toxic{} cards gain {X:mult,C:white}X#1#{} at round start",
				}
			},
			--595
			j_stall_joltik = {
				name = 'Joltik',
				text = {
					"{C:mult}+#1#{} Mult if {C:attention}sum{} of {C:attention}Ranks{}",
					"in scored hand is less than",
					"the {C:attention}sum{} of previous hand: {C:attention}#2#",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_galvantula = {
				name = 'Galvantula',
				text = {
					"{C:mult}+#1#{} Mult if {C:attention}sum{} of {C:attention}Ranks{}",
					"in scored hand is less than",
					"the {C:attention}sum{} of previous hand: {C:attention}#2#",
					"{br:2}ERROR - CONTACT STEAK",
					"{X:mult,C:white}X#3#{} Mult if {C:attention}sum{} is less than ",
					"{C:attention}half{} the {C:attention}sum{} of previous hand",
				}
			},
			--599
			j_stall_klink = {
				name = 'Klink',
				text = {
					"Earn {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_klang = {
				name = 'Klang',
				text = {
					"Earn {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_klinklang = {
				name = 'Klinklang',
				text = {
					"Earn {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{br:2}ERROR - CONTACT STEAK",
					"{X:mult,C:white}X#3#{} if {C:attention}#4#{C:inactive}[#5#]{} cards have ",
					"been drawn this blind",
				}
			},
			--636
			j_stall_larvesta = {
				name = 'Larvesta',
				text = {
					"Discarded cards permanently gain {C:mult}+#1#",
					"Mult on the {C:attention}first discard{} of round",
					"{C:inactive,s:0.8}(Evolve after scoring a card with {C:mult,s:0.8}#2#+{C:inactive,s:0.8} total Mult)",
				}
			},	
			j_stall_volcarona = {
				name = 'Volcarona',
				text = {
					"Played cards give {X:mult,C:white}X#1#{} Mult per",
					"given {C:mult}+Mult{} when scored",
				}
			},				
			--659
			j_stall_bunnelby = {
				name = 'Bunnelby',
				text = {
					"When you draw the last card of a", 
					"{C:attention}Rank{} from your deck, {C:green}#1# in #2#{}",
					"chance to gain a {C:tarot}Tarot{} card",
					"{C:inactive,s:0.8}(Evolve after triggering {C:attention,s:0.8}#3#{C:inactive,s:0.8} times)",
				}
			},
			j_stall_diggersby = {
				name = 'Diggersby',
				text = {
					"When you draw the last card of a ", 
					"{C:attention}Rank{} from your deck, gain {X:mult,C:white}X#4#{} and",
					"{C:green}#1# in #2#{} chance to gain a {C:tarot}Tarot{} card",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive})",
				}
			},
			--690
			j_stall_skrelp = {
				name = 'Skrelp',
				text = {
					"Held {C:attention}7{}s permanently gain {C:chips}+#1#{C:attention} Held Chips",
					"{C:inactive,s:0.8}(Evolves when a Held 7 has {C:chips,s:0.8}+#2# {C:inactive,s:0.8}Held Chips)",
				}
			},
			j_stall_dragalge = {
				name = 'Dragalge',
				text = {
					"Held {C:attention}7{}s permanently gain {C:chips}+#1#{C:attention} Held Chips",
					"{br:2}ERROR - CONTACT STEAK",
					"Held cards that have {C:chips}+#2#{}", 
					"or more {C:attention}Held Chips{} gain {C:attention}Toxic",
				}
			},
			j_stall_mega_dragalge = {
				name = 'Mega Dragalge',
				text = {
					"{C:attention}Leftmost{} card held in hand",
					"permanently gains {C:chips}+#1#{} {C:attention}Held Chips{} ",
					"per card held in hand with",
					"at least {C:chips}#2# {C:attention}Held Chips{}",
				}
			},
			--721
			j_stall_volcanion = {
				name = 'Volcanion',
				text = {
					"Gain {X:mult,C:white}X#2#{} if total {C:chips}chips{} of scoring hand",
					"is greater than previous total: {C:chips}#3#{}",
					"double {X:mult,C:white}X{} Mult then reset self on failure",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})",
				}
			},
			--722
			j_stall_rowlet = {
				name = 'Rowlet',
				text = {
					"{C:attention}+#3#{} hand size",
					"Gain {C:mult}+#2#{} Mult if held hand is a",
					"{C:attention}[#4#]{}, resets each hand",
					"Next target: {C:attention}[#5#]",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#6#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_dartrix = {
				name = 'Dartrix',
				text = {
					"{C:attention}+#3#{} hand size",
					"Gain {C:mult}+#2#{} Mult if held hand is a",
					"{C:attention}[#4#]{}, resets each hand",
					"Next target: {C:attention}[#5#]",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#6#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_decidueye = {
				name = 'Decidueye',
				text = {
					"{C:attention}+#3#{} hand size",
					"Gain {C:mult}+#2#{} Mult if held hand is a",
					"{C:attention}[#4#]{}, resets each hand",
					"Next target: {C:attention}[#5#]",
					"{br:2}ERROR - CONTACT STEAK",
					"Also {C:green}#7# in #8#{} chance to gain a",
					"{C:spectral}Spectral{} card if played {C:attention}poker hand{}",
					"is the previous target: {C:attention}[#6#]",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				}
			},
			j_stall_rowlet_alt = {
				name = 'Rowlet',
				text = {
					"{C:attention}+#2#{} hand size",
					"Earn {C:money}$#1#{} if held hand is a",
					"{C:attention}[#3#]{}, resets each hand",
					"Next target: {C:attention}[#4#]",
					"{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#5#{C:inactive,s:0.8})",
				}
			},
			j_stall_dartrix_alt = {
				name = 'Dartrix',
				text = {
					"{C:attention}+#2#{} hand size",
					"Earn {C:money}$#1#{} if held hand is a",
					"{C:attention}[#3#]{}, resets each hand",
					"Next target: {C:attention}[#4#]",
					"{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#5#{C:inactive,s:0.8})",
				}
			},
			j_stall_decidueye_alt = {
				name = 'Decidueye',
				text = {
					"{C:attention}+#2#{} hand size",
					"Earn {C:money}$#1#{} if held hand is a",
					"{C:attention}[#3#]{}, resets each hand",
					"Next target: {C:attention}[#4#]",
					"{br:2}ERROR - CONTACT STEAK",
					"Also {C:green}#6# in #7#{} chance to gain a",
					"{C:spectral}Spectral{} card if played {C:attention}poker hand{}",
					"is the previous target: {C:attention}[#5#]",
				}
			},
			--725
			j_stall_litten = {
				name = 'Litten',
				text = {
					"{C:red}+#2#{} discard",
					"Earn {C:money}$#1#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_torracat = {
				name = 'Torracat',
				text = {
					"{C:red}+#2#{} discard",
					"Earn {C:money}$#1#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_incineroar = {
				name = 'Incineroar',
				text = {
					"{C:red}+#2#{} discard",
					"Earn {C:money}$#1#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{br:2}ERROR - CONTACT STEAK",
					"Also gain {C:mult}+#4#{} Mult per card",
					"in discarded {C:attention}poker hand{}",
					"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
				}
			},
			j_stall_litten_alt = {
				name = 'Litten',
				text = {
					"{C:red}+#1#{} discard",
					"Gain {C:mult}+#3#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#4#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_torracat_alt = {
				name = 'Torracat',
				text = {
					"{C:red}+#1#{} discard",
					"Gain {C:mult}+#3#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#4#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_incineroar_alt = {
				name = 'Incineroar',
				text = {
					"{C:red}+#2#{} discard",
					"Gain {C:mult}+#4#{} after discarding",
					"your most played {C:attention}poker hand{}",
					"{br:2}ERROR - CONTACT STEAK",
					"Also earn {C:money}$#1#{} per card",
					"in discarded {C:attention}poker hand{}",
					"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
				}
			},
			--728
			j_stall_popplio = {
				name = 'Popplio',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:mult}+#2#{} Mult if {C:attention}poker hand{} is a",
					"{C:attention}[#4#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#5#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_brionne = {
				name = 'Brionne',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:mult}+#2#{} Mult if {C:attention}poker hand{} is a",
					"{C:attention}[#4#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#5#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_primarina = {
				name = 'Primarina',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:mult}+#2#{} Mult if {C:attention}poker hand{} is a",
					"{C:attention}[#6#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{br:2}ERROR - CONTACT STEAK",
					"Also gain {X:mult,C:white}X#5#{} per consecutive",
					"correct hand, resets on round end",
					"{C:inactive}(Currently {X:mult,C:white}X#4#{}, {C:mult}+#1#{C:inactive} Mult)",
				}
			},
			j_stall_popplio_alt = {
				name = 'Popplio',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:chips}+#2#{} Chips if {C:attention}poker hand{} is a",
					"{C:attention}[#4#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
					"{C:inactive,s:0.8}(Evolves at {C:chips,s:0.8}+#5#{C:inactive,s:0.8} Chips)",
				}
			},
			j_stall_brionne_alt = {
				name = 'Brionne',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:chips}+#2#{} Chips if {C:attention}poker hand{} is a",
					"{C:attention}[#4#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
					"{C:inactive,s:0.8}(Evolves at {C:chips,s:0.8}+#5#{C:inactive,s:0.8} Chips)",
				}
			},
			j_stall_primarina_alt = {
				name = 'Primarina',
				text = {
					"{C:chips}+#3#{} hand",
					"Gain {C:chips}+#2#{} Chips if {C:attention}poker hand{} is a",
					"{C:attention}[#6#]{}, {C:attention}poker hand{} changes",
					"after each hand",
					"{br:2}ERROR - CONTACT STEAK",
					"Also gain {X:mult,C:white}X#5#{} per consecutive",
					"correct hand, resets on round end",
					"{C:inactive}(Currently {X:mult,C:white}X#4#{}, {C:chips}+#1#{C:inactive})",
				}
			},
			--734
			j_stall_yungoos = {
				name = 'Yungoos',
				text = {
					"Earn {C:money}$#1#{} after scoring a",
					"{C:attention}#3#{} of {V:1}#4#{}, target",
					"card resets after payout",
					"{C:inactive,s:0.8}(Evolves after earning {C:money,s:0.8}$#2#{C:inactive,s:0.8})",
				}
			},
			j_stall_gumshoos = {
				name = 'Gumshoos',
				text = {
					"Earn {C:money}$#1#{} after scoring a",
					"{V:2}#2#{} of {V:1}#3#{}, target card",
					"resets after payout",  
					"{br:2}ERROR - CONTACT STEAK",
					"Gain a {C:attention}Clue{} {C:item}Item{} and reveal ",
					"target {C:attention}Rank{} or {C:attention}Suit{} once ",
					"it is scored or {C:attention}Foreseen{}",
				}
			},
			--747
			j_stall_mareanie = {
				name = 'Mareanie',
				text = {		
					"{C:purple}+#1# Hazards",
					"First played card gives {X:mult,C:white}X#2#{}",
					"per {C:attention}Hazard{} and {C:attention}Toxic{} card ", 
					"held in hand when scored",
					"{C:inactive,s:0.8}(Evolve after holding {C:attention,s:0.8}#3#{C:inactive,s:0.8} Hazard or Toxic cards)",
				}
			},
			j_stall_toxapex = {
				name = 'Toxapex',
				text = {
					"{C:purple}+#1# Hazards",
					"First played card gives {X:mult,C:white}X#2#{}",
					"per {C:attention}Hazard{} and {C:attention}Toxic{} card ", 
					"held in hand when scored",
				}
			},
			--751
			j_stall_dewpider = {
				name = 'Dewpider',
				text = {
					"If sum of {C:attention}Ranks{} in scored hand", 
					"is within {C:attention}[#1#-#2#]{} earn {C:money}$#3#",
					"and gains {C:mult}+#5#{} Mult, required", 
					"sums change at end of round",
					"{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#6#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_araquanid = {
				name = 'Araquanid',
				text = {
					"If sum of {C:attention}Ranks{} in scored hand", 
					"is within {C:attention}[#1#-#2#]{} earn {C:money}$#3#",
					"and gains {C:mult}+#5#{} Mult, required", 
					"sums change at end of round",
					"{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
				}
			},
			--758
			j_stall_salandit = {
				name = 'Salandit',
				text = {
					"When round begins, add a random",
					"{C:attention}Toxic{} card to your hand",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#1#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_salazzle = {
				name = 'Salazzle',
				text = {
					"{C:attention}Toxic{} cards always score",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:attention}Steel{} cards are drained by {X:mult,C:white}X0.05{}", 
					"when held, all {C:attention}Toxic{} cards",
					"are given drained {X:mult,C:white}X{} Mult",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult drained)",
				}
			},
			--769
			j_stall_sandygast = {
				name = 'Sandygast',
				text = {
					"Gains {C:chips}+#1#{} Chips for each",
					"scored {C:spades}Spade{} card",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
					"{C:inactive,s:0.8}(Evolves at {C:chips,s:0.8}+#3#{C:inactive,s:0.8} Chips)",
				}
			},
			j_stall_palossand = {
				name = 'Palossand',
				text = {
					"Gains {C:chips}+#1#{} Chips for each",
					"scored {C:spades}Spade{} card",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
					"{br:2}ERROR - CONTACT STEAK",
					"Played {C:spades}Spade{} cards permanently gain",
					"{C:mult}+1{} Mult when scored, capped", 
					"by number of {X:water,C:white}Water{} Jokers",
				}
			},
			--782
			j_stall_jangmoo = {
				name = 'Jangmo-o',
				text = {
					"Gain {C:mult}+#2#{} Mult if played Hand is a",
					"{C:attention}Two Pair{} and the difference of {C:attention}Ranks{}",
					"is the same as previous {C:attention}Two Pair: #3#{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#4#{C:inactive,s:0.8} Mult)",
					
				}
			},
			j_stall_hakamoo = {
				name = 'Hakamo-o',
				text = {
					"Gain {C:mult}+#2#{} Mult if played Hand is a",
					"{C:attention}Two Pair{} and the difference of {C:attention}Ranks{}",
					"is the same as previous hand: {C:attention}#3#{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#4#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_kommoo = {
				name = 'Kommo-o',
				text = {
					"Gain {C:mult}+#2#{} Mult if played Hand is a",
					"{C:attention}Two Pair{} and the difference of {C:attention}Ranks{}",
					"is the same as previous hand: {C:attention}#5#{}",
					"{br:2}ERROR - CONTACT STEAK",
					"Gain {X:mult,C:white}X#4#{} if difference is the same",
					"for {C:attention}#6#{} consecutive hands",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{}, {C:mult}+#1#{C:inactive} Mult)",
				}
			},
			--852
			j_stall_clobbopus = {
				name = 'Clobbopus',
				text = {
					"Each {C:clubs}#2#{} held in hand gives {C:chips}+#1#{} chips",
					"{C:inactive,s:0.8}(Evolve after triggering {C:attention,s:0.8}#3#{C:inactive,s:0.8} times)",
				}
			},
			j_stall_grapploct = {
				name = 'Grapploct',
				text = {
					"{X:mult,C:white}X#3#{} Mult",
					"{X:mult,C:white}-X#4#{} per non-{C:clubs}Club{} card held in hand",
					"{br:2}ERROR - CONTACT STEAK",
					"Each {C:clubs}#2#{} held in hand gives {C:chips}+#1#{} chips",
				}
			},
			--953
			j_stall_rellor = {
				name = 'Rellor',      
				text = {
					"{C:mult}+#1#{} Mult per {C:item}Item{} card",
					"used this run",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves after using {C:attention,s:0.8}#3#{C:inactive,s:0.8} Items)",
				}
			},
			j_stall_rabsca = {
				name = 'Rabsca',      
				text = {
					"{C:mult}+#1#{} Mult per {C:item}Item{} and ",
					"{C:tarot}Tarot{} card used this run",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				} 
			},
			--965
			j_stall_varoom = {
				name = 'Varoom',      
				text = {
					"Gain {C:mult}+#1#{} Mult per {C:attention}Reroll{} and scored {C:attention}Stone",
					"card, {C:mult}-1{} Mult per hand played",
					"{C:inactive}(Currently {C:mult}+#2#{{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves at {C:mult,s:0.8}+#3#{C:inactive,s:0.8} Mult)",
				}
			},
			j_stall_revavroom = {
				name = 'Revavroom',      
				text = {
					"Gain {C:mult}+#1#{} Mult per {C:attention}Reroll{} and scored {C:attention}Stone",
					"cards, {C:mult}-2{} Mult per hand played",
					"{br:2}ERROR - CONTACT STEAK",
					"Scored {C:attention}Toxic{} cards retrigger if a",					
					"{C:attention}Stone{} card is in scoring hand",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				} 
			},

		},
			Item = {
				c_stall_blacksludge = {
					name = "Black Sludge",
					text = {
						"{C:enhanced}Enhance{} {C:attention}1{} selected", 
						"card and {C:attention}2{} random cards",
						"in hand with {C:attention}Toxic{}", 
					},
				},
				c_stall_clue = {
					name = "Clue",
					text = {
						"Gain {C:attention}+#1#{} hand size",
						"this round and draw {C:attention}1{} card",
					},
				},
			},
			Enhanced = {
				m_stall_toxic = {
					name = "Toxic Card",
					text = {
						"Gives {X:red,C:white}X#2#{} per {C:purple}Toxic{}",
						"card triggered this",			
						"Blind when triggered",
						"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})",
					}
				},
			},
				
	},
	Other = {
		designed_by = {
		name = "Designed By",
		text = {
			"{C:purple}#1#{}"
		},
		}
	},
	misc = {
		dictionary = {
			stall_regular_pokemon1 = "Regular Pokemon 1/3",
			stall_regular_pokemon2 = "Regular Pokemon 2/3",
			stall_regular_pokemon3 = "Regular Pokemon 3/3",			
			stall_Alolan_starters = "Alolan Starters",
			stall_toxic_pokemon1 = "Toxic Pokemon 1/2",
			stall_toxic_pokemon2 = "Toxic Pokemon 2/2",

		},
	}
}