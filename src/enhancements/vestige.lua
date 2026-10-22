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
		return {
			vars = {}
		}
	end,

	update = function(self, card, context)
		if G.hand or G.play then
			local stop = false
				if G.play and G.play.cards then
					for i, v in ipairs(G.play.cards) do
						if v == card then 
							if i > 1 and not SMODS.has_no_rank(G.play.cards[i-1]) then
								card.ability.extra.noRank = false
								assert(SMODS.modify_rank(v, (G.play.cards[i-1]:get_id() - v:get_id() - 1)))
							else
								card.ability.extra.noRank = true							
							end
						 stop = true
						end
					end
				end
			if stop == false then
				if G.hand and G.hand.cards then
					for i, v in ipairs(G.hand.cards) do
						if v == card then 
							if i > 1  then
								if v.highlighted then
									local highlightedLeft = 0
									for j = (i - 1), 1, -1 do
										if G.hand.cards[j].highlighted and not SMODS.has_no_rank(G.hand.cards[j]) then
											highlightedLeft = j											
											break
										end
									end
									if highlightedLeft > 0 and G.hand.cards[highlightedLeft].facing ~= "back" then
										card.ability.extra.noRank = false
										assert(SMODS.modify_rank(v, (G.hand.cards[highlightedLeft]:get_id() - v:get_id() - 1)))
									else
										card.ability.extra.noRank = true
									end
								else
									local targetCard = 0
									for j = (i - 1), 1, -1 do
										if not G.hand.cards[j].highlighted and not SMODS.has_no_rank(G.hand.cards[j]) then
											targetCard = j
											break
										end
									end
									if targetCard > 0 and G.hand.cards[targetCard].facing ~= "back" then
										card.ability.extra.noRank = false
										assert(SMODS.modify_rank(v, (G.hand.cards[targetCard]:get_id() - v:get_id() - 1)))
									else
										card.ability.extra.noRank = true
									end
								end
							else
								card.ability.extra.noRank = true
							end				
						end
					end
				end
			end
			if G.hand and G.hand.highlighted and G.GAME and G.GAME.facing_blind then
				for k, v in ipairs(G.hand.highlighted) do
					if v == card then
						local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
						local backwards = nil
						for k, v in pairs(G.hand.highlighted) do
							if v.facing == "back" then
								backwards = true
								break
							end
						end
						if backwards then
							update_hand_text(
								{ immediate = true, nopulse = nil, delay = 0 },
								{ handname = "????", level = "?", mult = "?", chips = "?" }
							)
							for name, parameter in pairs(SMODS.Scoring_Parameters) do
								update_hand_text({ immediate = true, nopulse = nil, delay = 0 }, { [name] = "?" })
							end
						else
							update_hand_text({
								immediate = true,
								nopulse = nil,
							}, {
								handname = disp_text or text or next(poker_hands),
								level = (G.GAME.hands[text or disp_text].level or 1),
								mult = G.GAME.hands[text or disp_text].mult,
								chips = G.GAME.hands[text or disp_text].chips,
							})
							break
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