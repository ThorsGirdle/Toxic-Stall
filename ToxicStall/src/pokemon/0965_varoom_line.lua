local varoom = {
	name = "varoom",
	pos = {x = 8, y = 64},
	config = {extra = {curr_retriggers = 2, rerolls = 0}, evo_rqmt = 6},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.curr_retriggers, math.max(self.config.evo_rqmt - card.ability.extra.rerolls, 0)}}
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
		card.ability.extra.rerolls = card.ability.extra.rerolls + 1
		if  card.ability.extra.curr_retriggers < 20 then 
			card.ability.extra.curr_retriggers = card.ability.extra.curr_retriggers + 2
				return {
				message = 'Vroom', 
				colour = G.C.MONEY 
			}
		end
		if card.ability.extra.curr_retriggers > 20 then
			card.ability.extra.curr_retriggers = 20
		end
	end
	if context.end_of_round and context.beat_boss and not context.blueprint and context.game_over == false then
		card.ability.extra.curr_retriggers = 2
	end
	if context.repetition and context.cardarea == G.play then
		--for _, scoring_card in ipairs(context.scoring_hand) do
		if card.ability.extra.curr_retriggers >= 1 then
			card.ability.extra.curr_retriggers = card.ability.extra.curr_retriggers - 1
			return {
				repetitions = 1
			}
		end
	end
  return scaling_evo(self, card, context, "j_stall_revavroom", card.ability.extra.rerolls, self.config.evo_rqmt)
end,
}

local revavroom = {
	name = "revavroom",
	pos = {x = 10, y = 64},
	config = {extra = {curr_retriggers = 3}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.curr_retriggers}}
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
		if card.ability.extra.curr_retriggers < 30 then 
			card.ability.extra.curr_retriggers = card.ability.extra.curr_retriggers + 3
				return {
				message = 'Vroom', 
				colour = G.C.MONEY 
			}
		end
		if card.ability.extra.curr_retriggers > 30 then
			card.ability.extra.curr_retriggers = 30
		end
	end
	if context.end_of_round and context.beat_boss and not context.blueprint and context.game_over == false then
		card.ability.extra.curr_retriggers = 3
	end
	if context.repetition and context.cardarea == G.play then
		if card.ability.extra.curr_retriggers >= 1 then
			if not SMODS.has_enhancement(context.other_card, 'm_stone') and not SMODS.has_enhancement(context.other_card, 'm_stall_toxic') then
				card.ability.extra.curr_retriggers = card.ability.extra.curr_retriggers - 1
			end
			return {
				repetitions = 1
			}
		end
	end
end,
}


if stall_config.Varoom then
  list = {varoom, revavroom}
else list = {}
end

return {
	name = "Varoom Line",
	enabled = stall_config.Varoom or false,
	list = list
}