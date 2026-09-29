local shinx = {
	name = "shinx",
	pos = {x = 0, y = 0},
	config = {extra = {mult_mod = 4, suit = 'Diamonds', foresight = 2, rounds = 4}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.mult_mod, abbr.foresight, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural'), card.ability.extra.rounds}}
	end,
	rarity = 2, --Uncommon
	cost = 7,
	stage = "Basic",
	ptype = "Lightning",
	gen = 4,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      local foreseen = false   
			for _,scry_card in pairs(G.poke_scry_view.cards) do
				if scry_card:is_suit(card.ability.extra.suit) then
					foreseen = true
          break
        end
      end
			if foreseen == true then
				return {
					mult = card.ability.extra.mult_mod
				}
			end
		end
		return pokermon.level_evo(self, card, context, "j_stall_luxio")
	end,
	add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.foresight
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.foresight)
  end,
}

local luxio = {
	name = "luxio",
	pos = {x = 0, y = 0},
	config = {extra = {mult_mod = 6, suit = 'Diamonds', foresight = 3, forseenCards = 0}, evo_rqmt = 16},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.mult_mod, abbr.foresight, localize(card.ability.extra.suit, 'suits_singular'), math.max(self.config.evo_rqmt - abbr.forseenCards, 0), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = "poke_safari",
	cost = 8,
	stage = "One",
	ptype = "Lightning",
	gen = 4,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)	
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      local foreseenNum = 0   
			for _,scry_card in pairs(G.poke_scry_view.cards) do
				if scry_card:is_suit(card.ability.extra.suit) then
					foreseenNum = foreseenNum + 1
        end
      end
			if foreseenNum > 1 then
				return {
					mult = card.ability.extra.mult_mod
				}
			end
		end
		
		if context.before then
			for _,scry_card in pairs(G.poke_scry_view.cards) do
				if scry_card:is_suit(card.ability.extra.suit) then
					card.ability.extra.forseenCards = card.ability.extra.forseenCards + 1
        end
      end
    end
		return pokermon.scaling_evo(self, card, context, "j_stall_luxray", card.ability.extra.forseenCards, self.config.evo_rqmt)
	end,
	add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.foresight
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.foresight)
  end,
}

local luxray = {
	name = "luxray",
	pos = {x = 0, y = 0},
	config = {extra = {Xmult_mod = 0.04, suit = 'Diamonds', foresight = 4}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
	  return {vars = { abbr.Xmult_mod, abbr.foresight, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural')}}
	end,
	rarity = "poke_safari",
	cost = 9,
	stage = "Two",
	ptype = "Lightning",
	gen = 4,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)	
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      local foreseenNum = 0   
			for _,scry_card in pairs(G.poke_scry_view.cards) do
				if scry_card:is_suit(card.ability.extra.suit) then
					foreseenNum = foreseenNum + 1
        end
      end
			if foreseenNum > 0 then
				return {
					Xmult = 1 + (card.ability.extra.Xmult_mod * foreseenNum)
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = (G.GAME.poke_scry_amount or 0) + card.ability.extra.foresight
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.poke_scry_amount = math.max(0,(G.GAME.poke_scry_amount or 0) - card.ability.extra.foresight)
  end,
}

return {
name = "Shinx Line", 
enabled = stall_config.Shinx or false,
list = {shinx, luxio, luxray}
}