return {
	descriptions = {
		Joker = {
			--194
			j_stall_paldean_wooper = {
				name = '{s:0.6}Paldean{}Wooper',
				text = {
					"Gain {C:money}$#1#{} when a {C:attention}face{} card is destroyed",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#2#{C:inactive,s:0.8})",
				}
			},
			j_stall_clodsire = {
				name = 'Clodsire',
				text = {
					"Gain {C:money}$#1#{} and enhance a random card in hand",
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
			--543
			j_stall_venipede = {
				name = 'Venipede',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}enhance{} first",
					"scoring card with {C:attention}Toxic{}, increase",
					"odds per played hand",
					"{C:inactive,s:0.8}(Evolves after {C:attention,s:0.8}#3#{C:inactive,s:0.8} rounds)",
				}
			},
			j_stall_whirlipede = {
				name = 'Whirlipede',
				text = {
					"{C:green}#1# in #2#{} chance to {C:attention}enhance{} first",
					"scoring card with {C:attention}Toxic{}, increase",
					"odds per played hand",
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
					"scoring card with {C:attention}Toxic{}, increase",
					"odds per played hand",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:attention}Retrigger{} first scoring card {C:attention}1{} additional ",
					"time per {X:mult,C:white}X#4#{} extra {C:attention}Toxic{} Mult",
					"{C:inactive,s:0.8} (Max 5 retriggers)"
				}
			},
			
			--590
			j_stall_foongus = {
				name = 'Foongus',
				text = {
					"{C:attention}Holding {C:item}Black Sludge{}",
					"{C:attention}Toxic{} cards gain {X:mult,C:white}X#1#{} at round start",
					"{C:inactive,s:0.8}(Evolves after #2# rounds)",
				}
			},
			j_stall_amoonguss = {
				name = 'Amoonguss',
				text = {
					"{C:attention}Holding {C:item}Black Sludge{}",
					"{C:attention}Toxic{} cards gain {X:mult,C:white}X#1#{} at round start",
				}
			},
			--599
			j_stall_klink = {
				name = 'Klink',
				text = {
					"Gain {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_klang = {
				name = 'Klang',
				text = {
					"Gain {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{C:inactive,s:0.8}(Evolve after giving {C:money,s:0.8}$#3#{C:inactive,s:0.8})",
				}
			},
			j_stall_klinklang = {
				name = 'Klinklang',
				text = {
					"Gain {C:money}$#1#{} after drawing {C:attention}#2#", 
					"cards in a blind",
					"{br:2}ERROR - CONTACT STEAK",
					"{X:mult,C:white}X#3#{} if {C:attention}#4#{C:inactive}[#5#]{} cards have ",
					"been drawn this blind",
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
					"Held cards that have {C:attention}+#2#{}", 
					"or more {C:attention}Held Chips{} gain {C:attention}Toxic",
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
					"{C:inactive,s:0.8}(Evolves after #1# rounds)",
				}
			},
			j_stall_salazzle = {
				name = 'Salazzle',
				text = {
					"{C:attention}Toxic{} cards always score",
					"{br:2}ERROR - CONTACT STEAK",
					"{C:attention}Steel{} cards are drained {X:mult,C:white}X0.05", 
					"to all {C:attention}Toxic{} cards when held",
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
			--953
			j_stall_rellor = {
				name = 'Rellor',      
				text = {
					"{C:mult}+#1#{} per {C:item}Item{} card",
					"used this run",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					"{C:inactive,s:0.8}(Evolves after using {C:attention,s:0.8}+#3#{C:inactive,s:0.8} Items)",
				}
			},
			j_stall_rabsca = {
				name = 'Rabsca',      
				text = {
					"{C:mult}+#1#{} per {C:item}Item{} and ",
					"{C:tarot}Tarot{} card used this run",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				} 
			},
			--965
			j_stall_varoom = {
				name = 'Varoom',      
				text = {
					"The next {C:inactive}[#1#]{} scored card(s) retrigger,", 
					"gain {C:attention}2{} for each {C:attention}Reroll{} used",
					"{C:inactive,s0.8}(Max 20 cards, resets to 2 at end of ante)",
					"{C:inactive,s0.8}(Evolve after rerolling {C:attention,s0.8}#2#{C:inactive,s0.8} times)",
				}
			},
			j_stall_revavroom = {
				name = 'Revavroom',      
				text = {
					"The next {C:inactive}[#1#]{} scored card(s) retrigger,", 
					"gain {C:attention}3{} for each {C:attention}Reroll{} used",
					"{br:2}ERROR - CONTACT STEAK",
					"Scored {C:attention}Stone{} and {C:attention}Toxic{} cards do not", 
					"reduce number of stored retriggers",
					"{C:inactive,s0.8}(Max 30 cards, resets to 3 at end of ante)",
				} 
			},
		},
			Item = {
				c_stall_blacksludge = {
					name = "Black Sludge",
					text = {
						"{C:enhanced}Enhance{} {C:attention}1{} selected card and", 
						"{C:attention}2{} random cards in hand with {C:attention}Toxic{}",
					},
				},
			},
			Enhanced = {
				m_stall_toxic = {
					name = "Toxic Card",
					text = {
						"{C:enhanced}Enhanced{} card gives {X:red,C:white}X#2#{}",
						"per {C:purple}Toxic{} card triggered",			
						"this Blind when scored",
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
			stall_regular_pokemon1 = "Regular Pokemon",
			stall_toxic_pokemon1 = "Toxic Pokemon 1/2",
			stall_toxic_pokemon2 = "Toxic Pokemon 2/2",

		},
	}
}