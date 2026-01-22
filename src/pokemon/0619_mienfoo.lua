local mienfoo = {
	name = "mienfoo",
	--pos = {x = 0, y = 0},
	config = {extra = {uniqueHands = {}, handReq = 4, activations = 0}, evo_rqmt = 3},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
	  return {vars = {math.max(card.ability.extra.handReq - #card.ability.extra.uniqueHands, 0), math.max(self.config.evo_rqmt - card.ability.extra.activations, 0)}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Fighting",
	gen = 5,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	--atlas = "AtlasJokersBasicNatdex",
	poke_custom_values_to_keep = { "uniqueHands"},

	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.full_hand and context.scoring_hand[1] then
			if card.ability.extra.uniqueHands == {} then
				table.insert(card.ability.extra.uniqueHands, context.scoring_name) 
			else
				local unique = true
				for i, v in pairs(card.ability.extra.uniqueHands) do 
					if v == context.scoring_name then
						unique = false
						break
					end
				end
				if unique == true then
					table.insert(card.ability.extra.uniqueHands, context.scoring_name)
				end			
			end
			if #card.ability.extra.uniqueHands == card.ability.extra.handReq then
				card.ability.extra.activations = card.ability.extra.activations + 1
				local first = context.scoring_hand[1]
					first:set_ability(G.P_CENTERS.m_stall_focused, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
								first:juice_up()
								return true
						end
					})) 
				card.ability.extra.uniqueHands = {}
			end
		end
		
	return scaling_evo(self, card, context, "j_stall_mienshao", card.ability.extra.activations, self.config.evo_rqmt)
	end,
}

local mienshao = {
	name = "mienshao",
	--pos = {x = 0, y = 0},
	config = {extra = {uniqueHands = {}, handReq = 4, mult_mod = 1, upgrades = 0}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
		abbr = card.ability.extra
	  return {vars = {math.max(abbr.handReq - #abbr.uniqueHands, 0), abbr.mult_mod, abbr.mult_mod * abbr.upgrades}}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "One",
	ptype = "Fighting",
	gen = 5,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	--atlas = "AtlasJokersBasicNatdex",
	poke_custom_values_to_keep = { "uniqueHands"},

	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.full_hand and context.scoring_hand[1] then
			if card.ability.extra.uniqueHands == {} then
				table.insert(card.ability.extra.uniqueHands, context.scoring_name) 
			else
				local unique = true
				for i, v in pairs(card.ability.extra.uniqueHands) do 
					if v == context.scoring_name then
						unique = false
						break
					end
				end
				if unique == true then
					table.insert(card.ability.extra.uniqueHands, context.scoring_name)
				end			
			end
			if #card.ability.extra.uniqueHands == card.ability.extra.handReq then
				local first = context.scoring_hand[1]
					first:set_ability(G.P_CENTERS.m_stall_focused, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
								first:juice_up()
								return true
						end
					})) 
				card.ability.extra.uniqueHands = {}
			end
		end
		
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stall_focused') and context.other_card.ability.extra.combo == true then
			card.ability.extra.upgrades = card.ability.extra.upgrades + 1
		end
		
		if context.joker_main and card.ability.extra.upgrades > 0 then
			return{
				message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_mod * card.ability.extra.upgrades}}, 
				mult_mod = card.ability.extra.mult_mod * card.ability.extra.upgrades
			}	
		end
		
	end,
}

return {
	name = "Mienfoo Line",
	enabled = stall_config.Mienfoo or false,
	list = {mienfoo, mienshao}
}