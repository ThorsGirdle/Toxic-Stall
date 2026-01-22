
local blackbelt = {		
	name = "blackbelt",
	key = "blackbelt",
	set = "Item",
	pos = { x = 0, y = 0 },
  cost = 4,
	--artist = "Emma",
  unlocked = true,
  discovered = true,
  hidden = false,
  can_repeat_soul = false,
  atlas = 'PlaceholderStallItem',
	config = { mod_conv = 'm_stall_focused', max_highlighted = 1, min_highlighted = 1},
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
    return {vars = {self.config.max_highlighted}}
  end,
	
  use = function(self, card, area, copier)
    set_spoon_item(card)
		if #G.hand.highlighted == 1 then
      juice_flip(G.hand.highlighted[1])
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[1]:set_ability(G.P_CENTERS.m_stall_focused);return true end }))
			juice_flip(G.hand.highlighted[1])
			poke_unhighlight_cards()
		end
  end,
	
  in_pool = function(self)	
		if stall_config.BlackBelt and stall_config.BlackBelt == false then
			return false
		else
			local focusedCheck = true
			if G.deck and G.deck.cards then
				for k, v in pairs(G.deck.cards) do
					if SMODS.has_enhancement(v, "m_stall_focused") and v.ability.extra.upgrades < 5 then
						focusedCheck = false
						break
					end
				end
			end
			return focusedCheck	
		end
	end,
}

return {
	name = "Items",
	list = {blackbelt, }
}