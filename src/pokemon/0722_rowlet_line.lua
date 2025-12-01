local rowlet = {
	name = "rowlet",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 1, h_size = 1, next_poker_hand = "High Card", poker_hand = "None"}, evo_rqmt = 8},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	starter = true,
	
  calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					return {
						message = "Hoot"
					}
				end
			end
		end
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
			card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'rowlet')
			return {
					message = localize('k_reset')
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		return scaling_evo(self, card, context, "j_stall_dartrix", card.ability.extra.mult, self.config.evo_rqmt)
	end,

	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'rowlet')
		_poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'rowlet')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

local dartrix = {
	name = "dartrix",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 2, h_size = 1, next_poker_hand = "High Card", poker_hand = "None"}, evo_rqmt = 20},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, self.config.evo_rqmt}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
 calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					return {
						message = "Hoot"
					}
				end
			end
		end
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
			card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'rowlet')
			return {
					message = localize('k_reset')
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		return scaling_evo(self, card, context, "j_stall_dartrix", card.ability.extra.mult, self.config.evo_rqmt)
	end,

	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'dartrix')
		_poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'dartrix')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

local decidueye = {
	name = "decidueye",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 3, h_size = 1, next_poker_hand = "High Card", poker_hand = "None", prev_poker_hand = "None", num = 1, dem = 2}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		local num, dem = SMODS.get_probability_vars(card, abbr.num, abbr.dem, 'decidueye')
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, abbr.prev_poker_hand, num, dem}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					if context.scoring_name == card.ability.extra.prev_poker_hand then
						if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
							if SMODS.pseudorandom_probability(card, 'decidueye', card.ability.extra.num, card.ability.extra.dem, 'decidueye') then
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
								G.E_MANAGER:add_event(Event({
									func = (function()
										SMODS.add_card {
											set = 'Spectral',
											key_append = 'stall_decidueye' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
											}
											G.GAME.consumeable_buffer = 0
											return true
									end)
								}))
							return {
								message = localize('k_plus_spectral'),
								colour = G.C.SECONDARY_SET.Spectral
							}
							else
								return {
									message = "Hoot Hoot!"
								}
							end
						end
					end
					return {
						message = "Hoot"
					}
				end
			end
		end
		
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.prev_poker_hand = card.ability.extra.poker_hand
			card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
			card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'decidueye')
			return {
					message = localize('k_reset')
			}
		end
		
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end,

	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'decidueye')
		_poker_hands = {}
		for handname, _ in pairs(G.GAME.hands) do
			if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= card.ability.extra.next_poker_hand then
				_poker_hands[#_poker_hands + 1] = handname
			end
		end
		card.ability.extra.poker_hand = card.ability.extra.next_poker_hand
		card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'decidueye')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

return {name = "Rowlet Line", 
enabled = stall_config.Rowlet or false,
list = {rowlet, dartrix, decidueye}
}