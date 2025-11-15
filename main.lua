STALL = {}

stall_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = { quantum_enhancements = true, post_trigger = true }

assert(SMODS.load_file("src/functions.lua"))()
assert(SMODS.load_file("src/sprites.lua"))()
assert(SMODS.load_file("src/pokemon.lua"))()
assert(SMODS.load_file("src/enhancements.lua"))()
assert(SMODS.load_file("src/consumables.lua"))()
assert(SMODS.load_file("src/settings.lua"))()

if (SMODS.Mods["JokerDisplay"] or {}).can_load then
  assert(SMODS.load_file("src/jokerdisplay.lua"))()

end

if stall_config.Spinarak == true then
	SMODS.Joker:take_ownership('poke_spinarak', 
			{ 
		aux_poke = true,
			no_collection = true,
			custom_pool_func = true,
			in_pool = function(self)
					return false
			end,
			
			},
		 true
	)

	SMODS.Joker:take_ownership('poke_ariados', 
			{ 
		aux_poke = true,
			no_collection = true,
			custom_pool_func = true,
			in_pool = function(self)
					return false
			end,
			
			},
		 true
	)
end