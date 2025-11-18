--Don't tell the rest, but this one is my favorite
local dewpider = {
	name = "dewpider",
	pos = {x = 0, y = 50},
	config = {extra = {money = 2, mult = 0, mult_mod = 1, minSum = 1}, evo_rqmt = 8},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.minSum, abbr.minSum + 4, abbr.money, abbr.mult, abbr.mult_mod, self.config.evo_rqmt}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	custom_art = true,
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.cardarea == G.jokers then
			local totalSum, AceCount = 0, 0
			if context.before and not context.blueprint then
				for i, v in pairs(context.scoring_hand) do
					if context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal < 11 then
						totalSum = totalSum + context.scoring_hand[i].base.nominal
					elseif context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal == 11 then
						totalSum = totalSum + 1
						AceCount = AceCount + 1
					end
				end		
				if totalSum >= card.ability.extra.minSum and totalSum <= card.ability.extra.minSum + 4 then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					local earned = ease_poke_dollars(card, "dewpider", card.ability.extra.money)
					return {
						message = '$'..earned,
						colour = G.C.MONEY
						}
				elseif AceCount > 0 then
					for i = 1, AceCount do
						totalSum = totalSum + 10
						if totalSum >= card.ability.extra.minSum and totalSum <= card.ability.extra.minSum + 4 then
							card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
							local earned = ease_poke_dollars(card, "dewpider", card.ability.extra.money)
							return {
								message = '$'..earned,
								colour = G.C.MONEY
								}
						end
					end
				end
			end
			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				card.ability.extra.minSum = math.random(1, 46)
				--[[return {
					message = localize('k_reset')
				}--]]
			end
			if context.joker_main and card.ability.extra.mult > 0 then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}		
			end
		end
		return scaling_evo(self, card, context, "j_stall_araquanid", card.ability.extra.mult, self.config.evo_rqmt)
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.minSum = math.random(1, 46)
	end
}

local araquanid = {
	name = "araquanid",
	pos = {x = 2, y = 50},
	config = {extra = {money = 4, mult = 0, mult_mod = 2, minSum = 1}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.minSum, abbr.minSum + 4, abbr.money, abbr.mult, abbr.mult_mod}}
	end,
	rarity = "poke_safari", --Safari
	cost = 5,
	stage = "One",
	ptype = "Water",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
  calculate = function(self, card, context)
		if context.cardarea == G.jokers then
			local totalSum, AceCount = 0, 0
			if context.before and not context.blueprint then
				for i, v in pairs(context.scoring_hand) do
					if context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal < 11 then
						totalSum = totalSum + context.scoring_hand[i].base.nominal
					elseif context.scoring_hand[i].base.nominal and context.scoring_hand[i].base.nominal == 11 then
						totalSum = totalSum + 1
						AceCount = AceCount + 1
					end
				end		
				if totalSum >= card.ability.extra.minSum and totalSum <= card.ability.extra.minSum + 4 then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					local earned = ease_poke_dollars(card, "araquanid", card.ability.extra.money)
					return {
						message = '$'..earned,
						colour = G.C.MONEY
						}
				elseif AceCount > 0 then
					for i = 1, AceCount do
						totalSum = totalSum + 10
						if totalSum >= card.ability.extra.minSum and totalSum <= card.ability.extra.minSum + 4 then
							card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
							local earned = ease_poke_dollars(card, "araquanid", card.ability.extra.money)
							return {
								message = '$'..earned,
								colour = G.C.MONEY
								}
						end
					end
				end
			end
			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				card.ability.extra.minSum = math.random(1, 46)
				--[[return {
					message = localize('k_reset')
				}--]]
			end
			if context.joker_main and card.ability.extra.mult > 0 then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}		
			end
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.minSum = math.random(1, 46)
	end
}

return {name = "Dewpider Line", 
enabled = stall_config.Dewpider or false,
list = {dewpider, araquanid}
}