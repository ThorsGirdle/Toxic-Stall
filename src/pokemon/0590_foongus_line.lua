local foongus = {
	name = "foongus",
	pos = {x = 8, y = 39},
	config = {extra = {Xmult_mod = 0.15, rounds = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_stall_blacksludge
	  return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.rounds}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 5,
	atlas = "AtlasJokersBasicNatdex",
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	add_to_deck = function(self, card, from_debuff)
    if not from_debuff and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_blacksludge')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
			return true
		end
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and not context.blueprint then
			if context.setting_blind and not card.getting_sliced then
				foongus_xmult(card.ability.extra.Xmult_mod)
				G.GAME.toxic_triggered = true
				return {
				extra = { message = "Effect Spore", colour = G.C.MULT },
				}
			end
    end
		return level_evo(self, card, context, "j_stall_amoonguss")
	end,
}

local amoonguss = {
	name = "amoonguss",
	pos = {x = 10, y = 39},
	config = {extra = {Xmult_mod = 0.25, mult = 0, mult_mod = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_stall_blacksludge
	  return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.mult, card.ability.extra.mult_mod}}
	end,
	rarity = "poke_safari", --Safari
	cost = 7,
	stage = "One",
	ptype = "Grass",
	gen = 5,
	atlas = "AtlasJokersBasicNatdex",
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	add_to_deck = function(self, card, from_debuff)
    if not from_debuff and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      local _card = create_card('Item', G.consumeables, nil, nil, nil, nil, 'c_stall_blacksludge')
      _card:add_to_deck()
      G.consumeables:emplace(_card)
      card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('poke_plus_pokeitem'), colour = G.C.FILTER})
			return true
		end
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and not context.blueprint then
			if context.setting_blind and not card.getting_sliced then
				foongus_xmult(card.ability.extra.Xmult_mod)
				G.GAME.toxic_triggered = true
				return {
					extra = { message = 'Effect Spore', colour = G.C.MULT },
				}
			end
			--[[
			if context.joker_main and card.ability.extra.mult > 0 then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					--colour = G.C.RED,
					mult_mod = card.ability.extra.mult
				}		
			end
    end
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.name == "pokeball" or context.consumeable.ability.name == "greatball" or context.consumeable.ability.name == "ultraball" or context.consumeable.ability.name == "masterball" then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
						extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT}
						}
			end --]]	
		end
	end,
}

return {
	name = "Foongus Line",
	enabled = stall_config.Foongus or false,
	list = {foongus, amoonguss}
}