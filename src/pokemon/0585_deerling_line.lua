local deerling = {
	name = "deerling",
	pos = {x = 4, y = 1},
	 config = {extra = {mult_mod = 1, mult = 0, check = true, form = "Summer", targets = {value = "Spades"}}, evo_rqmt = 12},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"suit"}}
    end
    local card_vars = {card.ability.extra.mult_mod, card.ability.extra.mult, self.config.evo_rqmt, card.ability.extra.targets.value}
		--add_target_cards_to_vars_suits(card_vars, card.ability.extra.targets)
    return {vars = card_vars}
	end,
	rarity = 1, --Common
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicGen05",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local wrongSuit = false
			for _, playing_card in ipairs(context.scoring_hand) do
				if not playing_card:is_suit(card.ability.extra.targets.value) then
					wrongSuit = true
					break
				end
			end
			if wrongSuit then
				local last_mult = card.ability.extra.mult
				card.ability.extra.mult = 0
				if last_mult > 0 then
					return {
						message = localize('k_reset')
					}
				end
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
			end
		end
		
		if context.joker_main then
		return {
			mult = card.ability.extra.mult
		}
		end
		
		if card.ability.extra.check then
			self:set_sprites(card)
			card.ability.extra.check = false
		end
		
	return scaling_evo(self, card, context, "j_stall_sawsbuck", card.ability.extra.mult, self.config.evo_rqmt)
	end,

  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_suits("deerling", 1, card.ability.extra.targets)
		end
		if card.ability and card.ability.extra and card.ability.extra.targets and card.ability.extra.targets.value then
			if card.ability.extra.targets.value == "Hearts" then
				card.ability.extra.form = "Spring"
			elseif card.ability.extra.targets.value == "Spades" then
				card.ability.extra.form = "Summer"
			elseif card.ability.extra.targets.value == "Diamonds" then
				card.ability.extra.form = "Autumn"
			elseif card.ability.extra.targets.value == "Clubs" then
				card.ability.extra.form = "Winter"
			else
				card.ability.extra.form = "Summer"
			end
			self:set_sprites(card)
		end
  end,
	
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra and card.ability.extra.form then
			if card.ability.extra.form == "Spring" then
				card.children.center:set_sprite_pos({x = 2, y = 1})
			elseif card.ability.extra.form == "Summer" then
				card.children.center:set_sprite_pos({x = 4, y = 1})
			elseif card.ability.extra.form == "Autumn" then
				card.children.center:set_sprite_pos({x = 6, y = 1})		
			elseif card.ability.extra.form == "Winter" then
				card.children.center:set_sprite_pos({x = 8, y = 1})
			end
		else
			self:set_ability(card)
		end
		
	end,
	
}

local sawsbuck = {
	name = "sawsbuck",
	pos = {x = 0, y = 2},
	 config = {extra = {mult_mod = 2, mult = 0, check = true, form = "Summer", targets = {value = "Spades"}}},
  loc_vars = function(self, info_queue, card)
    type_tooltip(self, info_queue, card)
    if pokermon_config.detailed_tooltips then
      info_queue[#info_queue+1] = {set = 'Other', key = 'nature', vars = {"suit"}}
    end
    local card_vars = {card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.targets.value}
   -- add_target_cards_to_vars_suits(card_vars, card.ability.extra.targets.value)
    return {vars = card_vars}
	end,
	rarity = "poke_safari", 
	cost = 5,
	stage = "Basic",
	ptype = "Grass",
	gen = 5,
	designer = "Thor's Girdle",
	atlas = "AtlasJokersBasicGen05",
	perishable_compat = false,
	blueprint_compat = true,
	eternal_compat = true,
	
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local wrongSuit = false
			for _, playing_card in ipairs(context.scoring_hand) do
				if not playing_card:is_suit(card.ability.extra.targets.value) then
					wrongSuit = true
					break
				end
			end
			if wrongSuit then
				local last_mult = card.ability.extra.mult
				card.ability.extra.mult = 0
				if last_mult > 0 then
					return {
						message = localize('k_reset')
					}
				end
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
			end
		end
		
		if context.joker_main then
		return {
			mult = card.ability.extra.mult
		}
		end
		
		if card.ability.extra.check then
			self:set_sprites(card)
			card.ability.extra.check = false
		end
	end,
	

  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.targets = get_poke_target_card_suits("deerling", 1, card.ability.extra.targets)
		end
		if card.ability and card.ability.extra and card.ability.extra.targets and card.ability.extra.targets.value then
			if card.ability.extra.targets.value == "Hearts" then
				card.ability.extra.form = "Spring"
			elseif card.ability.extra.targets.value == "Spades" then
				card.ability.extra.form = "Summer"
			elseif card.ability.extra.targets.value == "Diamonds" then
				card.ability.extra.form = "Autumn"
			elseif card.ability.extra.targets.value == "Clubs" then
				card.ability.extra.form = "Winter"
			else
				card.ability.extra.form = "Summer"
			end
			self:set_sprites(card)
		end
  end,
	
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra and card.ability.extra.form then
			if card.ability.extra.form == "Spring" then
				card.children.center:set_sprite_pos({x = 10, y = 1})
			elseif card.ability.extra.form == "Summer" then
				card.children.center:set_sprite_pos({x = 0, y = 2})
			elseif card.ability.extra.form == "Autumn" then
				card.children.center:set_sprite_pos({x = 2, y = 2})		
			elseif card.ability.extra.form == "Winter" then
				card.children.center:set_sprite_pos({x = 4, y = 2})
			end
		else 
			self:set_ability(card)
		end
		
	end,
}

return {
	name = "Deerling Line",
	enabled = stall_config.Deerling or false,
	list = {deerling, sawsbuck}
}