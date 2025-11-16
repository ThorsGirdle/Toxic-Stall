local klink = {
	name = "klink",
	pos = {x = 26, y = 39},
	config = {extra = {money = 1, drawn = 0, to_draw = 12, totalEarned = 0}, evo_rqmt = 8},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.to_draw - abbr.drawn, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = 1, --Common
	cost = 4,
	stage = "Basic",
	ptype = "Metal",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      card.ability.extra.drawn = card.ability.extra.drawn + #SMODS.drawn_cards 
      if card.ability.extra.drawn >= card.ability.extra.to_draw then
				local earned = ease_poke_dollars(card, "klink", card.ability.extra.money * (math.floor(card.ability.extra.drawn/card.ability.extra.to_draw)))
        card.ability.extra.drawn = card.ability.extra.drawn % card.ability.extra.to_draw
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
        return {
						message = '$'..earned,
						colour = G.C.MONEY
        }
      end
    end
		return scaling_evo (self, card, context, "j_stall_klang", card.ability.extra.totalEarned, self.config.evo_rqmt)
	end,
}
	
local klang = {
	name = "klang",
	pos = {x = 28, y = 39},
	config = {extra = {money = 1, drawn = 0, to_draw = 10, totalEarned = 0}, evo_rqmt = 10},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		return {vars = {abbr.money, abbr.to_draw - abbr.drawn, math.max(self.config.evo_rqmt - abbr.totalEarned, 0)}}
	end,
	rarity = "poke_safari", --Safari
	cost = 6,
	stage = "One",
	ptype = "Metal",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      card.ability.extra.drawn = card.ability.extra.drawn + #SMODS.drawn_cards 
      if card.ability.extra.drawn >= card.ability.extra.to_draw then
				local earned = ease_poke_dollars(card, "klang", card.ability.extra.money * (math.floor(card.ability.extra.drawn/card.ability.extra.to_draw)))
        card.ability.extra.drawn = card.ability.extra.drawn % card.ability.extra.to_draw
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + earned
        return {
						message = '$'..earned,
						colour = G.C.MONEY
        }
      end
    end
		return scaling_evo (self, card, context, "j_stall_klinklang", card.ability.extra.totalEarned, self.config.evo_rqmt)
	end,
}

local klinklang = {
	name = "klinklang",
	pos = {x = 0, y = 40},
	config = {extra = {money = 1, Xmult = 2.5, drawn = 0, to_draw = 8, totaldrawn = 0, totalTarget = 30}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.money, abbr.to_draw - abbr.drawn, abbr.Xmult, abbr.totalTarget, abbr.totaldrawn}}
	end,
	rarity = "poke_safari", --Safari
	cost = 8,
	stage = "Two",
	ptype = "Metal",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced and not context.blueprint then
			card.ability.extra.totaldrawn = 0
		end
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then
      card.ability.extra.drawn = card.ability.extra.drawn + #SMODS.drawn_cards 
			card.ability.extra.totaldrawn = card.ability.extra.totaldrawn + #SMODS.drawn_cards
      if card.ability.extra.drawn >= card.ability.extra.to_draw then
				local earned = ease_poke_dollars(card, "klinklang", card.ability.extra.money * (math.floor(card.ability.extra.drawn/card.ability.extra.to_draw)))
        card.ability.extra.drawn = card.ability.extra.drawn % card.ability.extra.to_draw
        return {
						message = '$'..earned,
						colour = G.C.MONEY
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
	name = "Klink Line",
	enabled = stall_config.Klink or false,
	list = {klink, klang, klinklang}
}