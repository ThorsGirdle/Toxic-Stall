local zeal = {
	name = "zeal",
	key = "zeal",
	badge_colour = HEX("24BD7A"), --green placeholder
	atlas = "PlaceholderStallSeals",
  pos = {x = 0, y = 0},
	weight = 0.5,
  config = {cardType = '', typeVars = {}, bonusXChips = 2, wildXMult = 0.25, glassXMult = 2, 
		steelXMult = 1.2, steelMoneyXMult = 0.05, steelMoney = 1, goldHold = 3, goldTurns = 0, luckyOdds = 1, luckyScoring = false,
		hazardScoring = false, hazardRepetitions = 1, seedMoolah = 1, flowerXMult = 0.5,
		toxicScaling = 0.02, toxicScoring = false, focusedMult = 1, focusedChips = 5, baseChips = 5, baseMult = 1, baseXMult = 0.05,
		scaleMax = 1, scaleNum = 1, scaleDem = 6,},
	loc_vars = function(self, info_queue, center)
		if center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_bonus" then
			info_queue[#info_queue+1] = {set = 'Other', key = "waterium_zeal", vars = {center.ability.seal.bonusXChips}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_mult" then
			info_queue[#info_queue+1] = {set = 'Other', key = "firium_zeal", vars = {}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_wild" then
			info_queue[#info_queue+1] = {set = 'Other', key = "buginium_zeal", vars = {center.ability.seal.wildXMult}}		
			info_queue[#info_queue+1] = {set = 'Other', key = 'pickup'}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_glass" then
			info_queue[#info_queue+1] = {set = 'Other', key = "icium_zeal", vars = {center.ability.seal.glassXMult}}			
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_steel" then
			info_queue[#info_queue+1] = {set = 'Other', key = "steelium_zeal", vars = {(center.ability.seal.steelXMult + (center.ability.seal.steelMoneyXMult * (G.GAME.current_round.amount_gained or 0))),
			center.ability.seal.steelMoneyXMult, center.ability.seal.steelMoney}}			
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_stone" then
			info_queue[#info_queue+1] = {set = 'Other', key = "rockium_zeal", vars = {}}			
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_gold" then
			info_queue[#info_queue+1] = {set = 'Other', key = "electrium_zeal", vars = {center.ability.seal.goldHold, (center.ability.seal.goldHold * (1 + center.ability.seal.goldTurns))}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_lucky" then
			info_queue[#info_queue+1] = {set = 'Other', key = "psychium_zeal", vars = {center.ability.seal.luckyOdds}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_poke_hazard" then
			info_queue[#info_queue+1] = {set = 'Other', key = "groundium_zeal", vars = {center.ability.seal.hazardRepetitions}}			
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_poke_seed" then
			info_queue[#info_queue+1] = {set = 'Other', key = "grassium_zeal", vars = {center.ability.seal.seedMoolah}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_poke_flower" then
			info_queue[#info_queue+1] = {set = 'Other', key = "fairium_zeal", vars = {center.ability.seal.flowerXMult}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_stall_toxic" then
			info_queue[#info_queue+1] = {set = 'Other', key = "poisonium_zeal", vars = {center.ability.seal.toxicScaling}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_stall_focused" then
			info_queue[#info_queue+1] = {set = 'Other', key = "fightinium_zeal", vars = {center.ability.seal.focusedMult, center.ability.seal.focusedChips}}
		elseif center and center.config and center.config.center and center.config.center.key and center.config.center.key == "m_stall_scale" then
			local num, dem = SMODS.get_probability_vars(center, center.ability.seal.scaleNum, center.ability.seal.scaleDem, 'dragonium')
			local highlight_colour = center.ability.extra.currentType ~= "Lightning" and G.C.WHITE or G.C.BLACK
			info_queue[#info_queue+1] = {set = 'Other', key = "dragonium_zeal", vars = {center.ability.extra.currentType, num, dem, colours = {pokermon.colours[string.lower(center.ability.extra.currentType)], highlight_colour}}}
		elseif center and center.config and center.config.center then
			info_queue[#info_queue+1] = {set = 'Other', key = "normalium_zeal", vars = {center.ability.seal.baseChips, center.ability.seal.baseMult, center.ability.seal.baseXMult}}			
		end

    return { vars = { } }
	end,
	
	unlocked = true,
	discovered = true,
	no_collection = false,
	
	calculate = function(self, card, context)

		if card.config.center.key == "m_bonus" then
			if context.main_scoring and context.cardarea == G.play then
					card.ability.xchips = 2
				return {
					x_chips = card.ability.seal.bonusXChips
				}
			end

		elseif card.config.center.key == "m_mult" then		
			if context.main_scoring and context.cardarea == G.play then
				local pokerHand = G.FUNCS.get_poker_hand_info(context.full_hand)
				return {mult = G.GAME.hands[pokerHand].mult}
			end
			
		elseif card.config.center.key == "m_wild" then
			if context.main_scoring and context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				return {
					extra = {focus = card, message = localize('poke_plus_pokeitem'), colour = pokermon.colours.pink, func = function()
						G.E_MANAGER:add_event(Event({
							trigger = 'before',
							delay = 0.0,
							func = function()
								local card_type = 'poke_item'
								local _card = create_card(card_type,G.consumeables, nil, nil, nil, nil, pokermon.generate_pickup_item_key('buginium'))
								_card:add_to_deck()
								G.consumeables:emplace(_card)
								G.GAME.consumeable_buffer = 0
								return true
							end
						}))
					end}
				}
			end
			
		elseif card.config.center.key == "m_glass" then
			if context.mod_probability and context.trigger_obj == card and context.identifier == "glass" then
				return {
					denominator = context.denominator * 3
				}
			end
			
			if context.main_scoring and context.cardarea == G.play then
				return {
					x_mult = card.ability.seal.glassXMult
				}
			end
			
			if context.remove_playing_cards then
				for _, removed_card in ipairs(context.removed) do
					if removed_card == card and removed_card.shattered then 
						if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							G.E_MANAGER:add_event(Event({
								func = (function()
										SMODS.add_card {
												set = 'spectral',
												key = "c_aura"
												
										}
										G.GAME.consumeable_buffer = 0
										return true
								end)
							}))		
						end
						break
					end
				end
			end
			
		elseif card.config.center.key == "m_steel" then
			if context.main_scoring and context.cardarea == G.hand then
				return {
					x_mult = card.ability.seal.steelXMult + (card.ability.seal.steelMoneyXMult * (G.GAME.current_round.amount_gained or 0))
				}
			end
			
			

		elseif card.config.center.key == "m_stone" then		
			if context.after and G.GAME.current_round.rockium_selection and G.GAME.current_round.rockium_selection > 0 then
				rockium_hand_limit(-1)
			end
		
		elseif card.config.center.key == "m_gold" then
			if context.hand_drawn and SMODS.drawn_cards then
				for i, drawnCard in ipairs(SMODS.drawn_cards) do
					if drawnCard == card then
						card.ability.seal.goldTurns = 0
						break
					end
				end
			end 

			if context.before and G.hand then
				for _, v in ipairs(G.hand.cards) do
					if v == card then
						 card.ability.seal.goldTurns = card.ability.seal.goldTurns + 1
						break
					end
				end
			end
				
			if context.playing_card_end_of_round and context.cardarea == G.hand and not context.game_over then
				local turns = card.ability.seal.goldTurns
				card.ability.goldTurns = 0
				if turns > 0 then
					return {
						dollars = card.ability.seal.goldHold * turns
					}
				end
			end
		
		elseif card.config.center.key == "m_lucky" then
			if context.before then
				for _, v in ipairs(context.scoring_hand) do
					if v == card then
						card.ability.seal.luckyScoring = true
						break
					end
				end
			end
			if card.ability.seal.luckyScoring == true and context.mod_probability then
				 return {
					numerator = context.numerator + card.ability.seal.luckyOdds
				 }
			end
			if context.after then
				card.ability.seal.luckyScoring = false
			end
			
		elseif card.config.center.key == "m_poke_hazard" then
			if context.fix_probability and context.identifier == "hazard" and context.trigger_obj == card then
				return {
					numerator = 0
				}
			end
		
		elseif card.config.center.key == "m_poke_seed" then

			if context.main_scoring and context.cardarea == G.play then
				if card.ability.extra.level >= 4 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
								SMODS.add_card {
										set = 'Planet',
								}
								G.GAME.consumeable_buffer = 0
								return true
						end)
					}))		
				end
				return {
					dollars =  card.ability.extra.level * card.ability.seal.seedMoolah
				}
			end
				
		elseif card.config.center.key == "m_poke_flower" then
			if context.main_scoring and context.cardarea == G.play then		
				local rank, count = {}, 0
				for i = 1, #context.scoring_hand do
					local c = context.scoring_hand[i]
					if not SMODS.has_no_rank(c) and not rank[c:get_id()] then
						rank[c:get_id()] = true
						count = count + 1
					end
				end
				if count >= 1 then
					return {
						x_mult = 1 + (card.ability.seal.flowerXMult * count)
					}
				end
			end	
		
		elseif card.config.center.key == "m_stall_toxic" then
			if context.before then
				for _, v in ipairs(context.scoring_hand) do
					if v == card then
						card.ability.seal.toxicScoring = true
						G.GAME.toxic_triggered = true
						G.GAME.current_round.toxic.toxicMult_mod = G.GAME.current_round.toxic.toxicMult_mod + card.ability.seal.toxicScaling
						break
					end
				end
			end

			if context.after and card.ability.seal.toxicScoring == true then
				card.ability.seal.toxicScoring = false
				G.GAME.current_round.toxic.toxicMult_mod = G.GAME.current_round.toxic.toxicMult_mod - card.ability.seal.toxicScaling
			end
			
		elseif card.config.center.key == "m_poke_hazard" then
			if context.fix_probability and context.identifier == "hazard" and context.trigger_obj == card then
				return {
					numerator = 0
				}
			end
			if context.main_scoring and context.cardarea == G.play then			
				G.GAME.toxic_triggered = true
				G.GAME.current_round.toxic.toxicMult_mod = G.GAME.current_round.toxic.toxicMult_mod + card.ability.seal.toxicScaling
			end
		
		elseif card.config.center.key == "m_stall_focused" then

			if context.main_scoring and context.cardarea == G.play and card.ability.extra.combo == true then			
				card.ability.perma_mult = card.ability.perma_mult + card.ability.seal.focusedMult
				card.ability.perma_bonus = card.ability.perma_bonus + card.ability.seal.focusedChips
			end
		
		elseif card.config.center.key == "m_stall_scale" then
			if context.pre_discard then
				local sendit = false
				for i,v in ipairs(context.full_hand) do
					if v == card then
						sendit = true
						break
					end
				end
				if sendit then
					local eligible = {}
					for i,v in ipairs(pokermon.find_pokemon_type(card.ability.extra.currentType)) do
						if pokermon.energy.is_energizable(v) and not pokermon.energy.can_increase_energy(v) then
							eligible[#eligible +1] = v
						end
					end
					if #eligible >= 1 then
						pseudoshuffle(eligible, pseudoseed('dragonium'))
						eligible[1].ability.extra.e_limit_up = (eligible[1].ability.extra.e_limit_up or 0) + 1
						return {
							message = localize('k_upgrade_ex'), 
							colour = G.C.ATTENTION,
							card = eligible[1]
						}			
					end
				end
			end
			
		else 
			if (context.change_rank or context.change_suit) and context.other_card == card then
				local random = pseudorandom('Normalium Zeal')
				if random < (1/3) then
					card.ability.perma_bonus = card.ability.perma_bonus + card.ability.seal.baseChips
				elseif random < (2/3) then
					card.ability.perma_mult = card.ability.perma_mult + card.ability.seal.baseMult
				else
					card.ability.perma_x_mult = card.ability.perma_x_mult + card.ability.seal.baseXMult
				end
				return {
					message = localize('k_upgrade_ex'), 
					colour = G.C.ATTENTION
				}			
			end
		end
	end,
	
	in_pool = function(self)
		return true
  end
}

return {
	name = "Seals",
	list = {zeal,}
}