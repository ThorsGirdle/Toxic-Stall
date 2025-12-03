local def_list = {}

--def_list["j_stall_paldean_wooper"] = {


def_list["j_stall_foongus"] = {
	text = {	
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "Xmult_mod"  },
			},
		},
	},
}

def_list["j_stall_amoonguss"] = {
	text = {	
		{
			border_nodes = {
				{ text = "X",  },
				{ ref_table = "card.ability.extra", ref_value = "Xmult_mod" },
			},
		},
		{text = " "},
    { text = "+", colour = G.C.MULT },
    { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT }
	},
}

def_list["j_stall_klink"] = {
	text = {			
		{ text = "$", colour = G.C.GOLD },
		{ ref_table = "card.ability.extra", ref_value = "money", colour = G.C.GOLD  },
		{ text = " " },
		{ref_table = "card.joker_display_values", ref_value = "draws", colour = G.C.GREY}
	},
	calc_function = function(card)
		card.joker_display_values.draws = card.ability.extra.to_draw - card.ability.extra.drawn
	end
}

def_list["j_stall_klang"] = {
	text = {			
		{ text = "$", colour = G.C.GOLD },
		{ ref_table = "card.ability.extra", ref_value = "money", colour = G.C.GOLD  },
		{ text = " " },
		{ref_table = "card.joker_display_values", ref_value = "draws", colour = G.C.GREY}
	},
	calc_function = function(card)
		card.joker_display_values.draws = card.ability.extra.to_draw - card.ability.extra.drawn
	end
}

def_list["j_stall_klinklang"] = {
	text = {			
		{ text = "$", colour = G.C.GOLD },
		{ ref_table = "card.ability.extra", ref_value = "money", colour = G.C.GOLD  },
		{ text = " " },
		{ ref_table = "card.joker_display_values", ref_value = "draws", colour = G.C.GREY}
	},
	reminder_text = {
		{
			border_nodes = {
				{text = "X", colour = G.C.WHITE},
				{ref_table = "card.ability.extra", ref_value = "Xmult", colour = G.C.WHITE},
			},
		},
		{text = " "},
		{ref_table = "card.joker_display_values", ref_value = "acroDraws", colour = G.C.GREY },
		{text = " "},
		{ref_table = "card.joker_display_values", ref_value = "status", colour = G.C.GREY },
	},	
	calc_function = function(card)
		card.joker_display_values.draws = card.ability.extra.to_draw - card.ability.extra.drawn
		card.joker_display_values.acroDraws = math.max(card.ability.extra.totalTarget - card.ability.extra.totaldrawn, 0)
		local status = "Inactive"
		if card.joker_display_values.acroDraws == 0 then
			status = "Active!" 
		else 
			status = "Inactive"
		end
		card.joker_display_values.status = status
	end
}
def_list["j_stall_diggersby"] = {
	text = {		
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.ability.extra", ref_value = "Xmult" },
			},
		},
	},
}

def_list["j_stall_rowlet"] = {
  text = {
		{ text = "Next: ", colour = G.C.GREY},
    { ref_table = "card.ability.extra", ref_value = "next_poker_hand", colour = G.C.GREY },
  },
  extra = {
    {
		{ text = "Current: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
    },
  },
}

def_list["j_stall_dartrix"] = {
  text = {
		{ text = "Next: ", colour = G.C.GREY},
    { ref_table = "card.ability.extra", ref_value = "next_poker_hand", colour = G.C.GREY },
  },
  extra = {
    {
		{ text = "Current: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
    },
  },
}

def_list["j_stall_rowlet_alt"] = {
  text = {
		{ text = "Next: ", colour = G.C.GREY},
    { ref_table = "card.ability.extra", ref_value = "next_poker_hand", colour = G.C.GREY },
  },
  extra = {
    {
		{ text = "Current: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
    },
  },
}

def_list["j_stall_dartrix_alt"] = {
  text = {
		{ text = "Next: ", colour = G.C.GREY},
    { ref_table = "card.ability.extra", ref_value = "next_poker_hand", colour = G.C.GREY },
  },
  extra = {
    {
		{ text = "Current: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
    },
  },
}

def_list["j_stall_decidueye_alt"] = {
  text = {
      { text = "Next: ", colour = G.C.GREY},
      { ref_table = "card.ability.extra", ref_value = "next_poker_hand", colour = G.C.GREY },
    },
  extra = {
    {
      { text = "Current: ", colour = G.C.GREY },
      { ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
    },
		{
			{ text = "Prev: ", colour = G.C.GREY },
			{ ref_table = "card.ability.extra", ref_value = "prev_poker_hand", colour = G.C.GREY }
		},
	},
}

def_list["j_stall_popplio"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_brionne"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_primarina"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_popplio_alt"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_brionne_alt"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_primarina_alt"] = {
  text = {
		{ text = "Target: ", colour = G.C.GREY },
		{ ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.GREY },
  },
}

def_list["j_stall_yungoos"] = {
	text = {		
		
		{ ref_table = "card.joker_display_values", ref_value = "rank", colour = G.C.ORANGE},
		{ text = " of ", colour = G.C.ORANGE },
		{ ref_table = "card.joker_display_values", ref_value = "suit", colour = G.C.ORANGE},
	},
	calc_function = function(card)
		card.joker_display_values.rank = (G.GAME.current_round.yungoos_rank or "Ace")
		card.joker_display_values.suit = (G.GAME.current_round.yungoos_suit or "Spades")
		--card.joker_display_values.colour = {G.C.SUITS[G.GAME.current_round.yungoos_suit or "Spades"]}
	end
}

def_list["j_stall_gumshoos"] = {
	text = {		
		
		{ ref_table = "card.ability.extra", ref_value = "rank", colour = G.C.ORANGE},
		{ text = " of ", colour = G.C.ORANGE },
		{ ref_table = "card.ability.extra", ref_value = "suit", colour = G.C.ORANGE},
	},
}

def_list["j_stall_mareanie"] = {
	text = {		
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "Xmult" },
			},
		},
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and (SMODS.has_enhancement(playing_card, "m_poke_hazard") or SMODS.has_enhancement(playing_card, "m_stall_toxic") ) then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.Xmult = 1 + (count * card.ability.extra.Xmult)
  end
}

def_list["j_stall_toxapex"] = {
	text = {		
		{
			border_nodes = {
				{ text = "X" },
				{ ref_table = "card.joker_display_values", ref_value = "Xmult" },
			},
		},
	},
	calc_function = function(card)
		local playing_hand = next(G.play.cards)
		local count = 0
		for _, playing_card in ipairs(G.hand.cards) do
			if playing_hand or not playing_card.highlighted then
				if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and (SMODS.has_enhancement(playing_card, "m_poke_hazard") or SMODS.has_enhancement(playing_card, "m_stall_toxic") ) then
					count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
				end
			end
		end
		card.joker_display_values.Xmult = 1 + (count * card.ability.extra.Xmult)
  end
	
}

def_list["j_stall_dewpider"] = {
	text = {			
		{ text = "[", colour = G.C.ORANGE },
		{ ref_table = "card.ability.extra", ref_value = "minSum", colour = G.C.ORANGE },
		{ text = "-", colour = G.C.ORANGE },
		{ ref_table = "card.joker_display_values", ref_value = "maxSum", colour = G.C.ORANGE },
		{ text = "]", colour = G.C.ORANGE },
		{ text = " " },
		{ text = "+", colour = G.C.MULT },
		{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
	},
	calc_function = function(card)
		card.joker_display_values.maxSum = card.ability.extra.minSum + 4
	end
}

def_list["j_stall_araquanid"] = {
	text = {			
		{ text = "[", colour = G.C.ORANGE },
		{ ref_table = "card.ability.extra", ref_value = "minSum", colour = G.C.ORANGE },
		{ text = "-", colour = G.C.ORANGE },
		{ ref_table = "card.joker_display_values", ref_value = "maxSum", colour = G.C.ORANGE },
		{ text = "]", colour = G.C.ORANGE },
		{ text = " " },
		{ text = "+", colour = G.C.MULT },
		{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
	},
	calc_function = function(card)
		card.joker_display_values.maxSum = card.ability.extra.minSum + 4
	end
}

def_list["j_stall_salazzle"] = {
	text = {		
		{
			border_nodes = {
				{ text = "+X" },
				{ ref_table = "card.ability.extra", ref_value = "drainedMult" },
			},
		},
	},
}

def_list["j_stall_sandygast"] = {
	text = {		
		{ text = "+", colour = G.C.CHIPS },
		{ ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS},
	}
}

def_list["j_stall_palossand"] = {
	text = {		
		{ text = "+", colour = G.C.CHIPS },
		{ ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS},
	}
}
--[[ weird stuff be happenin'
def_list["j_stall_varoom"] = {
	text = {		
		{ text = " +", colour = G.C.MULT },	
		{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
		
	}
}

def_list["j_stall_revavroom"] = {
	text = {			
		{ text = " +", colour = G.C.MULT },	
		{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
	}
}
--]]

return {
  name = "Toxic Stall JokerDisplay Definitions",
  dict = def_list
}