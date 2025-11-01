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

def_list["j_stall_varoom"] = {
	text = {			
		{ ref_table = "card.ability.extra", ref_value = "curr_retriggers", colour = G.C.ORANGE },
		{ text = " Retriggers", colour = G.C.ORANGE },
	}
}

def_list["j_stall_revavroom"] = {
	text = {			
		{ ref_table = "card.ability.extra", ref_value = "curr_retriggers", colour = G.C.ORANGE },
		{ text = " Retriggers", colour = G.C.ORANGE },
	}
}


return {
  name = "Toxic Stall JokerDisplay Definitions",
  dict = def_list
}