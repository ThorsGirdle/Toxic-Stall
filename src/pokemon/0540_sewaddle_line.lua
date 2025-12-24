local sewaddle = {
	name = "sewaddle",
	pos = {x = 0, y = 0},
	config = {extra = {savedChips = 0, rounds = 4}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.rounds}}
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
		if context.individual and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[1] then
				local firstCard = context.scoring_hand[1]
				if card.ability.extra.savedChips == 0 then
					card.ability.extra.savedChips = poke_total_chips(firstCard)
				end
			else 
				return {
					chips = (card.ability.extra.savedChips/2) 
				}
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.savedChips = 0
		end
		
	return level_evo(self, card, context, "j_stall_swadloon")
	end,
}

local swadloon = {
	name = "swadloon",
	pos = {x = 0, y = 0},
	config = {extra = {savedChips = 0, chip_mod = 4, bigBoys = 0, targetChips = 20}, evo_rqmt = 20 },
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chip_mod, math.max((self.config.evo_rqmt - card.ability.extra.bigBoys),0), card.ability.extra.targetChips}}
	end,
	rarity = "poke_safari",
	cost = 6,
	stage = "One",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[1] then
				local firstCard = context.scoring_hand[1]
				if card.ability.extra.savedChips == 0 then
					card.ability.extra.savedChips = poke_total_chips(firstCard)
				end
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chip_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			else 
				if card.ability.extra.savedChips >= 20 then
					 card.ability.extra.bigBoys = card.ability.extra.bigBoys + 1
				end
				return {
					chips = (card.ability.extra.savedChips/2)
				}
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.savedChips = 0
		end
		
	return scaling_evo(self, card, context, "j_stall_leavanny", card.ability.extra.bigBoys, self.config.evo_rqmt)
	end,
}

local leavanny = {
	name = "leavanny",
	pos = {x = 0, y = 0},
	config = {extra = {savedChips = 0, chip_mod = 6}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chip_mod}}
	end,
	rarity = "poke_safari",
	cost = 7,
	stage = "Two",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[1] then
				local firstCard = context.scoring_hand[1]
				if card.ability.extra.savedChips == 0 then
					card.ability.extra.savedChips = poke_total_chips(firstCard)
				end 
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chip_mod 
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			else 
				return {
					chips = card.ability.extra.savedChips
				}
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.savedChips = 0
		end
		
	end,
}

return {
	name = "Sewaddle Line",
	enabled = stall_config.Sewaddle or false,
	list = { sewaddle, swadloon, leavanny}
}