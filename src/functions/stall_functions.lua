
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
	G.GAME.toxic_cured = false
end

--scales Toxic by variable amount... should probably combine it with the other one but whatever
foongus_xmult = function(XMult)
	if not G.GAME.current_round.toxic then
		G.GAME.current_round.toxic = {toxicXMult = 1, toxicMult_mod = 0.05}
	end
	G.GAME.current_round.toxic.toxicXMult = G.GAME.current_round.toxic.toxicXMult + XMult
end

toxic_cure = function(card, number)
	card:set_ability(G.P_CENTERS.c_base, nil, true)
	if not G.GAME.toxic_cured then
		SMODS.calculate_effect({message = "Cured!"}, (G.deck and G.deck.cards and G.deck.cards[#G.deck.cards]) or card)
		G.GAME.toxic_cured = true
	end
end

set_toxic_rounds = function()
	if not G.GAME.toxic then
		G.GAME.toxic = {}
		G.GAME.toxic.set = true
		G.GAME.toxic.cureRounds = 8
	end
end

SMODS.current_mod.calculate = function(self, context)
	if context.end_of_round and context.main_eval and G.playing_cards then
		local reset = true
		for i, v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_stall_toxic") then
				if G.GAME.toxic.cureRounds <= 1 then
					local tempCard = v
					toxic_cure(tempCard)
				else
					G.GAME.toxic.cureRounds = G.GAME.toxic.cureRounds - 1
					reset = false
					SMODS.calculate_effect({message = "Toxic: "..G.GAME.toxic.cureRounds.."/8"}, (G.deck and G.deck.cards and G.deck.cards[#G.deck.cards]) or v)
					break
				end
			end
			if v.seal and v.seal == "stall_zeal" and v.config.center.key == "m_stall_brave" then
				v.ability.seal.bravePlayed = false
				v.ability.seal.braveShuffle = false
			end
		end
		if reset == true then
			G.GAME.toxic.cureRounds = 8
		end
	end
	
	if context.skip_blind then
		G.GAME.toxic.cureRounds = 8
	end
	
	if context.modify_scoring_hand then
		local foundRock = false
		for _, v in ipairs(context.full_hand) do
			if v.config.center.key == "m_stone" and v.seal and v.seal == "stall_zeal" then 
				foundRock = true
				break
			end
		end
		if foundRock == true then
			rockium_hand_limit(1)
		else
			rockium_hand_limit(-1)
		end
		if G.hand and G.hand.cards then
			for _, v in ipairs(G.hand.cards) do
				if SMODS.has_enhancement(v, "m_stall_gem") then 
					v.ability.extra.isScoring = false
				end
			end
		end
		for _, v in ipairs(context.scoring_hand) do
			if SMODS.has_enhancement(v, "m_stall_gem") then 
				v.ability.extra.isScoring = true
			end
		end
	end
	
	if context.setting_blind then
		if G.deck and G.deck.cards then
			for i,v in ipairs(G.deck.cards) do
				if SMODS.has_enhancement(v, "m_stall_vestige") then
					v.ability.extra.noRank = true
				end
			end
		end
	end
	
	if context.money_altered then
			local amount_gained = context.amount
			if (SMODS.Mods["Talisman"] or {}).can_load then amount_gained = to_number(amount_gained) end
      if amount_gained and amount_gained > 0 then
				G.GAME.current_round.amount_gained = (G.GAME.current_round.amount_gained or 0) + amount_gained
			end
		end
	if context.setting_blind then
		reset_money_earned()
	end
	
	if context.ante_change and context.ante_end then
		for i, v in ipairs(G.playing_cards) do
			if v.seal and v.seal == "stall_zeal" and v.config.center.key == "m_stall_brave" then
				v.ability.perma_x_mult = v.ability.perma_x_mult - (v.ability.seal.braveTriggers * v.ability.seal.braveXMult)
				v.ability.seal.braveTriggers = 0
			end
		end
	end
	
	if context.drawing_cards and G.deck and G.deck.cards then
		local shuffled = false
		for i, v in ipairs (G.deck.cards) do
			if v.seal and v.seal == "stall_zeal" and v.config.center.key == "m_stall_brave" and v.ability.seal.braveShuffle == true then
				v.ability.seal.braveShuffle = false
				if not shuffled then
					G.deck:shuffle("Flyinium")
					shuffled = true
				end
			end
		end
	end
	
end

--just espeon function but for yungoos
reset_yungoos_card = function()
  G.GAME.current_round.yungoos_rank = 'Ace'
  G.GAME.current_round.yungoos_id = 14
  G.GAME.current_round.yungoos_suit = 'Spades'
  if G.playing_cards then
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
		if hand[i]:is_suit(suit1, true) then
			suits[suit1] = suits[suit1] + 1
		end
		if hand[i]:is_suit(suit2, true) then
			suits[suit2] = suits[suit2] + 1
		end
	end
  
  if append_to_card then
    append_to_card.ability.extra.ancient_suits = suits
  end
  return suits
end

set_focused_vars = function()
	if not G.GAME.focused then
		G.GAME.focused = {}
		G.GAME.focused.set = true
		local rankdefault = {{value = "Ace", id = "14"}, {value = "King", id = "13"}}
		local ranks = pokermon.get_target_card_ranks("focused", 1, rankdefault, true)
		G.GAME.focused.combo_rank = ranks[1]
		G.GAME.focused.combo_suit = pokermon.get_target_card_suit("focused", true, "Spades", nil)
	end
end

rockium_hand_limit = function(change)
	if not G.GAME.current_round.rockium_selection then
		G.GAME.current_round.rockium_selection = 0
	end
	if change > 0 and G.GAME.current_round.rockium_selection < 1 then
		G.GAME.current_round.rockium_selection = G.GAME.current_round.rockium_selection + 1
		SMODS.change_play_limit(change)
	elseif change < 0 and G.GAME.current_round.rockium_selection >= 1 then
		G.GAME.current_round.rockium_selection = G.GAME.current_round.rockium_selection - 1
		SMODS.change_play_limit(change)
	end
end

-- so you dont get sick of the energize notification
set_gem_vars = function(bool)
	if not G.GAME.current_round.gem then
		G.GAME.current_round.gem = {}
		G.GAME.current_round.gem.set = true
		G.GAME.current_round.gem.energize = true
	end
	if bool then
		G.GAME.current_round.gem.energize = true
	else 
		G.GAME.current_round.gem.energize  = false
	end
end

reset_money_earned = function()
	G.GAME.current_round.amount_gained = 0
end


--hooks to dynamically adjust whether to show a Vestige card's Rank
local hookNoRanks = SMODS.has_no_rank
function SMODS.has_no_rank(card)
	if SMODS.has_enhancement(card, "m_stall_vestige") then
		return card.ability.extra.noRank
	else
		return hookNoRanks(card)	
	end
end

local hookReplaceBaseCard = Card.should_hide_front
function Card:should_hide_front()
	if SMODS.has_enhancement(self, "m_stall_vestige") then
		if self.ability and self.ability.extra and self.ability.extra.noRank and self.ability.extra.noRank == true then
			return true
		else 
			return false
		end
	end
	return hookReplaceBaseCard(self)
end

--additive XMult total
stall_get_total_XMult = function(card, context) -- very particular and liable to become obsolete. mostly just saving me from a nightmare of spaghetti code
	local flowerCheck = false
	local suit_number = next(SMODS.find_card('j_poke_roserade')) and 3 or 4
	local extra = 0
	if pokermon.suit_check(context.scoring_hand, suit_number) then
		if next(SMODS.find_card("j_poke_shaymin")) or next(SMODS.find_card("j_poke_shaymin_sky")) then
			extra = 1
		end
		flowerCheck = true
	end
	local total_XMult = 0
	if card.ability.perma_x_mult and card.ability.perma_x_mult > 0 then
		total_XMult	=	total_XMult	+ card.ability.perma_x_mult
	end
	if card.ability.Xmult and card.ability.Xmult > 1 then
		total_XMult	=	total_XMult	+ (card.ability.Xmult -1)
	end
	if card.edition and card.edition.x_mult and card.edition.x_mult > 1 then
		total_XMult	=	total_XMult	+ (card.edition.x_mult - 1)
	end
	if SMODS.has_enhancement(card, "m_stall_toxic") and G.GAME.current_round.toxic and G.GAME.current_round.toxic.toxicXMult and G.GAME.current_round.toxic.toxicXMult > 1 then
		total_XMult	=	total_XMult	+ (G.GAME.current_round.toxic.toxicXMult -1)
	end
	if flowerCheck == true and SMODS.has_enhancement(card, 'm_poke_flower') then
		total_XMult = total_XMult + (card.ability.Xmult_flower + extra - 1)
	end
	return total_XMult
end

function SMODS.current_mod.reset_game_globals(run_start)
	reset_toxic_scaling()
	reset_clue()
	set_gem_vars(true)
	reset_money_earned()
  if run_start then
    set_focused_vars()
		set_toxic_rounds()

  end
end

--this function and hook are taken from the TOGA's stuff mod so Flyinium doesnt crash at end of round
stall_isplayingcardarea = function(target)
	local t = {}
	t[#t+1] = G.play
	t[#t+1] = G.hand
	t[#t+1] = G.deck
	t[#t+1] = G.discard
	t[#t+1] = G.poke_scry
	-- TOGA-TARGET: add your own CardAreas for playing cards
	for i, v in ipairs(t) do
		if v == target then return true end
	end
	return false
end

sendInfoMessage("Hooking draw_card...", "TOGAPack")
local drawcardret = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	drawcardret(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	if stall_isplayingcardarea(to) and stall_isplayingcardarea(from) then SMODS.calculate_context({ individual_draw = true, from_area = from, to_area = to }) end
end


SMODS.current_mod.set_debuff = function(card)
	if card.config.center.key == "m_wild" and card.seal and card.seal == "stall_zeal" then 
		return 'prevent_debuff' 
	end
	return false
end



return {
  key = "STALL_FUNCTIONS",
  value = stall_functions
}
