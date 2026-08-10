local gem = {
	key = "gem",		
  atlas = "PlaceholderStallEnhancements",
	--artist = 
  pos = { x = 1, y = 0 },
	config = {extra = {energyGiven = 1, currentType = "Grass", cycleTypes = {}, isScoring = false, check = true}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,
  unlocked = true,
  discovered = true,
  no_collection = false,
	weight = 5,

  loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		local abbr = card.ability.extra
		local highlight_colour = abbr.currentType ~= "Lightning" and G.C.WHITE or G.C.BLACK
		return {
			vars = {abbr.energyGiven, abbr.currentType, colours = {pokermon.colours[string.lower(abbr.currentType)], highlight_colour}}
		}
	end,

	get_next_type = function(self, card)
    if not card.ability.extra.cycleTypes or #card.ability.extra.cycleTypes < 1 then
      card.ability.extra.cycleTypes = copy_table(POKE_TYPES)
      pseudoshuffle(card.ability.extra.cycleTypes, 'gem')
    end
    return table.remove(card.ability.extra.cycleTypes)
  end,

	calculate = function(self, card, context)
		if context.press_play and card.ability.extra.isScoring == true then
			for i,v in ipairs(pokermon.find_pokemon_type(card.ability.extra.currentType)) do
				if pokermon.energy.is_energizable(v) and  G.GAME.current_round.gem and G.GAME.current_round.gem.energize and  G.GAME.current_round.gem.energize == true then
					pokermon.energy.energize(v, card.ability.extra.currentType, false, false, card.ability.extra.energyGiven)
					set_gem_vars(false)
				elseif pokermon.energy.is_energizable(v) then
					pokermon.energy.energize(v, card.ability.extra.currentType, false, true, card.ability.extra.energyGiven)
				end
			end
		end
		
		if context.after then
			if card.ability.extra.isScoring == true then
				for i,v in ipairs(pokermon.find_pokemon_type(card.ability.extra.currentType)) do
					if pokermon.energy.is_energizable(v) then
						pokermon.energy.energize(v, card.ability.extra.currentType, false, true, -card.ability.extra.energyGiven)
					end
				end
			end
			set_gem_vars(true)
		end
		
		if context.discard and context.other_card == card then
			card.ability.extra.currentType = self:get_next_type(card)
		end
		
	end,
	
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.currentType = self:get_next_type(card)
	end,
	
	in_pool = function(self)
    return stall_config.DustyGeode
	end,
}
return {
	name = "Enhancements",
	list = { gem, }
}