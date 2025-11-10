local clobbopus = {
	name = "clobbopus",
	pos = {x = 0, y = 0},
	config = {extra = {chips = 8, suit = 'Clubs', triggers = 0}, evo_rqmt = 35},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
	  return {vars = {card.ability.extra.chips, localize(card.ability.extra.suit, 'suits_singular'), math.max( self.config.evo_rqmt - card.ability.extra.triggers, 0 )}}
	end,
	rarity = 1, --Common
	cost = 6,
	stage = "Basic",
	ptype = "Fighting",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand and not context.end_of_round then
			if G.hand.cards and context.individual then
				if context.other_card:is_suit(card.ability.extra.suit) then
					card.ability.extra.triggers = card.ability.extra.triggers + 1
					return {
						chips = card.ability.extra.chips
					}
				end
			end
		end
	return scaling_evo(self, card, context, "j_stall_grapploct", card.ability.extra.triggers, self.config.evo_rqmt)
	end,
}

local grapploct = {
	name = "grapploct",
	pos = {x = 0, y = 0},
	config = {extra = {chips = 16, suit = 'Clubs', Xmult = 3, Xmult1 = 1}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = {abbr.chips, localize(abbr.suit, 'suits_singular'), abbr.Xmult, abbr.Xmult1}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "One",
	ptype = "Fighting",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.cardarea == G.hand and not context.end_of_round then
			if G.hand.cards and context.individual then
				if context.other_card:is_suit(card.ability.extra.suit) then
					return {
						chips = card.ability.extra.chips
					}
				end
			end
		end
		if context.joker_main  then
			local nonClub = 0
			if G.hand and G.hand.cards then
				for i=1, #G.hand.cards do
					if not G.hand.cards[i]:is_suit(card.ability.extra.suit) then
						nonClub = nonClub + 1
					end
				end 	
			end
		return {
			xmult = math.max(card.ability.extra.Xmult - card.ability.extra.Xmult1 * nonClub, 1)
		}
		end
	end,
}

return {
name = "Clobbopus Line", 
enabled = stall_config.Clobbopus or false,
list = {clobbopus, grapploct}
}