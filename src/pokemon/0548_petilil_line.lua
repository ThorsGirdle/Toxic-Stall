local petilil = {
	name = "petilil",
	pos = {x = 0, y = 0},
	config = {extra = {mult_mod = 5, suit = 'Clubs'}},
	loc_vars = function(self, info_queue, card)
		if pokermon_config.detailed_tooltips then
			info_queue[#info_queue+1] = G.P_CENTERS.c_poke_sunstone
		end
		local abbr = card.ability.extra
	  return {vars = { abbr.mult_mod, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = 2, --Uncommon
	cost = 7,
	stage = "Basic",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	item_req = "sunstone",
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
			local trigger = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and (values.played or 0) > play_more_than and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				return {
					mult = card.ability.extra.mult_mod
				}
			end
		end
		return pokermon.type_evo (self, card, context, "j_stall_hisuian_lilligant", "fighting")
        or pokermon.item_evo(self, card, context, "j_stall_lilligant")
	end,
}

local lilligant = {
	name = "lilligant",
	pos = {x = 0, y = 0},
	config = {extra = {Xmult_mod = 0.01, suit = 'Clubs'}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.Xmult_mod, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural'), card.ability.extra.rounds}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 1) 
			return {
				Xmult = 1 + (card.ability.extra.Xmult_mod * play_more_than)
			}
		end
	end,
}

local hisuian_lilligant = {
	name = "hisuian_lilligant",
	pos = {x = 10, y = 8},
	config = {extra = {repetitions = 1, suit = 'Clubs'}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.repetitions, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Fighting",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicGen05",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then	
			local trigger = false
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and (values.played or 0) > play_more_than and SMODS.is_poker_hand_visible(handname) then
					trigger = true
					break
				end
			end
			if trigger == true then 
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
		end
	end,
}

return {name = "Petilil Line", 
enabled = stall_config.Petilil or false,
list = {petilil, lilligant, hisuian_lilligant}
}