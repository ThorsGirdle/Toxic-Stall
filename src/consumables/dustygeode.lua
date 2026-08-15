local dustygeode = {		
	name = "dustygeode",
	key = "dustygeode",
	set = "poke_item",
	pos = { x = 0, y = 0 },
  cost = 4,
	--artist =
  unlocked = true,
  discovered = false,
	hidden = false,
  atlas = 'PlaceholderStallItem',
	weight = 7,
	config = { mod_conv = 'm_stall_gem', max_highlighted = 1, min_highlighted = 1, currentType = "Grass"},
	loc_vars = function(self, info_queue, center)
		local abbr = self.config
		local highlight_colour = abbr.currentType ~= "Lightning" and G.C.WHITE or G.C.BLACK
		info_queue[#info_queue+1] = {set = 'Other', key = "stall_gem", vars = {1, (abbr.currentType or "Grass"), colours = {pokermon.colours[string.lower(abbr.currentType or "Grass")], (highlight_colour or G.C.BLACK)}}}
    return {vars = {abbr.max_highlighted, abbr.currentType, colours = {pokermon.colours[string.lower(abbr.currentType)], highlight_colour}}}
  end,
	
  use = function(self, card, area, copier)
    set_spoon_item(card)
		if #G.hand.highlighted == 1 then
			pokermon.juice_flip(G.hand.highlighted[1])
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[1]:set_ability(G.P_CENTERS.m_stall_gem)
				G.hand.highlighted[1].ability.extra.currentType = self.config.currentType; G.hand.highlighted[1].ability.extra.wasSet = true; return true end }))
			pokermon.juice_flip(G.hand.highlighted[1])
			poke_unhighlight_cards()
		end
  end,
	
	set_ability = function(self, card, initial, delay_sprites)
		self.config.currentType = self:get_next_type(card)
	end,
	
	in_pool = function(self)
    return stall_config.DustyGeode
	end,
	
	get_next_type = function(self, card)
		local allTypes = copy_table(POKE_TYPES)
    pseudoshuffle(allTypes, 'gem')
    return table.remove(allTypes )
  end,
}

return {
	name = "Items",
	list = {dustygeode, }
}