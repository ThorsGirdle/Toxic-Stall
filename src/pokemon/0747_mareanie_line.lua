local mareanie = {
	name = "mareanie",
	pos = {x = 22, y = 49},
	config = {extra = {hazards = 4, Xmult = 0.35, heldTH = 0}, evo_rqmt = 25},	
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {abbr.hazards}}
		info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {abbr.hazards, abbr.Xmult, self.config.evo_rqmt - abbr.heldTH}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	hazard_poke = true,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
calculate = function(self, card, context)
	if context.setting_blind then
		poke_set_hazards(card.ability.extra.hazards)
  end
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
}

local toxapex = {
	name = "toxapex",
	pos = {x = 24, y = 49},
	config = {extra = {hazards = 4, Xmult = 0.45}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = {set = 'Other', key = 'poke_hazards', vars = {abbr.hazards}}
		info_queue[#info_queue+1] = G.P_CENTERS.m_poke_hazard
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {abbr.hazards, abbr.Xmult}}
	end,
	rarity = "poke_safari", --Safari
	cost = 8,
	stage = "One",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	hazard_poke = true,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
calculate = function(self, card, context)
	if context.setting_blind then
		poke_set_hazards(card.ability.extra.hazards)
  end
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
					return {
							xmult = totalMult
					}
			end
	end
end,
}

if stall_config.Mareanie then
  list = {mareanie, toxapex}
else list = {}
end

return {
name = "Mareanie Line", 
enabled = stall_config.Mareanie or false,
list = list
}