local litten = {
	name = "litten",
	pos = {x = 0, y = 0},
	config = {extra = {money = 2, totalEarned = 0, d_size = 1}, evo_rqmt = 20},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.d_size, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Fire",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	starter = true,
	
  calculate = function(self, card, context)
		if context.pre_discard and not context.hook then
		  local trigger = true
			local discardedHand = G.FUNCS.get_poker_hand_info(context.full_hand)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= discardedHand and (values.played or 0) > (G.GAME.hands[discardedHand].played or 0) and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				local earned = ease_poke_dollars(card, "litten", card.ability.extra.money)
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
				return {
					message = '$'..earned,
					colour = G.C.MONEY
				}
			end
		end
		return scaling_evo(self, card, context, "j_stall_torracat", card.ability.extra.totalEarned, self.config.evo_rqmt)
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end
}

local torracat = {
	name = "torracat",
	pos = {x = 0, y = 0},
	config = {extra = {money = 3, totalEarned = 0, d_size = 1}, evo_rqmt = 30},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.d_size, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Fire",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.pre_discard and not context.hook then
		  local trigger = true
			local discardedHand = G.FUNCS.get_poker_hand_info(context.full_hand)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= discardedHand and (values.played or 0) > (G.GAME.hands[discardedHand].played or 0) and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				local earned = ease_poke_dollars(card, "torracat", card.ability.extra.money)
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
				return {
					message = '$'..earned,
					colour = G.C.MONEY
				}
			end
		end
		return scaling_evo(self, card, context, "j_stall_incineroar", card.ability.extra.totalEarned, self.config.evo_rqmt)
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end
}

local incineroar = {
	name = "incineroar",
	pos = {x = 0, y = 0},
	config = {extra = {money = 4, mult = 0, mult_mod = 1, d_size = 1}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.d_size, abbr.mult, abbr.mult_mod}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Fire",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.pre_discard and not context.hook then
			local discardedHand = G.FUNCS.get_poker_hand_info(context.full_hand)
			trigger = true
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= discardedHand and (values.played or 0) > (G.GAME.hands[discardedHand].played or 0) and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				local earned = ease_poke_dollars(card, "incineroar", card.ability.extra.money)
				local _,_, scoringCards = stall_evaluate_hand(context.full_hand, true)
				card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * #scoringCards)
				return {
					message = 'Roar!',
					colour = G.C.MULT
				} 
			end
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    ease_discard(-card.ability.extra.d_size)
  end
}

return {name = "Litten Line", 
enabled = stall_config.Litten or false,
list = {litten, torracat, incineroar}
}