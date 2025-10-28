local rellor = {
	name = "rellor",
	pos = {x = 14, y = 63},
	config = {extra = { mult = 0, mult_mod = 1 }, evo_rqmt = 7},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	    return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult , self.config.evo_rqmt }}
	end,
	rarity = 1, --Common
	cost = 6,
	stage = "Basic",
	ptype = "Grass",
	gen = 9,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
				mult_mod = card.ability.extra.mult
      }	
		end
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Item" then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		end
		return scaling_evo(self, card, context, "j_stall_rabsca", card.ability.extra.mult, self.config.evo_rqmt)
	end,
}

local rabsca = {
	name = "rabsca",
	pos = {x = 16, y = 63},
	config = {extra = {mult = 0, mult_mod = 1}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'designed_by', vars = {"Thor's Girdle"}}
		local mult = card.ability.extra.mult + ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) * card.ability.extra.mult_mod)
	  return {vars = {card.ability.extra.mult_mod, mult}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Grass", --wish it was Psychic :(
	gen = 9,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main  then
			local mult = card.ability.extra.mult + ((G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) * card.ability.extra.mult_mod)
			return {
				message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
				mult_mod = mult
                }
		end
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Item" then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		end
	end,
}

if stall_config.Rellor then
  list = {rellor, rabsca}
else list = {}
end

return {name = "Rellor", 
enabled = stall_config.Rellor or false,
list = list
}
--]]