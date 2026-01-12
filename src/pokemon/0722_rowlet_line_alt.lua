local rowlet_alt = {
	name = "rowlet_alt",
	pos = {x = 2, y = 48},
	config = {extra = {money = 2, totalEarned = 0, h_size = 1, next_poker_hand = "High Card", poker_hand = "None"}, evo_rqmt = 14},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	starter = true,
	
  calculate = function(self, card, context)
		if context.before then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
				local earned = ease_poke_dollars(card, "litten", card.ability.extra.money)
					card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
					return {
						message = '$'..earned,
						colour = G.C.MONEY
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
		return scaling_evo(self, card, context, "j_stall_dartrix_alt", card.ability.extra.totalEarned, self.config.evo_rqmt)
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

local dartrix_alt = {
	name = "dartrix_alt",
	pos = {x = 4, y = 48},
	config = {extra = {money = 3, totalEarned = 0, h_size = 1, next_poker_hand = "High Card", poker_hand = "None"}, evo_rqmt = 21},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		return {vars = {abbr.money, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
 calculate = function(self, card, context)
		if context.before then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
					local earned = ease_poke_dollars(card, "litten", card.ability.extra.money)
					card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
					return {
						message = '$'..earned,
						colour = G.C.MONEY
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
			card.ability.extra.next_poker_hand = pseudorandom_element(_poker_hands, 'dartrix')
			return {
					message = localize('k_reset')
			}
		end
		return scaling_evo(self, card, context, "j_stall_decidueye_alt", card.ability.extra.totalEarned, self.config.evo_rqmt)
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

local decidueye_alt = {
	name = "decidueye_alt",
	pos = {x = 6, y = 48},
	config = {extra = {money = 4, h_size = 1, next_poker_hand = "High Card", poker_hand = "None", prev_poker_hand = "None", num = 1, dem = 2}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		local num, dem = SMODS.get_probability_vars(card, abbr.num, abbr.dem, 'decidueye')
	  return {vars = {abbr.money, abbr.h_size, abbr.poker_hand, abbr.next_poker_hand, abbr.prev_poker_hand, num, dem}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Grass",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before then
			if G.hand and G.hand.cards and #G.hand.cards > 0 then
				local handname, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.cards)
				if handname == card.ability.extra.poker_hand then 
					local earned = ease_poke_dollars(card, "litten", card.ability.extra.money)
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
									message = '$'..earned,
									colour = G.C.MONEY
								}
							end
						end
					end
					return {
						message = '$'..earned,
						colour = G.C.MONEY
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

return {name = "Rowlet Alt Line",
enabled = stall_config.Rowlet_Alt or false and not stall_config.Rowlet,
list = {rowlet_alt, dartrix_alt, decidueye_alt}
}