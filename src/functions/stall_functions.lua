
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

--hook for Rellor counting Items used this run
local set_consumeable_usage_ref = set_consumeable_usage
function set_consumeable_usage(card)
    local ret = set_consumeable_usage_ref(card)
    if card.config.center.set == 'Item' then
        G.GAME.consumeable_usage_total.stall_item = (G.GAME.consumeable_usage_total.stall_item or 0) + 1
    end
    return ret
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

--get_poke_target_card_ranks but with suits, simple enough
get_poke_target_card_suits = function(seed, num, default, use_deck)
  local target_suits = {}
  local valid_cards = {}
  if not G.playing_cards then
    return default
  end
  if use_deck then
    for i = 1, num do
      for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            local already_picked = false
            for j = 1, #target_suits do
              if target_suits[j].base.suit == v.base.suit then already_picked = true; break end
            end
            if not already_picked then
              valid_cards[#valid_cards+1] = v
            end
        end
      end
      if #valid_cards > 0 then
        local picked = pseudorandom_element(valid_cards, pseudoseed(seed))
        target_suits[#target_suits+1] = {value = picked.base.suit}
        valid_cards = {}
      elseif #target_suits > 0 then
        target_suits[#target_suits+1] = target_suits[1]
      else
         target_suits[#target_suits+1] = {value = "Spades"}
      end
    end
  else
    local random = {}
    local cvalue = nil
    for i = 1, 4 do
      if i == 1 then cvalue = "Spades"
      elseif i == 2 then cvalue = "Hearts"
      elseif i == 3 then cvalue = "Clubs"
      elseif i == 4 then cvalue = "Diamonds"
      end
      random[#random+1] = {value = cvalue}
    end
    --local args = {array = random, amt = num}
    --target_suits = pseudorandom_multi(args)
		pseudoshuffle(random, pseudoseed('default'))
		target_suits = random[1]
  end
  --local sort_function = function(card1, card2) return card1.sortNum < card2.sortNum end
  --table.sort(target_suits, sort_function)
  return target_suits
end

reset_clue = function()
	if G.GAME.current_round.clue_handsize then
		G.hand:change_size(-G.GAME.current_round.clue_handsize)
		G.GAME.current_round.clue_handsize = 0
	end
end

function SMODS.current_mod.reset_game_globals(run_start)
	reset_toxic_scaling()
	reset_clue()
end



return {
  key = "STALL_FUNCTIONS",
  value = stall_functions
}
