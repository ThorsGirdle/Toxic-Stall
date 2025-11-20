local yungoos={
  name = "yungoos", 
  pos = {x = 0, y = 0},
  config = {extra = {money = 8, totalEarned = 0}, evo_rqmt = 24},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money, math.max(self.config.evo_rqmt - card.ability.extra.totalEarned, 0), localize(G.GAME.current_round.yungoos_rank or "Ace", 'ranks'),
                   (G.GAME.current_round.yungoos_suit or "Spades"), colours = {G.C.SUITS[G.GAME.current_round.yungoos_suit or "Spades"]}}}
  end,
  rarity = 1, 
  cost = 4, 
  stage = "Basic",
  ptype = "Colorless",
	designer = "Thor's Girdle",
 	--atlas = "AtlasJokersBasicNatdex", 
  gen = 7,
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
  calculate = function(self, card, context)
    if not G.GAME.current_round.yungoos_suit or not G.GAME.current_round.yungoos_rank then
			reset_yungoos_card()
		end
		if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:is_suit(G.GAME.current_round.yungoos_suit) and context.other_card:get_id() == G.GAME.current_round.yungoos_id then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.dollar_buffer = 0
                return true
            end
        }))
			local earned = ease_poke_dollars(card, "yungoos", card.ability.extra.money)
			if not context.blueprint then
				reset_yungoos_card()
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
			end
			return {
				message = '$'..earned,
				colour = G.C.MONEY
				}
    end
		return scaling_evo(self, card, context, "j_stall_gumshoos", card.ability.extra.totalEarned, self.config.evo_rqmt)
  end,
	set_ability = function(self, card, initial, delay_sprites)
		reset_yungoos_card()
	end,
}

local gumshoos={
  name = "gumshoos", 
  pos = {x = 0, y = 0},
  config = {extra = {money = 10, rank = "???", suit = "???", rankRevealed = false, suitRevealed = false }},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_stall_clue
		local abbr = card.ability.extra
		if abbr.rankRevealed == true then
			abbr.rank = (G.GAME.current_round.yungoos_rank or "Ace")
		end
		if  abbr.suitRevealed == true then
			abbr.suit = (G.GAME.current_round.yungoos_suit or "Spades")
		end
    return {vars = {abbr.money, abbr.rank, abbr.suit }} --colours = {G.C.SUITS[G.GAME.current_round.yungoos_suit or "Spades"]}
  end,
  rarity = "poke_safari", 
  cost = 6, 
  stage = "One",
  ptype = "Colorless",
	designer = "Thor's Girdle",
 	--atlas = "AtlasJokersBasicNatdex", 
  gen = 7,
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	add_to_deck = function(self, card, from_debuff)
			reset_yungoos_card()
	end,
	
  calculate = function(self, card, context)
	  if not G.GAME.current_round.yungoos_suit or not G.GAME.current_round.yungoos_rank then
			reset_yungoos_card()
		end
    if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:is_suit(G.GAME.current_round.yungoos_suit) and context.other_card:get_id() == G.GAME.current_round.yungoos_id then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.dollar_buffer = 0
                return true
            end
        }))
			local earned = ease_poke_dollars(card, "yungoos", card.ability.extra.money)
			if not context.blueprint then
				card.ability.extra.rankRevealed = false
				card.ability.extra.suitRevealed = false
				card.ability.extra.rank = "???"
				card.ability.extra.suit = "???"
				reset_yungoos_card()
			end
			return {
				message = '$'..earned,
				colour = G.C.MONEY
				}
    else
			if context.individual and context.cardarea == G.play and not context.end_of_round and not context.blueprint then
				if card.ability.extra.suitRevealed == false and context.other_card:is_suit(G.GAME.current_round.yungoos_suit) then
					card.ability.extra.suitRevealed = true
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_clue')
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						return {
							extra = { message = "Shoo!", colour = G.C.ORANGE },
						}
					end
				end
				if card.ability.extra.rankRevealed == false and context.other_card:get_id() == G.GAME.current_round.yungoos_id then
					card.ability.extra.rankRevealed = true
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_clue')
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						return {
							extra = { message = "Shoo!", colour = G.C.ORANGE },
						}
					end
				end
			end
			if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff and not context.blueprint then
				if card.ability.extra.suitRevealed == false and context.other_card:is_suit(G.GAME.current_round.yungoos_suit) then
					card.ability.extra.suitRevealed = true
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_clue')
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						return {
							extra = { message = "Shoo!", colour = G.C.ORANGE },
						}
					end
				end
				if card.ability.extra.rankRevealed == false and context.other_card:get_id() == G.GAME.current_round.yungoos_id then
					card.ability.extra.rankRevealed = true
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_clue')
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						return {
							extra = { message = "Shoo!", colour = G.C.ORANGE },
						}
					end
				end
			end
		end
  end,
}

return {name = "Yungoos Line", 
enabled = stall_config.Yungoos or false,
list = {yungoos, gumshoos}
}