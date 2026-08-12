local vestige = {
	key = "vestige",		
  atlas = "PlaceholderStallEnhancements",
	--artist = 
  pos = { x = 3, y = 0 },
	config = {extra = {noRank = false,}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,
  unlocked = true,
  discovered = true,
  no_collection = false,
	weight = 6,

  loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		return {
			vars = {}
		}
	end,

	calculate = function(self, card, context)
		if context.modify_scoring_hand then
			local stop = false
				for i, v in ipairs(context.full_hand) do
					if v == card then 
						if i > 1 and not SMODS.has_no_rank(context.full_hand[i-1]) then
							card.ability.extra.noRank = false
							assert(SMODS.modify_rank(v, (context.full_hand[i-1]:get_id() - v:get_id() - 1)))
						else
							card.ability.extra.noRank = true							
						end
					 stop = true
					end
				end
			if stop == false then
				if G.hand and G.hand.cards then
					for i, v in ipairs(G.hand.cards) do
						if v == card then 
							if i > 1 and not SMODS.has_no_rank(G.hand.cards[i-1]) then
								card.ability.extra.noRank = false
								assert(SMODS.modify_rank(v, (G.hand.cards[i-1]:get_id() - v:get_id() - 1)))
							else
								card.ability.extra.noRank = true
							end	
						end
					end
				end
			end
		end		
	end,
	
	in_pool = function(self)
    return stall_config.SilphScope
	end,
}
return {
	name = "Enhancements",
	list = { vestige, }
}