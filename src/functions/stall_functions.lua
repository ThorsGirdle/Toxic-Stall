
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
		G.FUNCS.draw_from_deck_to_hand(handsize)
	end
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
