local joltik = {
	name = "joltik",
	--pos = {x = 0, y = 0},
	config = {extra = { mult = 16, lastSum = 0, trigger = false, rounds = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.lastSum, abbr.rounds}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Lightning",
	gen = 5,
	designer = "Thor's Girdle",
	--custom_art = true,
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"lastSum"},
	
  calculate = function(self, card, context)
			if context.before and not context.blueprint then
				local totalSum, AceCount, lastSum = 0, 0, 0
				for i, v in pairs(context.scoring_hand) do
					if context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal < 11 then
						totalSum = totalSum + context.scoring_hand[i].base.nominal
					elseif context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal == 11 then
						totalSum = totalSum + 11
						AceCount = AceCount + 1
					end
				end	
				lastSum = totalSum
				if totalSum < card.ability.extra.lastSum then
					card.ability.extra.trigger = true
					card.ability.extra.lastSum = totalSum
				elseif AceCount > 0 then
					for i = 1, AceCount do
						totalSum = totalSum - 10
						if totalSum < card.ability.extra.lastSum then
							card.ability.extra.trigger = true
							card.ability.extra.lastSum = totalSum
							break
						end
					end
					if card.ability.extra.trigger == false then
						card.ability.extra.lastSum = lastSum
					end
				else 
					card.ability.extra.trigger = false
					card.ability.extra.lastSum = lastSum
				end
			end

			if context.joker_main and card.ability.extra.trigger == true then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}		
			end
			
		if context.after and not context.blueprint then
			card.ability.extra.trigger = false
		end
			
		return level_evo(self, card, context, "j_stall_galvantula")
	end,
}

local galvantula = {
	name = "galvantula",
	--pos = {x = 0, y = 0},
	config = {extra = { mult = 20, Xmult = 2, lastSum = 0, trigger = false, xmultTrigger = false}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.mult, abbr.lastSum, abbr.Xmult}}
	end,
	rarity = "poke_safari", 
	cost = 7,
	stage = "One",
	ptype = "Lightning",
	gen = 5,
	designer = "Thor's Girdle",
	--custom_art = true,
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"lastSum"},
	
  calculate = function(self, card, context)
		
		if context.before and not context.blueprint then
			local totalSum, AceCount, lastSum = 0, 0, 0
			for i, v in pairs(context.scoring_hand) do
				if context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal < 11 then
					totalSum = totalSum + context.scoring_hand[i].base.nominal
				elseif context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal == 11 then
					totalSum = totalSum + 11
					AceCount = AceCount + 1
				end
			end		
			lastSum = totalSum
			if totalSum < card.ability.extra.lastSum then
				card.ability.extra.trigger = true
				if totalSum < card.ability.extra.lastSum/2 then
					card.ability.extra.xmultTrigger = true
				end
				card.ability.extra.lastSum = totalSum
			elseif AceCount > 0 then
				local tempSum = totalSum
				local AceHalf = 0
				for i = 1, AceCount do
					tempSum = tempSum - 10
					if tempSum < card.ability.extra.lastSum/2 then
						card.ability.extra.trigger = true
						card.ability.extra.xmultTrigger = true
						card.ability.extra.lastSum = tempSum
						break
					end
				end
				if card.ability.extra.trigger == false then
					for i = 1, AceCount do
						totalSum = totalSum - 10
						if totalSum < card.ability.extra.lastSum then
							card.ability.extra.trigger = true
							card.ability.extra.lastSum = totalSum
							card.ability.extra.xmultTrigger = false
							break
						end
					end
				end
				if card.ability.extra.trigger == false and card.ability.extra.xmultTrigger == false then
					card.ability.extra.lastSum = lastSum
				end
			else 
				card.ability.extra.trigger = false
				card.ability.extra.xmultTrigger = false
				card.ability.extra.lastSum = lastSum
			end
		end

		if context.joker_main then
			if card.ability.extra.xmultTrigger == true then
				return{
					mult = card.ability.extra.mult,
					xmult = card.ability.extra.Xmult,
				}
			elseif card.ability.extra.trigger == true	then
				return{
					mult = card.ability.extra.mult,
				}
			end
		end
		
		if context.after and not context.blueprint then
			card.ability.extra.trigger = false
			card.ability.extra.xmultTrigger = false
		end
	end,
}






return {name = "Joltik Line", 
enabled = stall_config.Joltik or false,
list = {joltik, galvantula}
}