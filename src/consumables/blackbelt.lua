
local blackbelt = {		
	name = "blackbelt",
	key = "blackbelt",
	set = "poke_item",
	pos = { x = 0, y = 0 },
  cost = 4,
	--artist = 
  unlocked = true,
  discovered = true,
	hidden = false,
  weight = 7.5,
  atlas = 'PlaceholderStallItems2',
	config = { mod_conv = 'm_stall_focused', max_highlighted = 1, min_highlighted = 1},
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_focused
    return {vars = {self.config.max_highlighted}}
  end,
	
  use = function(self, card, area, copier)
    pokermon.set_spoon_item(card)
		if #G.hand.highlighted == 1 then
			pokermon.juice_flip(G.hand.highlighted[1])
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[1]:set_ability(G.P_CENTERS.m_stall_focused);return true end }))
			pokermon.juice_flip(G.hand.highlighted[1])
			poke_unhighlight_cards()
		end
  end,
	
	
	in_pool = function(self)
    return stall_config.BlackBelt
	end,
}

return {
	name = "Items",
	list = {blackbelt, }
}