local skrelp = {
	name = "skrelp",
	--pos = {x = 28, y = 45},
	config = {extra = { chip_mod = 1, highestSev = 0}, evo_rqmt = 7},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.chip_mod, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	--atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand then
			if G.hand.cards and context.individual then
				if context.other_card:get_id() == 7 then
					context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips or 0
					context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips + card.ability.extra.chip_mod
					if card.ability.extra.highestSev < context.other_card.ability.perma_h_chips then
						card.ability.extra.highestSev = context.other_card.ability.perma_h_chips
					end
					return {
						extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
						card = card
					}
				end
			end
		end
	return scaling_evo(self, card, context, "j_stall_dragalge", card.ability.extra.highestSev, self.config.evo_rqmt)
	end,
}

local dragalge = {
	name = "dragalge",
	--pos = {x = 0, y = 46},
	config = {extra = { chip_mod = 2, toxicThreshold = 14}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.chip_mod, card.ability.extra.toxicThreshold}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Dark",
	gen = 6,
	toxic = true,
	--atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand and G.hand.cards and context.individual then
			if context.other_card:get_id() == 7 then
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips or 0
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips + card.ability.extra.chip_mod
			end
			if context.other_card.ability.perma_h_chips and context.other_card.ability.perma_h_chips >= card.ability.extra.toxicThreshold then
				toUpgrade = context.other_card
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() toUpgrade:set_ability(G.P_CENTERS.m_stall_toxic);return true end }))
				return {
					extra = { message = localize('k_upgrade_ex'), colour = G.C.PURPLE },
					card = card
				}
			end
			if context.other_card:get_id() == 7 then
				return {
					extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
					card = card
				}
			end
		end
	end,
	megas = { "mega_dragalge" },
}

local mega_dragalge = {
	name = "mega_dragalge",
	pos = {x = 0, y = 0},
	soul_pos = {x = 1, y = 0},
	config = {extra = { chip_mod = 3, toxicThreshold = 15}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chip_mod, card.ability.extra.toxicThreshold}}
	end,
	rarity = "poke_mega", 
	cost = 12,
	stage = "Mega",
	ptype = "Dark",
	gen = 6,
	toxic = true,
	atlas = "StallJokers",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand and G.hand.cards and context.individual then
			if context.other_card == G.hand.cards[1] then
				local thresholdCount = 0
				for _, v in pairs(G.hand.cards) do
					if v.ability.perma_h_chips and v.ability.perma_h_chips >= card.ability.extra.toxicThreshold then
						thresholdCount = thresholdCount + 1
					end
				end
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips or 0
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips + (card.ability.extra.chip_mod * thresholdCount)
				if thresholdCount > 0 then
					return {
						extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
						card = card
					}
				end
			end
		end
	end,
}

return {name = "Skrelp Line", 
enabled = stall_config.Skrelp or false,
list = {skrelp, dragalge, mega_dragalge}
}