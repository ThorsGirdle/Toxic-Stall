local hippopotas = {
	name = "hippopotas",
	pos = {x = 0, y = 0},
	config = {extra = {mult_mod = 1, suit = 'Spades', playedSpades = 0}, evo_rqmt = 34},
	loc_vars = function(self, info_queue, card)
		if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'depleted'}
    end
		local abbr = card.ability.extra
		local depleted_count = 0 
		for _, rank in pairs(SMODS.Ranks) do
      if rank.in_pool and not rank:in_pool({}) then
      else
        local is_rank = function(deck_card)
          return deck_card:get_id() == rank.id
        end
        if pokermon.get_depleted(is_rank) then
          depleted_count = depleted_count + 1
        end
      end
    end
	  return {vars = { abbr.mult_mod, (abbr.mult_mod * depleted_count), localize(card.ability.extra.suit, 'suits_singular'), math.max(self.config.evo_rqmt - abbr.playedSpades, 0), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = 2, --Uncommon
	cost = 7,
	stage = "Basic",
	ptype = "Earth",
	gen = 4,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
			card.ability.extra.playedSpades = card.ability.extra.playedSpades + 1
      local depleted_count = 0   
      for _, rank in pairs(SMODS.Ranks) do
        if rank.in_pool and not rank:in_pool({}) then
        else
          local is_rank = function(deck_card)
            return deck_card:get_id() == rank.id
          end
          if pokermon.get_depleted(is_rank) then
            depleted_count = depleted_count + 1
          end
        end
      end
			return {
				mult = card.ability.extra.mult_mod * depleted_count
			}
		end
		return pokermon.scaling_evo(self, card, context, "j_stall_hippowdon", card.ability.extra.playedSpades, self.config.evo_rqmt)
	end,
}

local hippowdon = {
	name = "hippowdon",
	pos = {x = 0, y = 0},
	config = {extra = {Xmult_mod = 0.01, suit = 'Spades'}},
	loc_vars = function(self, info_queue, card)
		if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'depleted'}
    end
		
		local abbr = card.ability.extra
      local depleted_count = 0   
			for _, suit in pairs(SMODS.Suits) do
				for _, rank in pairs(SMODS.Ranks) do
					if G.deck and G.deck.cards then
						local gone = true
						for k, v in pairs(G.deck.cards) do
							if (v:get_id() == rank.nominal and not SMODS.has_no_rank(v)) and v:is_suit(suit.original_key) then 
								gone = false
								break	
							end
						end
						if gone == true then
							depleted_count = depleted_count + 1
						end
					end
				end
			end
	  return {vars = { abbr.Xmult_mod, (1 + (abbr.Xmult_mod * depleted_count)), localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = "poke_safari",
	cost = 8,
	stage = "One",
	ptype = "Earth",
	gen = 4,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      local depleted_count = 0   
			for _, suit in pairs(SMODS.Suits) do
				for _, rank in pairs(SMODS.Ranks) do
					if G.deck and G.deck.cards then
						local gone = true
						for k, v in pairs(G.deck.cards) do
							if (v:get_id() == rank.nominal and not SMODS.has_no_rank(v)) and v:is_suit(suit.original_key) then 
								gone = false
								break	
							end
						end
						if gone == true then
							depleted_count = depleted_count + 1
						end
					end
				end
			end
			return {
				Xmult = 1 + (card.ability.extra.Xmult_mod * depleted_count)
			}
		end
	end,
}


return {
name = "Hippopotas Line", 
enabled = stall_config.Hippopotas or false,
list = {hippopotas, hippowdon}
}