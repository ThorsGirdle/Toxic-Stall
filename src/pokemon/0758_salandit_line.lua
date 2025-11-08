local salandit = {
	name = "salandit",
	pos = {x = 12, y = 50},
	config = {extra = { rounds = 4}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = { card.ability.extra.rounds}}
	end,
	rarity = 3, --Rare
	cost = 7,
	stage = "Basic",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = false,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local _card = SMODS.create_card { set = "Base", enhancement = "m_stall_toxic", type_key = 'salandit', area = G.discard }
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				_card.playing_card = G.playing_card
				table.insert(G.playing_cards, _card)

				G.E_MANAGER:add_event(Event({
						func = function()
								G.hand:emplace(_card)
								_card:start_materialize()
								G.GAME.blind:debuff_card(_card)
								G.hand:sort()
								if context.blueprint_card then
									context.blueprint_card:juice_up()
								else
									card:juice_up()
								end
								SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
								save_run()
								return true
						end
				}))

				return nil, true -- This is for Joker retrigger purposes
		end
		return level_evo(self, card, context, "j_stall_salazzle")
	end,
}

local salazzle = {
	name = "salazzle",
	pos = {x = 14, y = 50},
	config = {extra = {drainedMult = 0}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.mult, card.ability.extra.mult_mod}}
	end,
	rarity = "poke_safari", --Safari
	cost = 8,
	stage = "One",
	ptype = "Dark",
	gen = 7,
	toxic = true,
	atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.modify_scoring_hand and not context.blueprint and not context.other_card.debuff then
			if SMODS.has_enhancement(context.other_card, "m_stall_toxic") then
				return{
					add_to_hand = true
				}
			end
		end
		if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_steel") and not context.other_card.debuff and not context.blueprint then
			context.other_card.ability.h_x_mult = context.other_card.ability.h_x_mult - 0.05
			if context.other_card.ability.h_x_mult <= 1 then
				context.other_card.ability.h_x_mult = 1
				context.other_card:set_ability('c_base', nil, true)
			end
			toxic_scaling()
			card.ability.extra.drainedMult = card.ability.extra.drainedMult + 0.05
		end
		if context.cardarea == G.jokers and context.setting_blind and not card.getting_sliced and not context.blueprint then
			foongus_xmult(card.ability.extra.drainedMult)
			G.GAME.toxic_triggered = true
		end
	end,
}

return {
	name = "Salandit Line",
	enabled = stall_config.Salandit or false,
	list = { salandit, salazzle}
}