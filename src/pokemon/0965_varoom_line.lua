local varoom = {
	name = "varoom",
	pos = {x = 8, y = 64},
	config = {extra = {mult = 12, mult_mod = 2}, evo_rqmt = 30},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult, self.config.evo_rqmt }}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Metal",
	gen = 9,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
				message = 'Vroom', 
				colour = G.C.MULT 
			}
		end
		if context.after and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult - 1
			if card.ability.extra.mult < 0 then
				card.ability.extra.mult = 0
			end
		end
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
			return {
				message = 'Vroom', 
				colour = G.C.MULT 
			}
		end
		
		if context.joker_main and card.ability.extra.mult > 0 then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}		
		end
		
		return scaling_evo(self, card, context, "j_stall_revavroom", card.ability.extra.mult, self.config.evo_rqmt)
	end,
}

local revavroom = {
	name = "revavroom",
	pos = {x = 10, y = 64},
	config = {extra = {mult = 30, mult_mod = 3, trigger = false}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
	end,
	rarity = "poke_safari", --Safari
	stage = "One",
	ptype = "Metal",
	gen = 9,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				return {
				message = 'Vroom', 
				colour = G.C.MONEY 
			}
		end	
		if context.before and context.cardarea == G.jokers and context.scoring_hand and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, 'm_stone') then
					card.ability.extra.trigger = true
					break
				end
			end
		end
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		end
		if context.joker_main and card.ability.extra.mult > 0 then
				return{
					message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
					mult_mod = card.ability.extra.mult
				}		
		end
		if context.repetition and context.cardarea == G.play and card.ability.extra.trigger then
			if SMODS.has_enhancement(context.other_card, 'm_stall_toxic') then
				return {
					repetitions = 1
				}
			end
		end
		
		if context.repetition and context.cardarea == G.hand and card.ability.extra.trigger and SMODS.has_enhancement(context.other_card, "m_stall_toxic") and not context.other_card.debuff then
			return {
				repetitions = 1
			}
		end
		if context.after and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult - 2
			if card.ability.extra.mult < 0 then
				card.ability.extra.mult = 0
			end
			card.ability.extra.trigger = false
		end
	end,
}

return {
	name = "Varoom Line",
	enabled = stall_config.Varoom or false,
	list = {varoom, revavroom}
}