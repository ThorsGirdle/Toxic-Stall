
local spinarak = {
	name = "spinarak",
	pos = PokemonSprites["spinarak"].base.pos,
	config = {extra = {chips = 28, totalEarned = 0}, evo_rqmt = 250},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		return {vars = {card.ability.extra.chips, math.max(self.config.evo_rqmt - card.ability.extra.totalEarned, 0)}}
	end,
		
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 2,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",
		
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and G.hand.cards and not context.end_of_round then
			local left, right = false
			for _,heldCard in ipairs(G.hand.cards) do
				targetID = context.other_card:get_id()
				if heldCard:get_id() == targetID + 1 then
					left = true 
				elseif heldCard:get_id() == targetID - 1 then
					right = true
				elseif targetID == 14 and heldCard:get_id() == 2 then
					left = true
				elseif targetID == 2 and heldCard:get_id() == 14 then
					right = true
				end
			end
			if left == true and right == true then
				card.ability.extra.totalEarned = card.ability.extra.totalEarned + card.ability.extra.chips
				return {
					chips = card.ability.extra.chips
				}
			end
		end
	return scaling_evo(self, card, context, "j_stall_ariados", card.ability.extra.totalEarned, self.config.evo_rqmt)
	end,
}

local ariados = {
	name = "ariados",
	pos = PokemonSprites["ariados"].base.pos,
	config = {extra = {chips = 32, num = 1, dem = 3}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'ariados')
		return {vars = {card.ability.extra.chips, num, dem}}
	end,
		
	rarity = "poke_safari",
	cost = 6,
	stage = "One",
	ptype = "Grass",
	gen = 2,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",
		
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and G.hand.cards and not context.end_of_round then
			local left, right, left2, right2 = false
			for _,heldCard in ipairs(G.hand.cards) do
				targetID = context.other_card:get_id()
				if heldCard:get_id() == targetID + 1 then
					left = true 
				elseif heldCard:get_id() == targetID - 1 then
					right = true
				elseif targetID == 14 and heldCard:get_id() == 2 then
					left = true
				elseif targetID == 2 and heldCard:get_id() == 14 then
					right = true
				end
				if heldCard:get_id() == targetID + 2 then
					left2 = true 
				elseif heldCard:get_id() == targetID - 2 then
					right2 = true
				elseif targetID == 14 and heldCard:get_id() == 3 then
					left2 = true
				elseif targetID == 2 and heldCard:get_id() == 13 then
					right2 = true
				elseif targetID == 13 and heldCard:get_id() == 2 then
					left2 = true
				elseif targetID == 3 and heldCard:get_id() == 14 then
					right2 = true
				end 
			end
			if left == true and right == true then
				if left2 == true and right2 == true then
					if SMODS.pseudorandom_probability(card, 'ariados', card.ability.extra.num, card.ability.extra.dem, 'ariados') then
						toUpgrade = context.other_card
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() toUpgrade:set_ability(G.P_CENTERS.m_stall_toxic);return true end }))
					end
				end
				return {
					chips = card.ability.extra.chips
				}
			end
		end
	end,
}

return {
  name = "Toxic Stall Spinarak Line",
	enabled = stall_config.Spinarak or false,
	list = {spinarak, ariados}
}