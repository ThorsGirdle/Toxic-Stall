
--increases Toxic XMult by 0.05
toxic_scaling = function(amount)
if not amount then amount = 1 end
	if not G.GAME.toxic_triggered then
		G.GAME.current_round.toxic = {toxicXMult = 1, toxicMult_mod = 0.05}
	end
	G.GAME.current_round.toxic.toxicXMult = G.GAME.current_round.toxic.toxicXMult + G.GAME.current_round.toxic.toxicMult_mod * amount
end

reset_toxic_scaling = function()
	G.GAME.current_round.toxic = {toxicXMult = 1, toxicMult_mod = 0.05}
	G.GAME.toxic_triggered = false
end

--scales Toxic by variable amount... should probably combine it with the other one but whatever
foongus_xmult = function(XMult)
	if not G.GAME.current_round.toxic then
		G.GAME.current_round.toxic = {toxicXMult = 1, toxicMult_mod = 0.05}
	end
	G.GAME.current_round.toxic.toxicXMult = G.GAME.current_round.toxic.toxicXMult + XMult
end

--just espeon function but for yungoos
reset_yungoos_card = function()
  G.GAME.current_round.yungoos_rank = 'Ace'
  G.GAME.current_round.yungoos_id = 14
  G.GAME.current_round.yungoos_suit = 'Spades'
  
  local valid_yungoos_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
      valid_yungoos_cards[#valid_yungoos_cards + 1] = playing_card
    end
  end
  local yungoos_card = pseudorandom_element(valid_yungoos_cards, 'yungoos' .. G.GAME.round_resets.ante)
  if yungoos_card then
    G.GAME.current_round.yungoos_rank = yungoos_card.base.value
    G.GAME.current_round.yungoos_id = yungoos_card.base.id
    G.GAME.current_round.yungoos_suit = yungoos_card.base.suit
  end
end

--adds 1 handsize, capped to 10
clue_increment = function(handsize)
	if not G.GAME.current_round.clue_handsize then
		G.GAME.current_round.clue_handsize = 0
	end
	if G.GAME.current_round.clue_handsize < 10 then
		G.GAME.current_round.clue_handsize = G.GAME.current_round.clue_handsize + handsize
		G.hand:change_size(handsize)
		SMODS.draw_cards(handsize)
	end
end

reset_clue = function()
	if G.GAME.current_round.clue_handsize then
		G.hand:change_size(-G.GAME.current_round.clue_handsize)
		G.GAME.current_round.clue_handsize = 0
	end
end

--Taken directly from JokerDisplay's evaluate_hand function, ported to avoid dependency
stall_evaluate_hand = function(cards, count_facedowns)
    local valid_cards = cards
    local has_facedown = false

    if not cards then
        local hand_info = JokerDisplay.current_hand_info
        return hand_info.text, hand_info.poker_hands, hand_info.scoring_hand
    elseif type(cards) ~= "table" then
        return "Unknown", {}, {}
    end
    for i = 1, #cards do
        if type(cards[i]) ~= "table" or not cards[i].ability or not (cards[i].ability.set == 'Enhanced' or cards[i].ability.set == 'Default') then
            return "Unknown", {}, {}
        end
    end

    -- To prevent crashing during poker hand eval
    if G.play then
        for i = 1, #G.play.cards do
            if type(G.play.cards[i]) ~= "table" or not G.play.cards[i].ability or not (G.play.cards[i].ability.set == 'Enhanced' or G.play.cards[i].ability.set == 'Default') then
                return "Unknown", {}, {}
            end
        end
    end

    if not count_facedowns then
        valid_cards = {}
        for i = 1, #cards do
            if cards[i].facing and cards[i].facing ~= 'back' then
                table.insert(valid_cards, cards[i])
            else
                has_facedown = true
            end
        end
    else
        valid_cards = cards
    end

    local text, _, poker_hands, scoring_hand, _ = G.FUNCS.get_poker_hand_info(valid_cards)

    local final_scoring_hand = {}
    for i = 1, #valid_cards do
        local splashed = SMODS.always_scores(valid_cards[i]) or next(find_joker('Splash')) or next(find_joker('luvdisc')) or next(find_joker('magikarp')) or next(find_joker('feebas'))
        local unsplashed = SMODS.never_scores(valid_cards[i])
        if not splashed then
            for _, card in pairs(scoring_hand) do
                if card == valid_cards[i] then splashed = true end
            end
        end
        local effects = {}
        SMODS.calculate_context(
            {
                modify_scoring_hand = true,
                other_card = valid_cards[i],
                full_hand = valid_cards,
                scoring_hand =
                    scoring_hand
            }, effects)
        local flags = SMODS.trigger_effects(effects, valid_cards[i])
        flags = flags or {}
        if flags.add_to_hand then splashed = true end
        if flags.remove_from_hand then unsplashed = true end
        if splashed and not unsplashed then table.insert(final_scoring_hand, valid_cards[i]) end
    end

    return (has_facedown and "Unknown" or text), poker_hands, final_scoring_hand
end

get_ancient_suit_amount = function(hand, suit1, suit2, append_to_card)
	local suits = {
		[suit1] = 0,
		[suit2] = 0,
	}
	
	for i = 1, #hand do
		if not SMODS.has_any_suit(hand[i]) then
			if hand[i]:is_suit(suit1, true) then
				suits[suit1] = suits[suit1] + 1
			elseif hand[i]:is_suit(suit2, true) then
				suits[suit2] = suits[suit2] + 1
			end
		end
	end
	
	for i = 1, #hand do
		if SMODS.has_any_suit(hand[i]) then
			if hand[i]:is_suit(suit1, true) and (suits[suit1] == 1 or suits[suit1] == 2)  then
				suits[suit1] = suits[suit1] + 1
			elseif hand[i]:is_suit(suit2, true) and (suits[suit2] == 1 or suits[suit2] == 2)  then
				suits[suit2] = suits[suit2] + 1
			elseif hand[i]:is_suit(suit1, true) and suits[suit1] == 0  then
				suits[suit1] = suits[suit1] + 1
			elseif hand[i]:is_suit(suit2, true) and suits[suit2] == 0  then
				suits[suit2] = suits[suit2] + 1
			end
		end
	end
  
  if append_to_card then
    append_to_card.ability.extra.ancient_suits = suits
  end
  return suits
end


function SMODS.current_mod.reset_game_globals(run_start)
	reset_toxic_scaling()
	reset_clue()
end



return {
  key = "STALL_FUNCTIONS",
  value = stall_functions
}
