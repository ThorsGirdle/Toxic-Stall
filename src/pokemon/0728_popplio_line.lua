local popplio = {
	name = "popplio",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 2, hands = 1, poker_hand = "High Card"}, evo_rqmt = 12},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.hands, abbr.poker_hand, self.config.evo_rqmt}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	starter = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
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
				mult = card.ability.extra.mult
			}
		end
		return scaling_evo(self, card, context, "j_stall_brionne", card.ability.extra.mult, self.config.evo_rqmt)
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

local brionne = {
	name = "brionne",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 3, hands = 1, poker_hand = "High Card"}, evo_rqmt = 30},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.hands, abbr.poker_hand, self.config.evo_rqmt}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
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
				mult = card.ability.extra.mult
			}
		end
		return scaling_evo(self, card, context, "j_stall_primarina", card.ability.extra.mult, self.config.evo_rqmt)
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

local primarina = {
	name = "primarina",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 0, mult_mod = 4, Xmult_mod = 1, currXmult = 1, hands = 1, poker_hand = "High Card", triggered = false}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.hands, abbr.currXmult, abbr.Xmult_mod, abbr.poker_hand}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
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
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.currXmult,
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

return {name = "Popplio Line", 
enabled = stall_config.Popplio or false,
list = {popplio, brionne, primarina}
}