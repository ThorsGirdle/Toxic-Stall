local druddigon = {
	name = "druddigon",
	--pos = {x = 0, y = 0},
	config = {extra = {targets = {{type = "Grass"}}, scoredGems = 0}},
	loc_vars = function(self, info_queue, card)
		local abbr = card.ability.extra
		local highlight_colour = abbr.targets[1].type ~= "Lightning" and G.C.WHITE or G.C.BLACK
		local color = abbr.targets[1].type or "Grass"
		--print(abbr.targets[1].type)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stall_gem
		return {
			vars = {(abbr.targets[1].type or "Grass"), colours = {pokermon.colours[string.lower(color)], highlight_colour}}
		}
	end,
	rarity = 2, --Uncommon
	cost = 7,
	stage = "Basic",
	ptype = "Dragon",
	gen = 5,
	--atlas = "AtlasJokersBasicNatdex",
	designer = "Thor's Girdle",
	perishable_compat = true,
	blueprint_compat = true,
	eternal_compat = true,
	enhancement_gate = 'm_stall_gem',
	
	calculate = function(self, card, context)
		if context.modify_scoring_hand then
			local gemCount = 0
			for _, v in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, "m_stall_gem") then 
					gemCount = gemCount + 1
				end
			end
			card.ability.extra.scoredGems = gemCount
		end
	
		if context.press_play and card.ability.extra.scoredGems > 0 then
			for i,v in ipairs(pokermon.find_pokemon_type(card.ability.extra.targets[1].type)) do
				if pokermon.energy.is_energizable(v) and  G.GAME.current_round.gem and G.GAME.current_round.gem.energize and  G.GAME.current_round.gem.energize == true then
					pokermon.energy.energize(v, card.ability.extra.targets[1].type, false, false, card.ability.extra.scoredGems) --To Do: make Gem's energy given a global. If you want it sooner than later let me know
					set_gem_vars(false)
				elseif pokermon.energy.is_energizable(v) then
					pokermon.energy.energize(v, card.ability.extra.targets[1].type, false, true, card.ability.extra.scoredGems)
				end
			end
		end
		
		if context.after and card.ability.extra.scoredGems > 0 then
			for i,v in ipairs(pokermon.find_pokemon_type(card.ability.extra.targets[1].type)) do
				if pokermon.energy.is_energizable(v) then
					pokermon.energy.energize(v, card.ability.extra.targets[1].type, false, true, -card.ability.extra.scoredGems)
				end
			end
			set_gem_vars(true)
			card.ability.extra.scoredGems = 0
		end
	end,
	
	set_nature = function(self, card)
		local pool = {}
		for _, t in ipairs(POKE_TYPES) do
			table.insert(pool, t)
		end
		pseudoshuffle(pool, 'druddigon')
		card.ability.extra.targets[1].type = table.remove(pool)
  end,
	
	set_ability = function(self, card, initial, delay_sprites)
	  if initial then
			self:set_nature(card)
		end
	end,
	
}

return {
	name = "Druddigon",
	enabled = stall_config.Druddigon or false,
	list = {druddigon}
}