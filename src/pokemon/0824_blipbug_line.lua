local blipbug = {
	name = "blipbug",
	--pos = {x = 0, y = 0},
	 config = {extra = { consumablesUsed = {}, money_mod = 3}, evo_rqmt = 4},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money_mod, math.max(self.config.evo_rqmt - ((card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed) or 0), 0)}}
  end,
	rarity = 1, --Common
	cost = 4,
	stage = "Basic",
	ptype = "Grass",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"consumablesUsed"},
	
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == "Tarot" then
			local unique = true
			local usedCard = context.consumeable
			for i, v in pairs(card.ability.extra.consumablesUsed) do
				if v == usedCard.config.center_key then
					unique = false
					break
				end
			end
			if unique == true then
				if not context.blueprint then
					table.insert(card.ability.extra.consumablesUsed, usedCard.config.center_key)
				end
				local earned = ease_poke_dollars(card, "blipbug", card.ability.extra.money_mod)
				return {
					message = '$'..earned,
					colour = G.C.MONEY
				}
			end
		end
		return scaling_evo(self, card, context, "j_stall_dottler", ((card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed) or 0), self.config.evo_rqmt)
	end,
}	

local dottler = {
	name = "dottler",
	--pos = {x = 0, y = 0},
	 config = {extra = { consumablesUsed = {}, money_mod = 4}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money_mod, math.max(self.config.evo_rqmt - ((card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed) or 0), 0)}}
  end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "One",
	ptype = "Psychic",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"consumablesUsed"},
	
	calculate = function(self, card, context)
		if context.using_consumeable and (context.consumeable.ability.set == "Tarot" or context.consumeable.ability.set == "Planet") then
			local unique = true
			local usedCard = context.consumeable
			for i, v in pairs(card.ability.extra.consumablesUsed) do
				if v == usedCard.config.center_key then
					unique = false
					break
				end
			end
			if unique == true then
				if not context.blueprint then
					table.insert(card.ability.extra.consumablesUsed, usedCard.config.center_key)
				end
				local earned = ease_poke_dollars(card, "dottler", card.ability.extra.money_mod)
				return {
					message = '$'..earned,
					colour = G.C.MONEY
				}
			end
		end
		return scaling_evo(self, card, context, "j_stall_orbeetle", ((card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed) or 0), self.config.evo_rqmt)
	end,
}	

local orbeetle = {
	name = "orbeetle",
	--pos = {x = 0, y = 0},
	 config = {extra = { consumablesUsed = {}, money_mod = 4, mult_mod = 1}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money_mod, card.ability.extra.mult_mod, (((card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed) or 0) * card.ability.extra.mult_mod)}}
  end,
	rarity = "poke_safari", 
	cost = 6,
	stage = "Two",
	ptype = "Psychic",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = ""
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"consumablesUsed"},
	
	calculate = function(self, card, context)
		if context.using_consumeable then
			local unique = true
			local usedCard = context.consumeable
			for i, v in pairs(card.ability.extra.consumablesUsed) do
				if v == usedCard.config.center_key then
					unique = false
					break
				end
			end
			if unique == true then
				if not context.blueprint then
					table.insert(card.ability.extra.consumablesUsed, usedCard.config.center_key)
				end
				local earned = ease_poke_dollars(card, "orbeetle", card.ability.extra.money_mod)
				return {
					message = '$'..earned,
					colour = G.C.MONEY
				}
			end
		end
		
		if context.joker_main and card.ability.extra.consumablesUsed and #card.ability.extra.consumablesUsed > 0 then
			return {
				mult = #card.ability.extra.consumablesUsed * card.ability.extra.mult_mod
			}
		end
		
	end,
}	

return {name = "Blipbug Line", 
enabled = stall_config.Blipbug or false,
list = {blipbug, dottler, orbeetle}
}