local litten_alt = {
	name = "litten_alt",
	pos = {x = 8, y = 48},
	config = {extra = {mult = 0, mult_mod = 1, d_size = 1}, evo_rqmt = 10},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		return {vars = {abbr.d_size, abbr.mult, abbr.mult_mod, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Fire",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
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
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
					message = "Rawr",
					colour = G.C.MULT
				}
			end
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
		
		return scaling_evo(self, card, context, "j_stall_torracat_alt", card.ability.extra.mult, self.config.evo_rqmt)
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

local torracat_alt = {
	name = "torracat_alt",
	pos = {x = 10, y = 48},
	config = {extra = {mult = 0, mult_mod = 2, d_size = 1}, evo_rqmt = 24},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.d_size, abbr.mult, abbr.mult_mod, self.config.evo_rqmt}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Fire",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.pre_discard and not context.hook and not context.blueprint then
		  local trigger = true
			local discardedHand = G.FUNCS.get_poker_hand_info(context.full_hand)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= discardedHand and (values.played or 0) > (G.GAME.hands[discardedHand].played or 0) and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
					message = "Rawr!",
					colour = G.C.MULT
				}
			end
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end
		
		return scaling_evo(self, card, context, "j_stall_incineroar_alt", card.ability.extra.mult, self.config.evo_rqmt)
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

local incineroar_alt = {
	name = "incineroar_alt",
	pos = {x = 12, y = 48},
	config = {extra = {money = 1, mult = 0, mult_mod = 3, d_size = 1, trigger = true}},
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
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.pre_discard and not context.hook and not context.blueprint then
			local discardedHand = G.FUNCS.get_poker_hand_info(context.full_hand)
			card.ability.extra.trigger = true
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= discardedHand and (values.played or 0) > (G.GAME.hands[discardedHand].played or 0) and SMODS.is_poker_hand_visible(handname) then
					card.ability.extra.trigger = false
					break
				end
			end
			if card.ability.extra.trigger == true then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
					message = 'Roar!',
					colour = G.C.MULT
				}
			end
		end
		
		if context.discard and not context.other_card.debuff and card.ability.extra.trigger == true and not context.hook then
			if context.other_card then
				local earned = ease_poke_dollars(card, "incineroar", card.ability.extra.money)
				return {
					message = '$'..earned,
					colour = G.C.MONEY,
					delay = 0.45, 
					card = card
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

init = function ()
  pokermon.dex_order_groups[#pokermon.dex_order_groups + 1] = { 'litten_alt', 'torracat_alt', 'incineroar_alt' }
end

return {name = "Litten Alt Line", 
enabled = stall_config.Litten == false and (stall_config.Litten_Alt or false),
init = init,
list = {litten_alt, torracat_alt, incineroar_alt}
}