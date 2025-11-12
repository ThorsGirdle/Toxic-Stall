local clue = {		
	name = "clue",
	key = "clue",
	set = "Item",
	pos = { x = 1, y = 0 },
  cost = 4,
  unlocked = true,
  discovered = true,
  hidden = false,
  can_repeat_soul = false,
  atlas = 'StallConsumables',
	config = { handsize = 1},
	loc_vars = function(self, info_queue, center)
    return {vars = {self.config.handsize}}
  end,
	
	can_use = function(self, card)
		if G.hand then
			return true
		else
			return false
		end
	end,
	
  use = function(self, card, area, copier)
    set_spoon_item(card)
		clue_increment(self.config.handsize)
		
  end,
  in_pool = function(self)
		return false
	end,
}

return {
	name = "Items",
	list = {clue, }
}