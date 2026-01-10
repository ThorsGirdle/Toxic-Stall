local mareanie = {
	name = "mareanie",
	--pos = {x = 22, y = 49},
	config = {extra = {hazard_level = 1, Xmult = 0.30, heldTH = 0}, evo_rqmt = 20},	
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
		info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {abbr.hazard_level, abbr.Xmult, self.config.evo_rqmt - abbr.heldTH}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	hazard_poke = true,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then 
		if G.hand and  G.hand.cards then
			local heldTargets = 0
			local totalMult = 1
			for i=1, #G.hand.cards do
				if SMODS.has_enhancement(G.hand.cards[i], "m_stall_toxic") or SMODS.has_enhancement(G.hand.cards[i], "m_poke_hazard") then
					heldTargets = heldTargets + 1
					card.ability.extra.heldTH = card.ability.extra.heldTH + 1
				end
			end
			totalMult = 1 + (card.ability.extra.Xmult * heldTargets)
			return {
				xmult = totalMult
			}
			end
	end
	return scaling_evo(self, card, context, "j_stall_toxapex", card.ability.extra.heldTH, self.config.evo_rqmt)
end,
add_to_deck = function(self, card, from_debuff)
	poke_change_hazard_level(card.ability.extra.hazard_level)
end,
remove_from_deck = function(self, card, from_debuff)
	poke_change_hazard_level(-card.ability.extra.hazard_level)
end
}

local toxapex = {
	name = "toxapex",
	--pos = {x = 24, y = 49},
	config = {extra = {hazard_level = 1, Xmult = 0.40}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = {set = 'Other', key = 'hazard_level', vars = poke_get_hazard_level_vars()}
		info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {abbr.hazard_level, abbr.Xmult}}
	end,
	rarity = "poke_safari", --Safari
	cost = 8,
	stage = "One",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	hazard_poke = true,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then 
		if G.hand and  G.hand.cards then
			local heldTargets = 0
			local totalMult = 1
			for i=1, #G.hand.cards do
				if SMODS.has_enhancement(G.hand.cards[i], "m_stall_toxic") or SMODS.has_enhancement(G.hand.cards[i], "m_poke_hazard") then
					heldTargets = heldTargets + 1
				end
			end
			totalMult = 1 + (card.ability.extra.Xmult * heldTargets)
			if G.GAME.round_resets.hazard_level and G.GAME.round_resets.hazard_level > 1 then
				toxic_scaling()
				G.GAME.toxic_triggered = true
				SMODS.calculate_effect({x_mult = G.GAME.current_round.toxic.toxicXMult}, context.other_card)	
			end
			return {
				xmult = totalMult,
			}
			end
	end
end,
add_to_deck = function(self, card, from_debuff)
	poke_change_hazard_level(card.ability.extra.hazard_level)
end,
remove_from_deck = function(self, card, from_debuff)
	poke_change_hazard_level(-card.ability.extra.hazard_level)
end
}

return {
name = "Mareanie Line", 
enabled = stall_config.Mareanie or false,
list = {mareanie, toxapex}
}