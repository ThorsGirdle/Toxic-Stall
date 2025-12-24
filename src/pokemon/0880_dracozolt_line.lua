local dracozolt = {
	name = "dracozolt",
	--pos = {x = 0, y = 0},
	config = {extra = { suit1 = "Diamonds", suit2 = "Spades", Xmult_mod = 0.75, chip_mod = 2, money = 1, handsPlayed = 0}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra or self.config.extra
		--info_queue[#info_queue+1] = {set = 'Other', key = 'ancientsuits', vars = {localize(abbr.suit1, 'suits'), localize(abbr.suit2, 'suits'), colours = {G.C.SUITS[abbr.suit1],  G.C.SUITS[abbr.suit2]}}}	
	  return {vars = {abbr.suit1, abbr.suit2, abbr.Xmult_mod, abbr.chip_mod, abbr.money, colours = {G.C.SUITS[abbr.suit1 or "Diamonds"], G.C.SUITS[abbr.suit2 or "Spades"] }}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Lightning",
	gen = 8,
	designer = "Thor's Girdle",
	--custom_art = true,
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.scoring_hand then
			if context.before then
				get_ancient_suit_amount(context.scoring_hand, card.ability.extra.suit1, card.ability.extra.suit2, card)
				card.ability.extra.handsPlayed = card.ability.extra.handsPlayed + 1

				if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 2 then
					for _, v in pairs(context.scoring_hand) do
						if v:is_suit(card.ability.extra.suit2, true) then
							G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,
							func = (function()
								v:set_ability(G.P_CENTERS.m_gold)
									return {
										extra = { message = localize('k_upgrade_ex'), colour = G.C.YELLOW },
										card = card
									}
							end) 
							}))
							break
						end
					end
				end
				if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 1 then
					local earned = ease_poke_dollars(card, "dracozolt", card.ability.extra.money * card.ability.extra.handsPlayed)
					return {
							message = '$'..earned,
							colour = G.C.MONEY
					}
				end
			end
			if context.joker_main then
				if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 then
					local goldCount = 0
					for _, v in ipairs(context.scoring_hand) do
						if SMODS.has_enhancement(v, 'm_gold') then
							goldCount = goldCount + 1
						end
					end
					if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 2 then
						return {
							xmult = 1 + (goldCount * card.ability.extra.Xmult_mod),
							chips = card.ability.extra.chip_mod * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0))),
						}
					elseif card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 then
						return {
							xmult = 1 + (goldCount * card.ability.extra.Xmult_mod),
						}
					end
				end
			end
		end
		
		if context.after then
			card.ability.extra.ancient_suits[card.ability.extra.suit1] = 0
			card.ability.extra.ancient_suits[card.ability.extra.suit2] = 0
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.handsPlayed = 0
		end
  end,
	generate_ui = fossil_generate_ui,
}

return {name = "Dracozolt Line", 
enabled = stall_config.Dracozolt or false,
list = {dracozolt}
}
