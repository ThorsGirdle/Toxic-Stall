local sleight = {
	key = "sleight",		
  atlas = "PlaceholderStallEnhancements",
	--artist = 
  pos = { x = 4, y = 0 },
	config = { extra = {num = 1, dem = 4, savedChips = 0, savedMult = 0, savedXMult = 0, prankTrigger = false}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,
  unlocked = true,
  discovered = true,
  no_collection = false,
	weight = 7,

  loc_vars = function(self, info_queue, card)
		abbr = card.ability.extra
		info_queue[#info_queue+1] = {set = 'Other', key = "stall_prank", vars = {}}
		local num, dem = SMODS.get_probability_vars(card, abbr.num, abbr.dem, 'sleight')	
		return {vars = {num, dem}}
	end,
	
	calculate = function(self, card, context)		
		if context.modify_scoring_hand and context.in_scoring then
			if context.other_card == card and SMODS.pseudorandom_probability(card, 'sleight', card.ability.extra.num, card.ability.extra.dem, 'sleight') then
				card.ability.extra.prankTrigger = true
				if card.seal and card.seal == "stall_zeal" and card.config.center.key == "m_stall_sleight" then 
					G.E_MANAGER:add_event(Event({
					func = (function()
						add_tag({key = get_next_tag_key('darkinium')})
						play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
						play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
						return true
					end)
					}))
				card.ability.extra.prankTriggered = false
				end
				local random = pseudorandom('sleight')
				if random < .3 then --card moves
					if #context.scoring_hand > 1 then
						--local swap = {}
						local oopsCard
						for i, k in ipairs(context.scoring_hand) do
							if k == card then
								oopsCard = i
							end
						end
						local swap = pseudorandom("sleight", 1, #context.scoring_hand)
						if swap == oopsCard and swap == 1 then
							swap = swap + 1
						elseif swap == oopsCard then
							swap = swap - 1
						end
						G.play.cards[swap], G.play.cards[oopsCard] = G.play.cards[oopsCard], G.play.cards[swap]
						local taunts = {"Oops!", "Boop", "Gehehe", "Nope!", "Yeah", "Touch", "Heh", "Pbbbt", "Nah", "Try again", "Perish", "Sneak", "Snack", "Snuck"}
						pseudoshuffle(taunts, "sleight")
						SMODS.calculate_effect({message = taunts[1]}, card)
					end
				elseif random < .6 then --card doesnt score
					if #context.scoring_hand > 1 then
						local taunts = {"Oops!", "Boop", "Gehehe", "Nope!", "Yeah", "Touch", "Heh", "Pbbbt", "Nah", "Try again", "Perish", "Sneak", "Snack", "Snuck"}
						pseudoshuffle(taunts, "sleight")
						return {
							remove_from_hand = true,
							message = taunts[1]
						}
					end
				elseif random < .8 then --Shuffle poker hand
					if #context.scoring_hand > 1 then
						G.play:shuffle("sleight")
						local taunts = {"Oops!", "Boop", "Gehehe", "Nope!", "Yeah", "Touch", "Heh", "Pbbbt", "Nah", "Try again", "Perish", "Sneak", "Snack", "Snuck"}
						pseudoshuffle(taunts, "sleight")
						SMODS.calculate_effect({message = taunts[1]}, card)
					end
				else -- Random Joker moves
					if #G.jokers.cards > 1 then				
						local jokerNum = pseudorandom("sleight", 1, #G.jokers.cards)
						local swap = pseudorandom("sleight", 1, #G.jokers.cards)
						if swap == jokerNum and swap == 1 then
							swap = swap + 1
						elseif swap == jokerNum then
							swap = swap - 1
						end
						G.jokers.cards[swap], G.jokers.cards[jokerNum] = G.jokers.cards[jokerNum], G.jokers.cards[swap]
						local taunts = {"Oops!", "Boop", "Gehehe", "Nope!", "Yeah", "Touch", "Heh", "Pbbbt", "Nah", "Try again", "Perish", "Sneak", "Snack", "Snuck"}
						pseudoshuffle(taunts, "sleight")
						SMODS.calculate_effect({message = taunts[1]}, card)
					end
				end
			end
		end
		if context.before and context.cardarea == G.play then 
			for i, v in ipairs (context.scoring_hand) do
				if v ~= card then
					if pokermon.total_chips(v) > card.ability.extra.savedChips + pokermon.total_chips(card) then
						card.ability.extra.savedChips = pokermon.total_chips(v) - pokermon.total_chips(card)
					end
					if (v.ability.perma_mult or 0) + (v.ability.mult or 0) + (v.edition and v.edition.mult or 0) + (SMODS.has_enhancement(v, 'm_lucky') and -20 or 0) > card.ability.extra.savedMult then 
						card.ability.extra.savedMult = (v.ability.perma_mult or 0) + (v.ability.mult or 0) + (v.edition and v.edition.mult or 0) + (SMODS.has_enhancement(v, 'm_lucky') and -20 or 0)							
					end
					local tempXMult = stall_get_total_XMult(v, context)
					if tempXMult > card.ability.extra.savedXMult + stall_get_total_XMult(card, context) then 
						card.ability.extra.savedXMult = tempXMult - stall_get_total_XMult(card, context)
					end
				end
			end
			card.ability.perma_bonus = (card.ability.perma_bonus or 0) + card.ability.extra.savedChips 
			card.ability.perma_mult = (card.ability.perma_mult or 0) + card.ability.extra.savedMult 	
			card.ability.perma_x_mult = (card.ability.perma_x_mult or 0) + card.ability.extra.savedXMult  
		end
		if context.after then
			card.ability.extra.prankTrigger = false
			if context.cardarea == G.play then
				card.ability.perma_bonus = card.ability.perma_bonus - card.ability.extra.savedChips 
				card.ability.perma_mult = card.ability.perma_mult - card.ability.extra.savedMult
				card.ability.perma_x_mult = card.ability.perma_x_mult - card.ability.extra.savedXMult 
			end
			card.ability.extra.savedChips = 0
			card.ability.extra.savedMult = 0
			card.ability.extra.savedXMult = 0
		end
	end,
}

return {
	name = "Enhancements",
	list = { sleight, }
}