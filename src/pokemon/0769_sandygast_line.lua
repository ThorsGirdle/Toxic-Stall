local sandygast = {
	name = "sandygast",
	pos = {x = 6, y = 51},
	config = {extra = {chip_mod = 1, chips = 0}, evo_rqmt = 42},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips, self.config.evo_rqmt}}
	end,
	rarity = 1, --Common
	cost = 6,
	stage = "Basic",
	ptype = "Psychic",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	--custom_art = true,
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:is_suit("Spades") then
				card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chip_mod
      end
		end
		if context.joker_main and context.cardarea == G.jokers then
			return{
				message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
				colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chips
      }
     end
    return scaling_evo(self, card, context, "j_stall_palossand", card.ability.extra.chips, self.config.evo_rqmt)
	end,
}

local palossand = {
	name = "palossand",
	pos = {x = 8, y = 51},
	config = {extra = {chip_mod = 2, chips = 0, waterTypes = 0}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips, self.config.waterTypes}}
	end,
	rarity = "poke_safari",
	cost = 8,
	stage = "One",
	ptype = "Psychic",
	gen = 7,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	--custom_art = true,
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local waterTypes = #find_pokemon_type("Water")
			if context.other_card:is_suit("Spades") then
				card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chip_mod
				if context.other_card.ability.perma_mult < #find_pokemon_type("Water") then
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + 1
				end
      end
		end
		if context.joker_main and context.cardarea == G.jokers then
			return{
				message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}, 
				colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chips
        }
      end
	end,
}

return {
	name = "Sandygast Line",
	enabled = stall_config.Sandygast or false,
	list = { sandygast, palossand}
}