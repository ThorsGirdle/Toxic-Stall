local brave = {
	key = "brave",		
  atlas = "PlaceholderStallEnhancements",
	--artist = 
  pos = { x = 2, y = 0 },
	config = { extra = {drawn = true, turnsLeft = 6, retriggers = 1}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,
  unlocked = true,
  discovered = true,
  no_collection = false,
	weight = 10,

  loc_vars = function(self, info_queue, card)
		abbr = card.ability.extra
		local msg = ""
		if abbr.drawn == true then
			msg = "Active!"
		else
			msg = "Inactive"
		end
		
		return {vars = {abbr.turnsLeft, msg}}
	end,
	
	calculate = function(self, card, context)		
		if context.hand_drawn and SMODS.drawn_cards then
			if G.hand and G.hand.cards then
				for i, v in ipairs(G.hand.cards) do
					if v == card then
						card.ability.extra.drawn = false
						break
					end
				end
			end
			for i, drawnCard in ipairs(SMODS.drawn_cards) do
				if drawnCard == card then
					card.ability.extra.drawn = true
					card.ability.extra.turnsLeft = card.ability.extra.turnsLeft - 1
					if card.ability.extra.turnsLeft <= 0 then
						if pseudorandom('brave') < .50 then
							local legalRanks = {}
							if G.jokers and G.jokers.cards then
								for _, joker in ipairs(G.jokers.cards) do
									if joker.ability and joker.ability.extra and joker.ability.extra.braveWhiteList then
										for k, j in ipairs(joker.ability.extra.braveWhiteList) do
											if not next(legalRanks, j) then
												table.insert(legalRanks, j)
											end
										end
									end
								end
							end
							local targetRank
							if next(legalRanks) == nil then
								local rankTable = pokermon.get_target_card_ranks("brave", 1, "Ace", false)
								targetRank = rankTable[1].id
							else 
								pseudoshuffle(legalRanks, pseudoseed("brave"))
								targetRank = legalRanks[1]
							end
							if targetRank == card:get_id() and targetRank ~= 14 then
								targetRank = targetRank + 1
							elseif targetRank == card:get_id() and targetRank == 14 then
								targetRank = 2
							end
							local sentRank = ""
							if targetRank == 11 then sentRank = 'Jack'
							elseif targetRank == 12 then sentRank = 'Queen'
							elseif targetRank == 13 then sentRank = 'King'
							elseif targetRank == 14 then sentRank = 'Ace'
							else sentRank = tostring(targetRank)
							end
							assert(SMODS.change_base(drawnCard, _, sentRank))
							card.ability.extra.turnsLeft = 6
							return {
								message = sentRank
							}
						else
							local legalSuits = {}
							for _, k in pairs(SMODS.Suits) do
								if k.original_key ~= card.base.suit then
									table.insert(legalSuits, k.original_key)
								end
							end
							pseudoshuffle(legalSuits, pseudoseed("brave"))
							assert(SMODS.change_base(drawnCard, legalSuits[1]))
							card.ability.extra.turnsLeft = 6
							return {
								message = legalSuits[1]
							}
						end
					end
					break
				end
			end
		end
		
		if context.repetition and context.cardarea == G.play and card.ability.extra.drawn == true then
			return {
				repetitions = card.ability.extra.retriggers
			}					
		end
		if context.stay_flipped and context.from_area == G.play and G.deck and card.seal and card.seal == "stall_zeal" then
		 return {
				modify = {to_area = G.deck}
			}
		end
	end,
}

return {
	name = "Enhancements",
	list = { brave, }
}
