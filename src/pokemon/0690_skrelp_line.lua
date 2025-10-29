local skrelp = {
	name = "skrelp",
	pos = {x = 28, y = 45},
	config = {extra = { heldChips = 1, highestSev = 0}, evo_rqmt = 7},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.heldChips, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand then
			if G.hand.cards and context.individual then
				if context.other_card:get_id() == 7 then
					context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips or 0
					context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips + card.ability.extra.heldChips
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
	pos = {x = 0, y = 46},
	config = {extra = { heldChips = 2, toxicThreshold = 14}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.heldChips, card.ability.extra.toxicThreshold}}
	end,
	rarity = "poke_safari", --Safari
	cost = 8,
	stage = "One",
	ptype = "Dark",
	gen = 6,
	toxic = true,
	atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand and G.hand.cards and context.individual then
			if context.other_card:get_id() == 7 then
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips or 0
				context.other_card.ability.perma_h_chips = context.other_card.ability.perma_h_chips + card.ability.extra.heldChips
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
}

if stall_config.Skrelp then
  list = {skrelp, dragalge}
else list = {}
end

return {name = "Skrelp Line", 
enabled = stall_config.Skrelp or false,
list = list
}