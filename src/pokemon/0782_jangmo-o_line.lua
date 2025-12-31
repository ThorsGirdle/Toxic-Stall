local jangmoo = {
	name = "jangmoo",
	pos = {x = 2, y = 52},
	config = {extra = {mult = 0, mult_mod = 2, differenceLast = 0}, evo_rqmt = 16},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.differenceLast, self.config.evo_rqmt }}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Dragon",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"mult", "differenceLast"},
	
	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.scoring_name == "Two Pair" and not context.blueprint then
			local pairRanks = get_X_same(2, context.scoring_hand, true)
			local difference =  math.abs(pairRanks[1][1]:get_id() - pairRanks[#pairRanks][1]:get_id())
			if difference == card.ability.extra.differenceLast then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
					message = 'Clang!',
					colour = G.C.MULT
				}
			else 
				card.ability.extra.differenceLast = difference
			end	
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
		return {
			mult = card.ability.extra.mult
		}
	 end

		return scaling_evo(self, card, context, "j_stall_hakamoo", card.ability.extra.mult, self.config.evo_rqmt)
	end,
}

local hakamoo = {
	name = "hakamoo",
	pos = {x = 4, y = 52},
	config = {extra = {mult = 0, mult_mod = 3, differenceLast = 0}, evo_rqmt = 34},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.differenceLast, self.config.evo_rqmt}}
	end,
	poke_custom_values_to_keep = {"mult", "differenceLast"},
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Dragon",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.scoring_name == "Two Pair" and not context.blueprint then
			local pairRanks = get_X_same(2, context.scoring_hand, true)
			local difference =  math.abs(pairRanks[1][1]:get_id() - pairRanks[#pairRanks][1]:get_id())		
			if difference == card.ability.extra.differenceLast then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
						message = 'Clang!',
						colour = G.C.MULT
				}
			else 
				card.ability.extra.differenceLast = difference
			end	
		elseif context.before and context.scoring_hand and context.scoring_name ~= "Two Pair" and not context.blueprint then
			card.ability.extra.differenceLast = 0
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult
			}
		end

		return scaling_evo(self, card, context, "j_stall_kommoo", card.ability.extra.mult, self.config.evo_rqmt)
	end,
}

local kommoo = {
	name = "kommoo",
	pos = {x = 6, y = 52},
	config = {extra = {mult = 0, mult_mod = 4, Xmult = 1, Xmult_mod = 0.5, differenceLast = 0, consecutive = 0}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.mult_mod, abbr.Xmult, abbr.Xmult_mod, abbr.differenceLast, 4 - abbr.consecutive}}
	end,
	poke_custom_values_to_keep = {"mult", "differenceLast"},
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Dragon",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.scoring_name == "Two Pair" and not context.blueprint then
			local pairRanks = get_X_same(2, context.scoring_hand, true)
			local difference =  math.abs(pairRanks[1][1]:get_id() - pairRanks[#pairRanks][1]:get_id())
			if difference == card.ability.extra.differenceLast then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				card.ability.extra.consecutive = card.ability.extra.consecutive + 1
				if card.ability.extra.consecutive == 4 then
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
					card.ability.extra.consecutive = 0
					return {
						message = 'Clangourous Soul!',
						colour = G.C.MULT
					}
				else
				return {
					message = 'Clang!',
					colour = G.C.MULT
				}
				end
			else 
				card.ability.extra.differenceLast = difference
				card.ability.extra.consecutive = 0
			end	
		elseif context.before and context.scoring_hand and context.scoring_name ~= "Two Pair" and not context.blueprint then
			card.ability.extra.differenceLast = 0
			card.ability.extra.consecutive = 0
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.Xmult
				}
		end
	end,
}

return {
name = "Jangmo-o Line", 
enabled = stall_config.Jangmoo or false,
list = {jangmoo, hakamoo, kommoo}
}