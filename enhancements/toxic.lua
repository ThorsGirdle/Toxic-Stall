
local toxic = {
	key = "toxic",		
  atlas = "StallEnhancements",
  pos = { x = 0, y = 0 },
	config = {extra = {toxicXMult = 1, toxicMult_mod = 0.05}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,

  loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		return {
			vars = { ((G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicXMult) or 1), 
							((G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicMult_mod) or 0.05)}
		}
	end,

	calculate = function(self, card, context)
		if G.GAME.current_round.toxic then
			 card.ability.extra.toxicXMult = G.GAME.current_round.toxic.toxicXMult
			 card.ability.extra.toxicMult_mod = G.GAME.current_round.toxic.toxicMult_mod
		else
			G.GAME.current_round.toxic = { toxicXMult = card.ability.extra.toxicXMult }
			G.GAME.current_round.toxic.toxicMult_mod = { toxicMult_mod = card.ability.extra.toxicMult_mod }
		end
		if context.main_scoring and context.cardarea == G.play then
			toxic_scaling()
			G.GAME.toxic_triggered = true
			card.ability.extra.toxicXMult = G.GAME.current_round.toxic.toxicXMult
			return { x_mult = card.ability.extra.toxicXMult}
			
		end
		if context.cardarea == G.hand and context.card_effects and (next(context.card_effects[1]) or #context.card_effects > 1) and not context.end_of_round then --or (context.other_card.ability.perma_h_chips and context.other_card.ability.perma_h_chips > 0) then
					toxic_scaling()
					G.GAME.toxic_triggered = true
					card.ability.extra.toxicXMult = G.GAME.current_round.toxic.toxicXMult
					SMODS.calculate_effect({x_mult = G.GAME.current_round.toxic.toxicXMult}, card)

			end
		
		card.ability.extra.toxicXMult = G.GAME.current_round.toxic.toxicXMult	
		if context.end_of_round then
			G.GAME.current_round.toxic.toxicXMult = 1
			G.GAME.toxic_triggered = false
		end
	end,	
	in_pool = function(self)
	local toxic_mons = false
	if G.jokers and G.jokers.cards then
		for k, v in ipairs(G.jokers.cards) do
			if v.toxic then
				toxic_mons = true
				break
			end
		end
	end
	local totalToxic = 0
	if G.deck and G.deck.cards then
		for k, v in pairs(G.deck.cards) do
			if SMODS.has_enhancement(v, "m_stall_toxic") then
				totalToxic = totalToxic + 1
			end
		end
	end
	if not toxic_mons and totalToxic < 5 then
		return false
	else 
		return true
	end
end,
}

return {
	name = "Enhancements",
	list = { toxic, }
}
