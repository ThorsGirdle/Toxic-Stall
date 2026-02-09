local larvesta = {
	name = "larvesta",
	pos = {x = 0, y = 0},
	config = {extra = {mult_mod = 3, maxMult = 0}, evo_rqmt = 5},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.mult_mod, self.config.evo_rqmt}}
	end,
	rarity = 3, --Rare
	cost = 8,
	stage = "Basic",
	ptype = "Fire",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)
		end
		
		if context.discard and G.GAME.current_round.discards_used <= 0 then
			context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult_mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT
			}
		end
		
		if context.individual and context.cardarea == G.play then
			if (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0) > 0 then
				--[[if SMODS.has_enhancement(context.other_card, 'm_lucky') and context.other_card.lucky_trigger and context.other_card.lucky_mult_trigger then
					if (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.ability.extra and context.other_card.ability.extra.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0) > card.ability.extra.maxMult then
						card.ability.extra.maxMult = (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.ability.extra and context.other_card.ability.extra.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0)
					end--]]
				--elseif (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0) > card.ability.extra.maxMult then			 
				card.ability.extra.maxMult = (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0)
				if SMODS.has_enhancement(context.other_card, 'm_lucky') then
					card.ability.extra.maxMult = card.ability.extra.maxMult - 20
				end				
			end
		end	
		
	return scaling_evo(self, card, context, "j_stall_volcarona", card.ability.extra.maxMult, self.config.evo_rqmt)
	end,
}


local volcarona = {
	name = "volcarona",
	pos = {x = 0, y = 0},
	config = {extra = { Xmult_mod = 0.05}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.Xmult_mod}}
	end,
	rarity = "poke_safari", 
	cost = 9,
	stage = "One",
	ptype = "Fire",
	gen = 5,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)		
		if context.individual and context.cardarea == G.play then
			if (context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0) > 0 then
				local xmult = ((context.other_card.ability.perma_mult or 0) + (context.other_card.ability.mult or 0) + (context.other_card.edition and context.other_card.edition.mult or 0)) 
				if SMODS.has_enhancement(context.other_card, 'm_lucky') then
					xmult = xmult - 20
				end
				xmult = xmult * card.ability.extra.Xmult_mod
				return {
					xmult = 1 + xmult
				}									
			end
		end	
	end,
}

return {
	name = "Larvesta Line",
	enabled = stall_config.Larvesta or false,
	list = { larvesta, volcarona}
}