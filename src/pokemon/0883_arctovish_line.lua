local arctovish = {
	name = "arctovish",
	--pos = {x = 0, y = 0},
	config = {extra = { suit1 = "Clubs", suit2 = "Hearts", Xmult_mod = 0.25, retriggers = 1, heartThreshold = 4, handLevelAmount = 2 }},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra or self.config.extra
		--info_queue[#info_queue+1] = {set = 'Other', key = 'ancientsuits', vars = {abbr.suit1, abbr.suit2, colours = {G.C.SUITS[abbr.suit1], G.C.SUITS[abbr.suit2]}}}	
	  return {vars = {abbr.suit1, abbr.suit2, 1 + abbr.Xmult_mod, abbr.retriggers, abbr.heartThreshold, abbr.handLevelAmount, colours = {G.C.SUITS[abbr.suit1 or "Clubs"], G.C.SUITS[abbr.suit2 or "Hearts"] }}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Water",
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
			
				if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 2 then
					for i, v in ipairs(G.consumeables.cards) do
						if v.ability.set == "Planet" then
							args = {hands = v.ability.hand_type, amount = card.ability.extra.handLevelAmount, card = card}
							SMODS.upgrade_poker_hands(args)
							local sliced_card = v
							G.E_MANAGER:add_event(Event({func = function()
              sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
							return true end }))
							break
						end
					end
				end
				if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 1 then
					if G.hand and G.hand.cards then
						local heartCount = 0
						for i, v in pairs(G.hand.cards) do
							if v:is_suit(card.ability.extra.suit2) then
							heartCount = heartCount + 1
							end
						end
						heartCount = math.floor(heartCount/card.ability.extra.heartThreshold)
						for i = 1, heartCount do
							if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
						end
					end
				end
			end
		end
		
		if context.other_consumeable and context.other_consumeable.ability.set == "Planet" and card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 then
			return {
				xmult = 1 + card.ability.extra.Xmult_mod
			}
		end	
		
		
		if context.repetition and context.cardarea == G.hand and card.ability.extra.ancient_suits[card.ability.extra.suit2] > 2 then
			if (context.other_card == G.hand.cards[1] or context.other_card == G.hand.cards[2]) and (next(context.card_effects[1]) or #context.card_effects > 1) then
				return {
					repetitions = card.ability.extra.retriggers,
					card = card
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

return {name = "Arctovish Line", 
enabled = stall_config.Arctovish or false,
list = {arctovish}
}