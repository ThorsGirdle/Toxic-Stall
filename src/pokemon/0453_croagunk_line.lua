local croagunk = {
	name = "croagunk",
	--pos = {x = 4, y = 30},
	config = {extra = {pokerHand = "None", rounds = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
	  return {vars = {card.ability.extra.pokerHand, card.ability.extra.rounds}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Dark",
	gen = 4,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	--atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.GAME.current_round.hands_played == 0 and context.scoring_name then
				card.ability.extra.pokerHand = context.scoring_name
			elseif G.GAME.current_round.hands_played == 1 and context.scoring_name and context.scoring_name == card.ability.extra.pokerHand then
				local first = context.scoring_hand[1]
					first:set_ability(G.P_CENTERS.m_stall_focused, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
								first:juice_up()
								return true
						end
					})) 
				card.ability.extra.pokerHand = "None"
			elseif G.GAME.current_round.hands_played ~= 0 then
				card.ability.extra.pokerHand = "None"
			end	
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.pokerHand = "None"
		end
	return level_evo(self, card, context, "j_stall_toxicroak")
	end,
}

local toxicroak = {
	name = "toxicroak",
	--pos = {x = 6, y = 30},
	config = {extra = {pokerHand = "None"}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic		
	  return {vars = {card.ability.extra.pokerHand}}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "One",
	ptype = "Dark",
	gen = 4,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	--atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.GAME.current_round.hands_played == 0 and context.scoring_name then
				card.ability.extra.pokerHand = context.scoring_name
			elseif G.GAME.current_round.hands_played == 1 and context.scoring_name and context.scoring_name == card.ability.extra.pokerHand then
				local first = context.scoring_hand[1]
					first:set_ability(G.P_CENTERS.m_stall_focused, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
								first:juice_up()
								return true
						end
					})) 
				card.ability.extra.pokerHand = "None"
			elseif G.GAME.current_round.hands_played ~= 0 then
				card.ability.extra.pokerHand = "None"
			end	
		end
		
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_stall_focused") and context.other_card.ability.extra.jab == true then
			toxic_scaling()
			G.GAME.toxic_triggered = true
			return { x_mult = G.GAME.current_round.toxic.toxicXMult}
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.pokerHand = "None"
		end
	end,
}

return {
	name = "Croagunk Line",
	enabled = stall_config.Croagunk or false,
	list = {croagunk, toxicroak}
}