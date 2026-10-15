local sewaddle = {
	name = "sewaddle",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 20, rounds = 5}},
	loc_vars = function(self, info_queue, card)
	  return {vars = {card.ability.extra.mult, card.ability.extra.rounds}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local trigger = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 1) - 1
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and (values.played or 0) < play_more_than and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}	
			end
		end
		
	return pokermon.level_evo(self, card, context, "j_stall_swadloon")
	end,
}

local swadloon = {
	name = "swadloon",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 25, triggers = 0}, evo_rqmt = 7},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, math.max((self.config.evo_rqmt - abbr.triggers), 0)}}
	end,
	rarity = "poke_safari",
	cost = 7,
	stage = "One",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local trigger = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 1) - 1
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and (values.played or 0) < play_more_than and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				card.ability.extra.triggers = card.ability.extra.triggers + 1
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}	
			end
		end
		
	return pokermon.scaling_evo(self, card, context, "j_stall_leavanny", card.ability.extra.triggers, self.config.evo_rqmt)
	end,
}

local leavanny = {
	name = "leavanny",
	pos = {x = 0, y = 0},
	config = {extra = {mult = 25, Xmult = 1, Xmult_mod = 0.25}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.Xmult, abbr.Xmult_mod}}
	end,
	rarity = "poke_safari",
	cost = 6,
	stage = "Two",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local trigger = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 1) - 1
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and (values.played or 0) < play_more_than and SMODS.is_poker_hand_visible(handname) then
					trigger = false
					break
				end
			end
			if trigger == true then
				local grow = true
				local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
				for handname, values in pairs(G.GAME.hands) do
					if handname ~= context.scoring_name and (values.played or 0) > play_more_than and SMODS.is_poker_hand_visible(handname) then
						grow = false
						break
					end
				end
				if grow == true then
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
				end
				return{
					mult = card.ability.extra.mult,
					xmult = card.ability.extra.Xmult
				}	
			end
		end
	end,
}


return {
	name = "Sewaddle Line",
	enabled = stall_config.Sewaddle or false,
	list = { sewaddle, swadloon, leavanny}
}