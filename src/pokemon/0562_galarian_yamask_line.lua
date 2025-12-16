local galarian_yamask = {
	name = "galarian_yamask",
	pos = {x = 4, y = 8},
	 config = {extra = {rounds = 6}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.rounds}}
  end,
	rarity = 2, --Uncommon
	cost = 7,
	stage = "Basic",
	ptype = "Earth",
	gen = 9,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicGen05",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = false,
	
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			local adjacent = poke_get_adjacent_jokers(card)
			if adjacent[1] and adjacent[2] then
				if adjacent[1].edition then
					adjacent[2]:set_edition( adjacent[1].edition, true, true)
					adjacent[1]:set_edition()
				end
				local energy1, energy2 = get_total_energy(adjacent[1], true)
				if (energy1 or energy2) and energy1 + energy2 > 0 then
					--local rightEnergy = get_total_energy(adjacent[1], false)
					if not pokermon_config.unlimited_energy and not adjacent[2].config.center.no_energy_limit then
						increment_energy(adjacent[2], get_type(adjacent[2]), (math.min(energy1 + energy2,  (energy_max + (G.GAME.energy_plus or 0) - get_total_energy(adjacent[2])))), false)
					else
						increment_energy(adjacent[2], get_type(adjacent[2]), energy1 + energy2, false)
					end
					if energy1 > 0 then
						increment_energy(adjacent[1], get_type(adjacent[1]), -energy1, true)
					end
					if energy2 > 0 then
						increment_energy(adjacent[1], "Colorless", -energy2, true)
					end
				end
			end
		end
		return level_evo(self, card, context, "j_stall_runerigus")
	end,
}	
	
local runerigus = {
	name = "runerigus",
	--pos = {x = 0, y = 0},
	 config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {}}
  end,
	rarity = "poke_safari",
	cost = 7,
	stage = "One",
	ptype = "Psychic",
	gen = 9,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicGen05",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = false,
	
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			local adjacent = poke_get_adjacent_jokers(card)
			if adjacent[1] and adjacent[2] then
				if adjacent[1].edition then
					adjacent[2]:set_edition( adjacent[1].edition, true, true)
				end
				local energy1, energy2 = get_total_energy(adjacent[1], true)
				if (energy1 or energy2) and energy1 + energy2 > 0 then
					if not pokermon_config.unlimited_energy and not adjacent[2].config.center.no_energy_limit then
						increment_energy(adjacent[2], get_type(adjacent[2]), (math.min(energy1 + energy2,  (energy_max + (G.GAME.energy_plus or 0) - get_total_energy(adjacent[2])))), false)
					else
						increment_energy(adjacent[2], get_type(adjacent[2]), energy1 + energy2, false)
					end
				end
			end
		end
	end,
}		
	
		
return {
	name = "Galarian Yamask Line",
	enabled = stall_config.Galarian_Yamask or false,
	list = { galarian_yamask, runerigus}
}