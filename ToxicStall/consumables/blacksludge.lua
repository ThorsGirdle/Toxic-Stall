
local blacksludge = {		
	name = "blacksludge",
	key = "blacksludge",
	set = "Item",
	pos = { x = 0, y = 0 },
  cost = 4,
  unlocked = true,
  discovered = true,
  hidden = false,
  can_repeat_soul = false,
  atlas = 'StallConsumables',
	config = { mod_conv = 'm_stall_toxic', max_highlighted = 1, card_amount = 2},
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_toxic
    return {vars = {}}--self.config.max_highlighted, self.config.card_amount, key = self.config.mod_conv}}}
  end,
  use = function(self, card, area, copier)
    set_spoon_item(card)
		if #G.hand.highlighted == 1 then
		
      local cards_held = {}
      for k, v in ipairs(G.hand.cards) do
				if v ~= G.hand.highlighted[1] then
          table.insert(cards_held, v)
				end
      end
      pseudoshuffle(cards_held, pseudoseed('blacksludge'))
      local limit = math.min(#cards_held, self.config.card_amount)
      juice_flip(G.hand.highlighted[1])
			juice_flip_table(card, cards_held, false, limit)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[1]:set_ability(G.P_CENTERS.m_stall_toxic);return true end }))
      for i = 1, limit do
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() cards_held[i]:set_ability(G.P_CENTERS.m_stall_toxic);return true end }))
      end
			juice_flip(G.hand.highlighted[1])
      juice_flip_table(card, cards_held, true, limit)
		end
  end,
  in_pool = function(self)
		local toxic_mons = false
		if G.jokers and G.jokers.cards then
			for k, v in ipairs(G.jokers.cards) do
        if v.toxic then
          toxic_mons = true
					break
        end
			end
		end
		local totalToxic = 0
		if G.deck and G.deck.cards then
			for k, v in pairs(G.deck.cards) do
        if SMODS.has_enhancement(v, "m_stall_toxic") then
					totalToxic = totalToxic + 1
				end
			end
		end
		if not toxic_mons and totalToxic < 5 then
			return false
		else 
			return true
		end
	end,
}

return {
	name = "Items",
	list = {blacksludge, }
}