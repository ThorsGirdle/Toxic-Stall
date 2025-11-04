local venipede = {
	name = "venipede",
	pos = {x = 4, y = 36},
	config = {extra = { num = 1, dem = 7, rounds = 5}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
		 local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'venipede')
	  return {vars = {math.min(num, 10), dem, card.ability.extra.rounds}}
	end,
	rarity = 1, --Common
	cost = 4,
	stage = "Basic",
	ptype = "Dark",
	gen = 5,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.full_hand and context.scoring_hand[1] then
			if SMODS.pseudorandom_probability(card, 'venipede', card.ability.extra.num, card.ability.extra.dem, 'venipede') then
				local first = context.scoring_hand[1]
				first:set_ability(G.P_CENTERS.m_stall_toxic, nil, true)
				G.E_MANAGER:add_event(Event({
          func = function()
              first:juice_up()
              return true
          end
				})) 
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.num = card.ability.extra.num + 1
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.num = 1
		end
	 return level_evo(self, card, context, "j_stall_whirlipede")
	end,
}

local whirlipede = {
	name = "whirlipede",
	pos = {x = 6, y = 36},
	config = {extra = { num = 1, dem = 6, threshold = 0.25, goal = 0, retriggers = 0},  evo_rqmt = 5},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
	  local abbr = card.ability.extra
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'whirlipede')
	  return {vars = {math.min(num, 8), dem, abbr.threshold, math.max(self.config.evo_rqmt - abbr.goal, 0)}}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "One",
	ptype = "Dark",
	gen = 5,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	custom_art = true,
	--atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.full_hand and context.scoring_hand[1] then
			if SMODS.pseudorandom_probability(card, 'venipede', card.ability.extra.num, card.ability.extra.dem, 'venipede') then
				local first = context.scoring_hand[1]
				first:set_ability(G.P_CENTERS.m_stall_toxic, nil, true)
				G.E_MANAGER:add_event(Event({
          func = function()
              first:juice_up()
              return true
          end
				})) 
			end
		end
		if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
			if G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicXMult and (G.GAME.current_round.toxic.toxicXMult - 1) >= card.ability.extra.threshold then
				card.ability.extra.retriggers = math.min(math.floor((G.GAME.current_round.toxic.toxicXMult - 1)/card.ability.extra.threshold), 1)
				if card.ability.extra.retriggers == 1 and SMODS.has_enhancement(context.other_card, 'm_stall_toxic') then
					card.ability.extra.goal = card.ability.extra.goal + 1
				end
				return{
				    message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
				}
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.num = card.ability.extra.num + 1
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.num = 1
			card.ability.extra.retriggers = 0
		end
	 return scaling_evo(self, card, context, "j_stall_scolipede", card.ability.extra.goal, self.config.evo_rqmt)
	end,
}

local scolipede = {
	name = "scolipede",
	pos = {x = 8, y = 36},
	config = {extra = { num = 1, dem = 5, retriggers = 0, threshold = 0.25}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
		local abbr = card.ability.extra
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'scolipede')
	  return {vars = {math.min(num, 8), dem, abbr.retriggers, abbr.threshold}}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "Two",
	ptype = "Dark",
	gen = 5,
	toxic = true,
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",

	calculate = function(self, card, context)
		if context.before and context.scoring_hand and context.full_hand and context.scoring_hand[1] then
			if SMODS.pseudorandom_probability(card, 'venipede', card.ability.extra.num, card.ability.extra.dem, 'venipede') then
				local first = context.scoring_hand[1]
				first:set_ability(G.P_CENTERS.m_stall_toxic, nil, true)
				G.E_MANAGER:add_event(Event({
          func = function()
              first:juice_up()
              return true
          end
				})) 
			end
		end
		if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
			if G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicXMult and (G.GAME.current_round.toxic.toxicXMult - 1) >= card.ability.extra.threshold then
				card.ability.extra.retriggers = math.min(math.floor((G.GAME.current_round.toxic.toxicXMult - 1)/card.ability.extra.threshold), 5)
				return{
				    message = localize('k_again_ex'),
            repetitions = card.ability.extra.retriggers,
            card = card
				}
			end
		end
		if context.after and not context.blueprint then
			card.ability.extra.num = card.ability.extra.num + 1
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.num = 1
			card.ability.extra.retriggers = 0
		end
	end,
}


return {
	name = "Venipede Line",
	enabled = stall_config.Venipede or false,
	list = {venipede, whirlipede, scolipede}
}