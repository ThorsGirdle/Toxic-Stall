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


SMODS.Enhancement:take_ownership("poke_seed", {

	  calculate = function(self, card, context)
     if context.main_scoring and context.cardarea == G.play and card.ability and card.ability.extra and type(card.ability.extra) == 'table' then
      card.temp_level = card.temp_level or card.ability.extra.level -- If this card has yet to score this hand, snapshot the starting level to handle delayed set_sprites calls
      card.ability.extra.level = card.ability.extra.level + 1 + (G.GAME.poke_growth_level or 0)

      local level, level_max = card.ability.extra.level, card.ability.extra.level_max

      if level and level > 0 then
        if level >= level_max then
					if card.seal and card.seal == "stall_zeal" and card.config.center.key == "m_poke_seed" then
						card.ability.extra.level = 0
					else
						return {
							extra = {
								message = localize('k_upgrade_ex'),
								sound = 'poke_seed_'..math.min(level_max, level),
							},
							func = function()
								ease_dollars(card.ability.extra.money);
								card:set_ability(G.P_CENTERS.m_poke_flower, nil, true)
							end
						}
					end
        else
          return {
            extra = {
              message = localize('k_upgrade_ex'),
              sound = 'poke_seed_'..level,
            },
            func = function()
              G.E_MANAGER:add_event(Event({
                func = function()
                  card.temp_level = level
                  self:set_sprites(card)
                  return true
                end
              }))
            end,
          }
        end
      end
     end
   end,


}, true)

if (SMODS.Mods["Agarmons"] or {}).can_load then
	SMODS.Enhancement:take_ownership("agar_combee", {
		calculate = function(self, card, context)
			if context.change_rank and context.new_rank == 12
					and (context.old_rank == 11 or context.old_rank == 13) and not SMODS.has_enhancement(context.other_card, 'm_stall_vestige') then
				card.ability.extra.queens_promoted = card.ability.extra.queens_promoted + 1
			end
			return pokermon.scaling_evo(self, card, context, 'j_agar_vespiquen', card.ability.extra.queens_promoted, 1)
		end
	}, true)
end

return {
  key = "STALL_OWNERSHIP",
  value = stall_ownership
}