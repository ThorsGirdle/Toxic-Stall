
pokermon.add_family({"paldean_wooper", "clodsire"})
pokermon.add_family({"foongus", "amoonguss"})
pokermon.add_family({"klink", "klang", "klinklang"})
pokermon.add_family({"skrelp", "dragalge"})
pokermon.add_family({"mareanie", "toxapex"})
pokermon.add_family({"dewpider", "araquanid"})
pokermon.add_family({"salandit", "salazzle"})
pokermon.add_family({"sandygast","palossand"})
pokermon.add_family({"rellor", "rabsca"})
pokermon.add_family({"varoom", "revavroom"})

stall_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
	pokermon_config = SMODS.Mods["Pokermon"].config
end

SMODS.Atlas({
    key = "StallEnhancements", 
    path = "StallEnhancements.png", 
    px = 71,
    py = 95, 
    --atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "StallConsumables", 
    path = "StallConsumables.png", 
    px = 71,
    py = 95, 
    --atlas_table = "ASSET_ATLAS"
})

assert(SMODS.load_file("functions/stall_functions.lua"))()

SMODS.current_mod.config_tab = function() 
    local evo_lines = {
			"paldean_wooper",
			"foongus",
			"klink",
			"skrelp",
			"mareanie",
			"dewpider",
			"salandit",
			"sandygast",
			"rellor",
			"varoom"
    }

    local nodes = {}

    for i = 1, #evo_lines do
        table.insert(nodes, create_toggle({
            label = localize(evo_lines[i].."_line"),
            ref_table = stall_config,
            ref_value = evo_lines[i]
        }))
    end

    return {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
        },
        nodes = nodes,
    }
end

--Load Joker Display if the mod is enabled
if (SMODS.Mods["JokerDisplay"] or {}).can_load then
  local jokerdisplays = NFS.getDirectoryItems(mod_dir.."jokerdisplay")

  for _, file in ipairs(jokerdisplays) do
    sendDebugMessage ("The file is: "..file)
    local helper, load_error = SMODS.load_file("jokerdisplay/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      helper()
    end
  end
end


--Load consumables
local pconsumables = NFS.getDirectoryItems(mod_dir.."consumables")

if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pconsumables) do
    sendDebugMessage ("The file is: "..file)
    local consumable, load_error = SMODS.load_file("consumables/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_consumable = consumable()
      if curr_consumable.init then curr_consumable:init() end
      
      for i, item in ipairs(curr_consumable.list) do
        if ((not pokermon_config.jokers_only and not item.pokeball) or (item.pokeball and pokermon_config.pokeballs)) or (item.evo_item and not pokermon_config.no_evos) then
          SMODS.Consumable(item)
        end
      end
    end
  end 
end

--Load enhancements
local enhancements = NFS.getDirectoryItems(mod_dir.."enhancements")

for _, file in ipairs(enhancements) do
  sendDebugMessage ("The file is: "..file)
  local enhancement, load_error = SMODS.load_file("enhancements/"..file)
  if load_error then
    sendDebugMessage ("The error is: "..load_error)
  else
    local curr_enhance = enhancement()
    if curr_enhance.init then curr_enhance:init() end
    
    for i, item in ipairs(curr_enhance.list) do
      item.discovered = not pokermon_config.pokemon_discovery
      SMODS.Enhancement(item)
    end
  end
end

local helper, load_error = SMODS.load_file("functions/stall_functions.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  helper()
end

  
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pfiles) do
    sendDebugMessage ("The file is: "..file)
    local pokemon, load_error = SMODS.load_file("pokemon/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_pokemon = pokemon()
      if curr_pokemon.init then curr_pokemon:init() end
      
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only  then
            item.discovered = true
            if not item.key then
              item.key = item.name
            end
            if not pokermon_config.no_evos and not item.custom_pool_func then
              item.in_pool = function(self)
                return pokemon_in_pool(self)
              end
            end
            if not item.config then
              item.config = {}
            end
            if item.ptype then
              if item.config and item.config.extra then
                item.config.extra.ptype = item.ptype
              elseif item.config then
                item.config.extra = {ptype = item.ptype}
              end
            end
            if not item.set_badges then
              item.set_badges = poke_set_type_badge
            end
            if item.item_req then
              if item.config and item.config.extra then
                item.config.extra.item_req = item.item_req
              elseif item.config then
                item.config.extra = {item_req = item.item_req}
              end
            end
            if item.evo_list then
              if item.config and item.config.extra then
                item.config.extra.evo_list = item.evo_list
              elseif item.config then
                item.config.extra = {item_req = item.evo_list}
              end
            end
            if pokermon_config.jokers_only and item.rarity == "poke_safari" then
              item.rarity = 3
            end
            item.discovered = not pokermon_config.pokemon_discovery 
            pokermon.Pokemon(item, "stall", nil)
          end
        end
      end
    end
  end
end 

