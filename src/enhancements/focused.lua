
local focused = {
	key = "focused",		
  atlas = "PlaceholderStallEnhancements",
	--artist = "Emma",
  pos = { x = 0, y = 0 },
	config = { extra = {comboMult = 1, combo = false, upgrades = 0}},
	any_suit = false,
  replace_base_card = false,
  no_rank = false,
  no_suit = false,
  always_scores = false,
  unlocked = true,
  discovered = true,
  no_collection = false,
	weight = 0,

  loc_vars = function(self, info_queue, card)
		type_tooltip(self, info_queue, card)
		abbr = card.ability.extra
		
		return {vars = {abbr.comboMult, (G.GAME.focused and G.GAME.focused.combo_rank.value or "Ace"), 
						(G.GAME.focused and G.GAME.focused.combo_suit[1].suit or "Spades"), colours = {G.C.SUITS[G.GAME.focused and G.GAME.focused.combo_suit[1].suit or "Spades"]}}}
	end,

	in_pool = function(self, args) return false end,
	
	calculate = function(self, card, context)
		if not G.GAME.focused or G.GAME.focused.set ~= true then
			set_focused_vars()
		end
		
		if context.before then
			local comborank, combosuit = false, false
			for i, v in pairs(context.scoring_hand) do
				if v:get_id() == G.GAME.focused.combo_rank.id and not SMODS.has_no_rank(v) then
					comborank = true
				end
				if v:is_suit(G.GAME.focused.combo_suit[1].suit) and not SMODS.has_no_suit(v) then
					combosuit = true
				end
				if comborank == true and combosuit == true then
					card.ability.extra.combo = true
					break
				end
			end
		end
		
		if context.main_scoring and context.cardarea == G.play then
			if card.ability.extra.combo == true then
				card.ability.perma_mult = card.ability.perma_mult + card.ability.extra.comboMult
				card.ability.extra.upgrades = card.ability.extra.upgrades + 1
			end		 
			return {
				 message = localize('k_upgrade_ex'), 
				 colour = G.C.MULT
			}			
		end
		
		if context.after then
			card.ability.extra.combo = false
		end
	end,
}

return {
	name = "Enhancements",
	list = { focused, }
}
