local popplio_alt = {
	name = "popplio_alt",
	pos = {x = 14, y = 48},
	config = {extra = {chips = 0, chip_mod = 6, hands = 1, poker_hand = "High Card"}, evo_rqmt = 30},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.chips, abbr.chip_mod, abbr.hands, abbr.poker_hand, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	starter = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = "Bounce!"
			}
		end
		
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'popplio')
			return {
					message = localize('k_reset')
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		return scaling_evo(self, card, context, "j_stall_brionne_alt", card.ability.extra.chips, self.config.evo_rqmt)
	end,
	
	set_ability = function(self, card, initial, delay_sprites)
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
					if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
							_poker_hands[#_poker_hands + 1] = handname
					end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'popplio')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

local brionne_alt = {
	name = "brionne_alt",
	pos = {x = 16, y = 48},
	config = {extra = {chips = 0, chip_mod = 8, hands = 1, poker_hand = "High Card"}, evo_rqmt = 96},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.chips, abbr.chip_mod, abbr.hands, abbr.poker_hand, self.config.evo_rqmt}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			return {
				message = "Bounce!"
			}
		end
		
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'brionne')
			return {
					message = localize('k_reset')
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		return scaling_evo(self, card, context, "j_stall_primarina_alt", card.ability.extra.chips, self.config.evo_rqmt)
	end,
	
	set_ability = function(self, card, initial, delay_sprites)
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
					if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
							_poker_hands[#_poker_hands + 1] = handname
					end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'brionne')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

local primarina_alt = {
	name = "primarina_alt",
	pos = {x = 18, y = 48},
	config = {extra = {chips = 0, chip_mod = 10, Xmult_mod = 1, currXmult = 1, hands = 1, poker_hand = "High Card", triggered = false}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.chips, abbr.chip_mod, abbr.hands, abbr.currXmult, abbr.Xmult_mod, abbr.poker_hand}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			card.ability.extra.triggered = true
			return {
				message = "Bounce!"
			}
		elseif context.before and context.scoring_name ~= card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.currXmult = 1
			card.ability.extra.triggered = false
		end
		
		if context.after and not context.blueprint then
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
				if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
					_poker_hands[#_poker_hands + 1] = handname
				end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'primarina')
			if card.ability.extra.triggered == true then
				card.ability.extra.currXmult = card.ability.extra.currXmult + card.ability.extra.Xmult_mod
				card.ability.extra.triggered = false
				return {
				message = "Liquid Voice!"
				}
			end
			return {
					message = localize('k_reset')
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				xmult = card.ability.extra.currXmult,
			}
		end
		
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.currXmult = 1
			card.ability.extra.triggered = false
			return {
				message = localize('k_reset')
			}
		end
		
	end,

	set_ability = function(self, card, initial, delay_sprites)
			local _poker_hands = {}
			for handname, _ in pairs(G.GAME.hands) do
					if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand and handname ~= "Straight Flush" then
							_poker_hands[#_poker_hands + 1] = handname
					end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'popplio')
	end,
	
	add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    if not from_debuff then
      ease_hands_played(card.ability.extra.hands)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    local to_decrease = math.min(G.GAME.current_round.hands_left - 1, card.ability.extra.hands)
    if to_decrease > 0 then
      ease_hands_played(-to_decrease)
    end
  end,
}

init = function()
  pokermon.dex_order_groups[#pokermon.dex_order_groups + 1] = { 'popplio_alt', 'brionne_alt', 'primarina_alt' }
end

return {name = "Popplio Alt Line", 
enabled = stall_config.Popplio_Alt or false and not stall_config.Popplio,
init = init,
list = {popplio_alt, brionne_alt, primarina_alt}
}