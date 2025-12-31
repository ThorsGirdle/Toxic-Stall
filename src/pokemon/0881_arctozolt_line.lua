local arctozolt = {
	name = "arctozolt",
	--pos = {x = 0, y = 0},
	config = {extra = { suit1 = "Diamonds", suit2 = "Hearts", Xmult_mod = 0.5, Xmult_multi = 1.20, chip_mod = 3, chipThreshold = 40}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra or self.config.extra
		--info_queue[#info_queue+1] = {set = 'Other', key = 'ancientsuits', vars = {localize(abbr.suit1, 'suits'), localize(abbr.suit2, 'suits'), colours = {G.C.SUITS[abbr.suit1],  G.C.SUITS[abbr.suit2]}}}	
	  return {vars = {abbr.suit1, abbr.suit2, 1 + abbr.Xmult_mod, abbr.Xmult_multi, abbr.chip_mod, abbr.chipThreshold, colours = {G.C.SUITS[abbr.suit1 or "Diamonds"], G.C.SUITS[abbr.suit2 or "Hearts"] }}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Lightning",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.scoring_hand then
			if context.before then
				get_ancient_suit_amount(context.scoring_hand, card.ability.extra.suit1, card.ability.extra.suit2, card)
			end
		end
		if context.individual and context.cardarea == G.play then
			if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 2 then
				local totalChips = poke_total_chips(context.other_card)
				if context.other_card:is_suit(card.ability.extra.suit1) and totalChips >= card.ability.extra.chipThreshold then
					return{
						chips = totalChips,
						xmult = 1 + card.ability.extra.Xmult_mod,
					}
				elseif totalChips >= card.ability.extra.chipThreshold then
					return{
						xmult = 1 + card.ability.extra.Xmult_mod,
					}
				elseif context.other_card:is_suit(card.ability.extra.suit1) then
					return{
						chips = totalChips,
					}
				end
			elseif card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 and context.other_card:is_suit(card.ability.extra.suit1) then
					return{
						chips = totalChips,
					}
			end
		end
		
		if context.individual and context.cardarea == G.hand then
			if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 1 then
				if context.other_card.config.center == G.P_CENTERS.c_base then
					context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chip_mod
					G.E_MANAGER:add_event(Event({
									func = (function()
									return {
										message = localize('k_upgrade_ex'),
										colour = G.C.CHIPS
									}
									end)
							}))		
				end
				-- I'll figure out how to get that event to work later, this is the bandaid fix
				if card.ability.extra.ancient_suits[card.ability.extra.suit2] <= 2 then
					return {
						message = localize('k_upgrade_ex'),
						colour = G.C.CHIPS
					}
				end
			end 
			if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 2 and context.other_card:is_suit(card.ability.extra.suit2) then
				return{
					xmult = card.ability.extra.Xmult_multi,
				}
			end
		end
		
		if context.after then
			card.ability.extra.ancient_suits[card.ability.extra.suit1] = 0
			card.ability.extra.ancient_suits[card.ability.extra.suit2] = 0
		end
		

  end,
	generate_ui = fossil_generate_ui,
}

return {name = "Arctozolt Line", 
enabled = stall_config.Arctozolt or false,
list = {arctozolt}
}
