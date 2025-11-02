local croagunk = {
	name = "croagunk",
	pos = {x = 4, y = 30},
	config = {extra = {mult = 3, triggersNum = 0, trigger = false, hearts = 0}, evo_rqmt = 10},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.mult, math.max(self.config.evo_rqmt - card.ability.extra.triggersNum, 0)}}
	end,
	rarity = 2, --Uncommon
	cost = 5,
	stage = "Basic",
	ptype = "Dark",
	gen = 4,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and context.scoring_hand and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit("Hearts") then
					card.ability.extra.hearts = card.ability.extra.hearts + 1
					if card.ability.extra.hearts > 1 then
						break
					end
				end
			end
			if card.ability.extra.hearts == 1 then
				card.ability.extra.trigger = true
			end
		end
		
		if card.ability.extra.trigger and context.individual and  context.cardarea == G.play then
			return {
			    --message = "Ribbit", 
          --colour = G.C.MULT,
          mult = card.ability.extra.mult,
          card = card
			}
		end
		
		if context.after and card.ability.extra.trigger then
			card.ability.extra.triggersNum = card.ability.extra.triggersNum + 1
			card.ability.extra.trigger = false
			card.ability.extra.hearts = 0
		end   
		
	return scaling_evo(self, card, context, "j_stall_toxicroak", card.ability.extra.triggersNum, self.config.evo_rqmt)
	end,
}

local toxicroak = {
	name = "toxicroak",
	pos = {x = 6, y = 30},
	config = {extra = {mult = 4, hearts = 0, trigger = false}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
		local toxicMult = ((G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicXMult) or 1)
	  return {vars = {card.ability.extra.mult, toxicMult}}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "One",
	ptype = "Dark",
	gen = 4,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		local trigger = false
		if context.before and context.cardarea == G.jokers and context.scoring_hand then
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit("Hearts") then
					card.ability.extra.hearts = card.ability.extra.hearts + 1
					if card.ability.extra.hearts > 1 then
						break
					end
				end
			end
			if card.ability.extra.hearts == 1 then
				card.ability.extra.trigger = true
			end
		end
		
		if card.ability.extra.trigger and context.individual and  context.cardarea == G.play then
			toxic_scaling()
			G.GAME.toxic_triggered = true
			local toxicXMult = G.GAME.current_round.toxic.toxicXMult
			return {
			    --message = "Ribbit", 
          --colour = G.C.MULT,
          mult = card.ability.extra.mult,
					x_mult = toxicXMult,
          card = card
			}
		end
		
		if context.after and card.ability.extra.trigger then
			card.ability.extra.trigger = false
			card.ability.extra.hearts = 0
		end   
		
		if context.joker_main and card.edition and not card.edition.negative then
			toxic_scaling()
			G.GAME.toxic_triggered = true
			local toxicXMult = G.GAME.current_round.toxic.toxicXMult
			return {
				--message = "Ribbit", 
				--colour = G.C.MULT,
				x_mult = toxicXMult,
			}
		end
	end,
}

if stall_config.Croagunk then
  list = {croagunk, toxicroak}
else list = {}
end

return {
	name = "Croagunk Line",
	enabled = stall_config.Croagunk or false,
	list = list
}