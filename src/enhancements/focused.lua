
local focused = {
	key = "focused",		
  atlas = "PlaceholderStallEnhancements",
	--artist = "Emma",
  pos = { x = 0, y = 0 },
	config = { bonus = 0, mult = 0, extra = {  jabChips = 10, hookMult = 2, jabChips_mod = 2, hookMult_mod = 1, jab = false, hook = false, combo = false, upgrades = 0}},
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
		
		return {vars = {abbr.jabChips, abbr.jabChips_mod, abbr.hookMult, abbr.hookMult_mod, (G.GAME.focused and G.GAME.focused.jab_rank.value or "Ace"), 
						(G.GAME.focused and G.GAME.focused.jab_suit[1].suit or "Spades"), (G.GAME.focused and G.GAME.focused.hook_rank.value or "King"),
						(G.GAME.focused and G.GAME.focused.hook_suit[1].suit or "Hearts"), colours = {G.C.SUITS[G.GAME.focused and G.GAME.focused.jab_suit[1].suit or "Spades"],
						G.C.SUITS[G.GAME.focused and G.GAME.focused.hook_suit[1].suit or "Hearts"]}}}
	end,

	in_pool = function(self, args) return false end,
	
	calculate = function(self, card, context)
		if not G.GAME.focused or G.GAME.focused.set ~= true then
			set_focused_vars()
		end
		
		if context.before then
			local jabrank, jabsuit, hookrank, hooksuit = false, false, false, false
			if G.hand and G.hand.cards then
				for i=1, #G.hand.cards do
					if G.hand.cards[i]:get_id() == G.GAME.focused.jab_rank.id then
						jabrank = true
					end
					if G.hand.cards[i]:is_suit(G.GAME.focused.jab_suit[1].suit) then
						jabsuit = true
					end
					if jabrank == true and jabsuit == true then
						card.ability.extra.jab = true
						break
					end
				end 	
			end
			for i, v in pairs(context.scoring_hand) do
				if v:get_id() == G.GAME.focused.hook_rank.id then
					hookrank = true
				end
				if v:is_suit(G.GAME.focused.hook_suit[1].suit) then
					hooksuit = true
				end
				if hookrank == true and hooksuit == true then
					card.ability.extra.hook = true
					break
				end
			end
			if card.ability.extra.jab == true and card.ability.extra.hook == true then
				card.ability.extra.combo = true
				
			end
			if card.ability.extra.jab == true then
				card.ability.bonus = card.ability.bonus + card.ability.extra.jabChips
			end
			if card.ability.extra.hook == true then
				card.ability.mult = card.ability.mult + card.ability.extra.hookMult
			end
		end
		
		if context.main_scoring and context.cardarea == G.play then
			if card.ability.extra.combo == true then
				local upgrade = pseudorandom('c-c-combo')
				if upgrade > .5 then
					card.ability.mult = card.ability.mult + card.ability.extra.hookMult_mod
					card.ability.extra.hookMult = card.ability.extra.hookMult + card.ability.extra.hookMult_mod
				else
					card.ability.bonus = card.ability.bonus + card.ability.extra.jabChips_mod
					card.ability.extra.jabChips = card.ability.extra.jabChips + card.ability.extra.jabChips_mod
				end
				card.ability.extra.upgrades = card.ability.extra.upgrades + 1 
				return {
					message = "C-C-Combo!"
				}
			end
			
		end
		
		if context.after then
			if card.ability.extra.jab == true then
				card.ability.bonus = card.ability.bonus - card.ability.extra.jabChips
			end
			if card.ability.extra.hook == true then
				card.ability.mult = card.ability.mult - card.ability.extra.hookMult
			end
			card.ability.extra.jab = false
			card.ability.extra.hook = false
			card.ability.extra.combo = false
		end
	end,
}

return {
	name = "Enhancements",
	list = { focused, }
}
