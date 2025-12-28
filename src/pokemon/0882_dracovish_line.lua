local dracovish = {
	name = "dracovish",
	--pos = {x = 0, y = 0},
	config = {extra = { suit1 = "Clubs", suit2 = "Spades", chip_mod = 12, mult = 9, money = 3, moneyEarned = 0, consumableHeld = 0, consumableUsed = 0, tarotUsed = 0, moneyThreshold = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra or self.config.extra
		--info_queue[#info_queue+1] = {set = 'Other', key = 'ancientsuits', vars = {localize(abbr.suit1, 'suits'), localize(abbr.suit2, 'suits'), colours = {G.C.SUITS[abbr.suit1],  G.C.SUITS[abbr.suit2]}}}	
	  return {vars = {abbr.suit1, abbr.suit2, abbr.chip_mod, abbr.money, abbr.mult, abbr.moneyThreshold, colours = {G.C.SUITS[abbr.suit1 or "Clubs"], G.C.SUITS[abbr.suit2 or "Spades"] }}}
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

				if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 2 and card.ability.extra.moneyEarned >= card.ability.extra.moneyThreshold then
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						 G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							G.E_MANAGER:add_event(Event({
									func = (function()
											SMODS.add_card {
													set = 'Tarot',
											}
											G.GAME.consumeable_buffer = 0
											return true
									end)
							}))		
					end
				end
				if card.ability.extra.ancient_suits[card.ability.extra.suit2] > 2 then
					local earned = ease_poke_dollars(card, "dracovish", card.ability.extra.money * card.ability.extra.tarotUsed)
					return {
							message = '$'..earned,
							colour = G.C.MONEY
					}
				end
			end
			
			if context.joker_main then
				if card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 and card.ability.extra.ancient_suits[card.ability.extra.suit2] > 1 then
					return {
						mult = card.ability.extra.mult * card.ability.extra.consumableUsed,
						chips = card.ability.extra.chip_mod * card.ability.extra.consumableHeld,
					}
				elseif card.ability.extra.ancient_suits[card.ability.extra.suit1] > 1 then
					return {
						chips = card.ability.extra.chip_mod * card.ability.extra.consumableHeld,
					}
				elseif card.ability.extra.ancient_suits[card.ability.extra.suit2] > 1 then
					return {
						mult = card.ability.extra.mult * card.ability.extra.consumableUsed,
					}
				end
			end
			
		end
		
		if context.other_consumeable and not context.blueprint then
			card.ability.extra.consumableHeld = card.ability.extra.consumableHeld + 1
		end
		
		if context.using_consumeable and not context.blueprint then
			card.ability.extra.consumableUsed = card.ability.extra.consumableUsed + 1
			if context.consumeable.ability.set == "Tarot" then
				card.ability.extra.tarotUsed = card.ability.extra.tarotUsed + 1
			end
		end
		
		if context.money_altered and not context.blueprint then
			local amount_gained = context.amount
			if (SMODS.Mods["Talisman"] or {}).can_load then amount_gained = to_number(amount_gained) end
      if amount_gained and amount_gained > 0 then
				card.ability.extra.moneyEarned = card.ability.extra.moneyEarned + amount_gained
			end
		end
		
		if context.after then
			card.ability.extra.ancient_suits[card.ability.extra.suit1] = 0
			card.ability.extra.ancient_suits[card.ability.extra.suit2] = 0
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.moneyEarned = 0
			card.ability.extra.consumableHeld = 0
			card.ability.extra.consumableUsed = 0
			card.ability.extra.tarotUsed = 0
		end
  end,
	generate_ui = fossil_generate_ui,
}

return {name = "Dracovish Line", 
enabled = stall_config.Dracovish or false,
list = {dracovish}
}