local dragonfang = {		
	name = "dragonfang",
	key = "dragonfang",
	set = "poke_item",
	pos = { x = 0, y = 0 },
  cost = 4,
	--artist = "Emma",
  unlocked = true,
  discovered = false,
	hidden = false,
  atlas = 'PlaceholderStallItem',
	weight = 0.03,
	config = { mod_conv = 'm_stall_scale', max_highlighted = 1, min_highlighted = 1},
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_stall_scale
    return {vars = {self.config.max_highlighted}}
  end,
	
  use = function(self, card, area, copier)
    set_spoon_item(card)
		if #G.hand.highlighted == 1 then
			pokermon.juice_flip(G.hand.highlighted[1])
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[1]:set_ability(G.P_CENTERS.m_stall_scale);return true end }))
			pokermon.juice_flip(G.hand.highlighted[1])
			poke_unhighlight_cards()
		end
  end,
	
	in_pool = function(self)	
		if stall_config.BlackBelt and stall_config.BlackBelt == false then
			return false
		else 
			return true
		end
	end,
}

return {
	name = "Items",
	list = {dragonfang, }
}