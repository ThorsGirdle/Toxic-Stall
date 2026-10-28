SMODS.Enhancement:take_ownership("poke_hazard", {

	  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition and context.cardarea == G.hand and context.playing_card_end_of_round then
      if SMODS.pseudorandom_probability(card, 'hazard', self.config.num, self.config.dem, 'hazard') then
        pokermon.remove_card(card, card)
      end
    end
		if context.repetition and context.cardarea == G.hand and context.scoring_hand then
			local groundium = 0	
			for _, v in ipairs(context.scoring_hand) do
				if v.config.center.key == "m_poke_hazard" and v.seal and v.seal == "stall_zeal" then
					groundium = groundium + 1
				end
			end
			if groundium > 0 then
				return {
					repetitions = groundium
				}
			end
		end
   end,
		

}, true)

-- If it has an extra table and a level, it's good enough for what we're doing
local is_seed_card = function(card)
  return card and card.ability and type(card.ability.extra) == 'table' and card.ability.extra.level
end


stall_grow_card = function(card, amount)
  if not is_seed_card(card) then return end

  local center = card.config.center
  local level_up = (amount or 1) + (G.GAME.poke_growth_level or 0)
  card.ability.extra.level = card.ability.extra.level + level_up
  local level, level_max = card.ability.extra.level, card.ability.extra.level_max or center.config.extra.level_max
  card.poke_visual_growth_mod = math.max(-level_max, (card.poke_visual_growth_mod or 0) - level_up)

  if level > 0 then
    if level >= level_max then
			if card.seal and card.seal == "stall_zeal" and card.config.center.key == "m_poke_seed" then
				if card.ability.extra.level >= 4 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
								SMODS.add_card {
										set = 'Planet',
								}
								G.GAME.consumeable_buffer = 0
								return true
						end)
					}))
				end
				card.ability.extra.level = card.ability.extra.level % level_up
				level = 1
				SMODS.calculate_effect({
					extra = { -- Necessary for timing
						message = localize('k_upgrade_ex'),
						sound = 'poke_seed_' .. math.min((level + 1), 5),
						
					},
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card.poke_visual_growth_mod = math.min(0, (card.poke_visual_growth_mod or 0) + level_up)
								center:set_sprites(card)
								return true
							end
						}))
					end,
				}, card)				
				local earned = pokermon.ease_poke_dollars(card, "grassium", card.ability.extra.money)
				SMODS.calculate_effect({money = earned}, card)
			else
				pokermon.bloom_card(card)
			end
    else
      SMODS.calculate_effect({
        extra = { -- Necessary for timing
          message = localize('k_upgrade_ex'),
          sound = 'poke_seed_' .. level,
        },
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              card.poke_visual_growth_mod = math.min(0, (card.poke_visual_growth_mod or 0) + level_up)
              center:set_sprites(card)
              return true
            end
          }))
        end,
      }, card)
    end
  end
end


SMODS.Enhancement:take_ownership("poke_seed", {

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
			stall_grow_card(card)
			if card.seal and card.seal == "stall_zeal" and card.config.center.key == "m_poke_seed" then
				local dollars = (card.ability.extra.level + 1) * card.ability.seal.seedMoolah
				return {
					dollars =  dollars
				}
			end
    end
  end,
	 set_sprites = function(self, card, front)
    local level_max = self.config.extra.level_max
    -- If we don't have a level, just assume we're at max from becoming a flower card
    local level = (card and card.ability and type(card.ability.extra) == 'table' and card.ability.extra.level or level_max)
        + (card.poke_visual_growth_mod or 0)
        
    -- if there is no card.ability and no self.ability, it means the card is in a pack, so set level to zero
    if not self.ability and not card.ability then
      level = 0
    end
    
    local x_pos = math.min(level_max, math.max(level, 0)) + 1
		--x_pos = math.max(x_pos, 1)
    card.children.center:set_sprite_pos({x = x_pos, y = 0})
  end

}, true)


return {
  key = "STALL_OWNERSHIP",
  value = stall_ownership
}