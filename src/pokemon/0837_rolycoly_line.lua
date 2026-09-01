local rolycoly = {
	name = "rolycoly",
	--pos = {x = 0, y = 0},
	config = {extra = {mult = 20, cardDestroyed = false, rounds = 3}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		local active = ""
		if abbr.cardDestroyed == true then
			active = "Active!"
		else
		active = "Inactive"
		end
	  return {vars = { abbr.mult, abbr.rounds, active}}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Earth",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"cardDestroyed"},
	
	calculate = function(self, card, context)
		if card.ability.extra.cardDestroyed == false and not context.blueprint and (context.remove_playing_cards or context.joker_type_destroyed) then
			card.ability.extra.cardDestroyed = true 
		end
		
		if context.ante_change and context.ante_end then
			card.ability.extra.cardDestroyed = false 
		end
		
		if context.joker_main and card.ability.extra.cardDestroyed == true then
			return{
				message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
				mult_mod = card.ability.extra.mult
			}		
		end
		
		return pokermon.level_evo(self, card, context, "j_stall_carkol")
	end,
}

local carkol = {
	name = "carkol",
	--pos = {x = 0, y = 0},
	config = {extra = {mult = 25, cardDestroyed = false, destroyedNum = 0}, evo_rqmt = 5},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		if abbr.cardDestroyed == true then
			active = "Active!"
		else
		active = "Inactive"
		end
	  return {vars = { abbr.mult, math.max((self.config.evo_rqmt - abbr.destroyedNum),0), active}}
	end,
	rarity = "poke_safari",
	cost = 6,
	stage = "One",
	ptype = "Fire",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"cardDestroyed"},
	
	calculate = function(self, card, context)
		if context.joker_type_destroyed and not context.blueprint then
			card.ability.extra.cardDestroyed = true 
			card.ability.extra.destroyedNum = card.ability.extra.destroyedNum + 1
		end
		
		if context.remove_playing_cards and not context.blueprint then
			for _, removed_card in ipairs(context.removed) do
				card.ability.extra.destroyedNum = card.ability.extra.destroyedNum + 1
				if SMODS.has_enhancement(removed_card, 'm_stall_gem') then
					pokermon.apply_type_sticker(G.jokers.cards[1], removed_card.ability.extra.currentType)
					card_eval_status_text(G.jokers.cards[1], 'extra', nil, nil, nil, {message = localize("poke_tera_ex"), colour = G.C.SECONDARY_SET.Spectral})
				end
			end
			card.ability.extra.cardDestroyed = true 
		end
		
		if context.ante_change and context.ante_end then
			card.ability.extra.cardDestroyed = false 
		end
		
		if context.joker_main and card.ability.extra.cardDestroyed == true then
			return{
				message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
				mult_mod = card.ability.extra.mult
			}		
		end
		
		return pokermon.scaling_evo(self, card, context, "j_stall_coalossal", card.ability.extra.destroyedNum, self.config.evo_rqmt)
	end,
}

local coalossal = {
	name = "coalossal",
	--pos = {x = 0, y = 0},
	config = {extra = {Xmult = 3, cardDestroyed = false, discards = 1, discardGiven = false}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		if abbr.cardDestroyed == true then
			active = "Active!"
		else
		active = "Inactive"
		end
	  return {vars = { abbr.Xmult, active, abbr.discards}}
	end,
	rarity = "poke_safari", 
	cost = 8,
	stage = "Two",
	ptype = "Fire",
	gen = 8,
	designer = "Thor's Girdle",
	--atlas = "AtlasJokersBasicNatdex",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	poke_custom_values_to_keep = {"cardDestroyed"},
	
	calculate = function(self, card, context)
		if context.joker_type_destroyed and not context.blueprint and card.ability.extra.cardDestroyed == false then
			card.ability.extra.cardDestroyed = true 
		end
		
		if context.remove_playing_cards and not context.blueprint then
			for _, removed_card in ipairs(context.removed) do
				if SMODS.has_enhancement(removed_card, 'm_stall_gem') then
					pokermon.apply_type_sticker(G.jokers.cards[1], removed_card.ability.extra.currentType)
					card_eval_status_text(G.jokers.cards[1], 'extra', nil, nil, nil, {message = localize("poke_tera_ex"), colour = G.C.SECONDARY_SET.Spectral})
				end
			end
			card.ability.extra.cardDestroyed = true 
		end
		
		if context.ante_change and context.ante_end then
			if card.ability.extra.cardDestroyed == true then
				G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
				ease_discard(-card.ability.extra.discards)
			end
			card.ability.extra.cardDestroyed = false 
			card.ability.extra.discardGiven = false
		end
		
		if context.joker_main and card.ability.extra.cardDestroyed == true then
			return{
				xmult = card.ability.extra.Xmult,
			}		
		end
		
		if card.ability.extra.cardDestroyed == true and card.ability.extra.discardGiven == false then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
			ease_discard(card.ability.extra.discards)
			card.ability.extra.discardGiven = true
		end
		
	end,
	remove_from_deck = function(self, card, from_debuff)
		if cardDestroyed == true then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
			ease_discard(-card.ability.extra.discards)
		end
  end,
}

return {
	name = "Rolycoly Line",
	enabled = stall_config.Rolycoly or false,
	list = {rolycoly, carkol, coalossal}
}