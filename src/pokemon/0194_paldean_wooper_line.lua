local paldean_wooper = {
  name = "paldean_wooper",
  pos = {x = 6, y = 5},
  config = {extra = {money = 5, earned = 0}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money, self.config.evo_rqmt - card.ability.extra.earned}}
  end,
  rarity = 1,
  cost = 4,
  stage = "Basic",
  ptype = "Dark",
  gen = 9,
	toxic = true,
	designer = "Thor's Girdle",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
	atlas = "AtlasJokersBasicGen02",
  calculate = function(self, card, context)
		if context.remove_playing_cards then
			local earned = 0
			for _, removed_card in ipairs(context.removed) do
				if removed_card:is_face() then
					earned = earned + card.ability.extra.money
					card.ability.extra.earned = card.ability.extra.earned + card.ability.extra.money
				end
			end
			local totalEarned = ease_poke_dollars(card, "paldean_wooper", earned)
			return {
				message = '$'..totalEarned,
				colour = G.C.MONEY
			}
		end
   return scaling_evo (self, card, context, "j_stall_clodsire", card.ability.extra.earned, self.config.evo_rqmt)
  end,
}

local clodsire = {
  name = "clodsire",
	pos = {x = 8, y = 65},
  config = {extra = {money = 6}},
	loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.money}}
  end,
  rarity = 2,
  cost = 5,
  stage = "One",
  ptype = "Dark",
  gen = 9,
	toxic = true,
	designer = "Thor's Girdle",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
	atlas = "AtlasJokersBasicNatdex",
	
  calculate = function(self, card, context)
		if context.remove_playing_cards then
			local earned = 0
			local faces = 0
			for _, removed_card in ipairs(context.removed) do
				if removed_card:is_face() then
					earned = earned + card.ability.extra.money
					faces = faces + 1
				end
			end
			if G.hand and G.hand.cards then
				local cards_held = {}
				for k, v in ipairs(G.hand.cards) do
						table.insert(cards_held, v)
				end
				pseudoshuffle(cards_held, pseudoseed('acquirethesire'))
				local limit = math.min(#cards_held, faces)
				for i = 1, limit do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() cards_held[i]:set_ability(G.P_CENTERS.m_stall_toxic);return true end }))
					cards_held[i]:juice_up()
				end
			end
			local totalEarned = ease_poke_dollars(card, "clodsire", earned)
			return {
				message = '$'..totalEarned,
				colour = G.C.MONEY
				}
			end
  end,
}

return {
	name = "Paldean Wooper Line",
	enabled = stall_config.Paldean_Wooper or false,
	list = { paldean_wooper, clodsire}
}