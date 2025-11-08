local bunnelby = {
	name = "bunnelby",
	pos = {x = 26, y = 43},
	config = {extra = {num= 1, dem = 2, triggers = 0}, evo_rqmt = 8},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'bunnelby')
	  return {vars = {num, dem, math.max(self.config.evo_rqmt - card.ability.extra.triggers, 0)}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Colorless",
	gen = 6,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then 
     if G.deck and G.deck.cards then
			for i, drawnCard in ipairs(SMODS.drawn_cards) do
				local trigger = true
				for k, v in pairs(G.deck.cards) do
					if drawnCard:get_id() == v:get_id() then
						trigger = false
						break
					end
				end
				if trigger == true then 
					card.ability.extra.triggers = card.ability.extra.triggers + 1
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						if SMODS.pseudorandom_probability(card, 'bunnelby', card.ability.extra.num, card.ability.extra.dem, 'bunnelby') then
							 G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
												}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
						end
					end
					return {
						message = 'Dig!',
						colour = G.C.ORANGE
					}
				end
			end
     end
   end
	return scaling_evo (self, card, context, "j_stall_diggersby", card.ability.extra.triggers, self.config.evo_rqmt)
	end,
}

local diggersby = {
	name = "diggersby",
	pos = {x = 28, y = 43},
	config = {extra = {num= 1, dem = 2, Xmult = 1, Xmult_mod = 0.05}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local num, dem = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.dem, 'diggesby')
	  return {vars = {num, dem, card.ability.extra.Xmult, card.ability.extra.Xmult_mod}}
	end,
	rarity = "poke_safari", 
	cost = 6,
	stage = "One",
	ptype = "Earth",
	gen = 6,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
    if context.hand_drawn and SMODS.drawn_cards and not context.blueprint then 
     if G.deck and G.deck.cards then
			for i, drawnCard in ipairs(SMODS.drawn_cards) do
				local trigger = true
				for k, v in pairs(G.deck.cards) do
					if drawnCard:get_id() == v:get_id() then
						trigger = false
						break
					end
				end
				if trigger == true then 
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						if SMODS.pseudorandom_probability(card, 'diggersby', card.ability.extra.num, card.ability.extra.dem, 'diggersby') then
							 G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
												}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
						end
					end
					return {
						message = 'Dig!',
						colour = G.C.ORANGE
					}
				end
			end
     end
   end
	 if context.joker_main and card.ability.extra.Xmult > 1 then
		return {
			xmult = card.ability.extra.Xmult
		}
	 end
	 
	end,
}

return {
	name = "Bunnelby Line",
	enabled = stall_config.Bunnelby or false,
	list = {bunnelby, diggersby}
}