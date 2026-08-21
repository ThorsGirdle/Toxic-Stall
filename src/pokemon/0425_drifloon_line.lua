local drifloon = {
	name = "drifloon",
	--pos = {x = 0, y = 0},
	config = {extra = {rounds = 4}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_vestige
		if pokermon_config.detailed_tooltips then
			info_queue[#info_queue+1] = {set = 'Other', key = 'depleted'}
		end
		return {
			vars = {abbr.rounds}
		}
	end,
	rarity = 3, --Rare
	cost = 8,
	stage = "Basic",
	ptype = "Psychic",
	gen = 4,
	--atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.hand_drawn and SMODS.drawn_cards then 
			for i, drawnCard in ipairs(SMODS.drawn_cards) do 
				if tostring(drawnCard.config.center_key) == "c_base" and not drawnCard.config.center.debuff and not SMODS.has_no_rank(drawnCard) then
					local trigger = true
					if G.deck and G.deck.cards then
						for k, v in ipairs(G.deck.cards) do
							if drawnCard:get_id() == v:get_id() and not SMODS.has_no_rank(v) and not SMODS.has_enhancement(v, "m_stall_vestige") then
								trigger = false
								break
							end
						end
						if trigger == true then
							drawnCard:set_ability(G.P_CENTERS.m_stall_vestige)
							SMODS.calculate_effect({message = localize('k_upgrade_ex')}, drawnCard)
						end
					end
				end
			end
		end
		return pokermon.level_evo(self, card, context, "j_stall_drifblim")
	end,
}

local drifblim = {
	name = "drifblim",
	--pos = {x = 0, y = 0},
	config = {extra = {Xmult_multi = 2}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_vestige
		if pokermon_config.detailed_tooltips then
			info_queue[#info_queue+1] = {set = 'Other', key = 'depleted'}
		end
		return {
			vars = {abbr.Xmult_multi}
		}
	end,
	rarity = "poke_safari",
	cost = 9,
	stage = "One",
	ptype = "Psychic",
	gen = 4,
	--atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then 
			for i, drawnCard in ipairs(SMODS.drawn_cards) do 
				if tostring(drawnCard.config.center_key) == "c_base" and not drawnCard.config.center.debuff and not SMODS.has_no_rank(drawnCard) then
					local trigger = true
					if G.deck and G.deck.cards then
						for k, v in ipairs(G.deck.cards) do
							if drawnCard:get_id() == v:get_id() and not SMODS.has_no_rank(v) and not SMODS.has_enhancement(v, "m_stall_vestige") then
								trigger = false
								break
							end
						end
						if trigger == true then
							drawnCard:set_ability(G.P_CENTERS.m_stall_vestige)
							SMODS.calculate_effect({message = localize('k_upgrade_ex')}, drawnCard)
						end
					end
				end
			end
		end
		
		if context.individual and context.cardarea == G.play then
			local trigger = true
			if SMODS.has_no_rank(context.other_card) then
				trigger = false
			end
			if G.deck and G.deck.cards and not SMODS.has_no_rank(context.other_card) then
				for k, v in ipairs(G.deck.cards) do
					if context.other_card:get_id() == v:get_id() and not SMODS.has_no_rank(v) and not SMODS.has_enhancement(v, "m_stall_vestige") then
						trigger = false
						break
					end
				end
			end
			if trigger == true then
				return {
					xmult = card.ability.extra.Xmult_multi
				}
			end
		end
	end,
}

return {
	name = "Drifloon",
	enabled = stall_config.Drifloon or false,
	list = {drifloon, drifblim}
}