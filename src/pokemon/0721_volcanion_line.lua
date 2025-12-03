local volcanion ={
  name = "volcanion", 
  pos = {x = 0, y = 0},
  soul_pos = { x = 0, y = 0},
  config = {extra = {currXmult = 1, Xmult_mod = 1, chipTotal = 0, reset = false}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    return {vars = {card.ability.extra.currXmult, card.ability.extra.Xmult_mod, card.ability.extra.chipTotal}}
  end,
  rarity = 4, --Legendary
  cost = 20, 
  stage = "Legendary",
  ptype = "Fire",
  --atlas = "",
  gen = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local tempChipTotal = 0
			for i, v in ipairs(context.scoring_hand) do
				tempChipTotal = tempChipTotal + poke_total_chips(v)
			end
			if tempChipTotal > card.ability.extra.chipTotal then
				card.ability.extra.currXmult = card.ability.extra.currXmult + card.ability.extra.Xmult_mod
				card.ability.extra.chipTotal = tempChipTotal
			else
				card.ability.extra.reset = true
			end
		end
		
		if context.joker_main then
			if card.ability.extra.reset == true and not context.blueprint then
				card.ability.extra.currXmult = card.ability.extra.currXmult * 2
			end
			return {
				xmult = card.ability.extra.currXmult
			}
		end
		
		if context.after and card.ability.extra.reset == true and not context.blueprint then
			card.ability.extra.currXmult = 1
		end
  end,
}

return {
	name = "volcanion Line",
	enabled = stall_config.Volcanion or false,
	list = {volcanion}
}