
--increases Toxic XMult by 0.05
toxic_scaling = function()
	if not G.GAME.toxic_triggered then
		G.GAME.current_round.toxic = {toxicXMult = 1, toxicMult_mod = 0.05}
	end
	G.GAME.current_round.toxic.toxicXMult = G.GAME.current_round.toxic.toxicXMult + G.GAME.current_round.toxic.toxicMult_mod
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


increment_item = function()
	if not G.GAME.total_items_used then
		G.GAME.total_items_used = 0
	end
	G.GAME.total_items_used = G.GAME.total_items_used + 1
end


function SMODS.current_mod.reset_game_globals(run_start)
	reset_toxic_scaling()
end

