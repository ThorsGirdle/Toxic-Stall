
local hawlucha = {
	name = "hawlucha",
	--pos = {x = 0, y = 0},
	config = {extra = { Xmult = 3, totaldrawn = 0, totalTarget = 30}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.Xmult, abbr.totalTarget, abbr.totaldrawn}}
	end,
	rarity = 2, --Uncommon
	cost = 6,
	stage = "Basic",
	ptype = "Fighting",
	gen = 6,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.totaldrawn = 0
		end
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
			card.ability.extra.totaldrawn = card.ability.extra.totaldrawn + #SMODS.drawn_cards
			if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.boss and card.ability.extra.totaldrawn >= card.ability.extra.totalTarget then
				return {
						message = localize('ph_boss_disabled'),
						func = function() -- This is for timing purposes, it runs after the message
								G.GAME.blind:disable()
						end
				}
			end
    end
		
		
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.totaldrawn >= card.ability.extra.totalTarget then
			return {
				message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
				colour = G.C.XMULT,
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end,
}

return {
	name = "Hawlucha Line",
	enabled = stall_config.Hawlucha or false,
	list = {hawlucha,}
}