return {
  pages = {
    {
      title = function() return localize("stall_regular_pokemon1") end,
      tiles = {
        { list = { "j_stall_klink", "j_stall_klang", "j_stall_klinklang" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_klink" } end, config_key = "Klink" },
        { list = { "j_stall_dewpider", "j_stall_araquanid" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_dewpider" } end, config_key = "Dewpider" },
        { list = { "j_stall_sandygast", "j_stall_palossand" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_sandygast" } end, config_key = "Sandygast" },
        { list = { "j_stall_rellor", "j_stall_rabsca" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_rellor" } end, config_key = "Rellor" },
      }
    },
    {
      title = function() return localize("stall_toxic_pokemon1") end,
      tiles = {
        { list = { "j_stall_paldean_wooper", "j_stall_clodsire" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_paldean_wooper" } end, config_key = "Paldean_Wooper" },
        { list = { "j_stall_foongus", "j_stall_amoonguss" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_foongus" } end, config_key = "Foongus" },
        { list = { "j_stall_skrelp", "j_stall_dragalge" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_skrelp" } end, config_key = "Skrelp" },
        { list = { "j_stall_mareanie", "j_stall_toxapex" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_mareanie" } end, config_key = "Mareanie" },
        { list = { "j_stall_salandit", "j_stall_salazzle" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_salandit" } end, config_key = "Salazzle" },
        { list = { "j_stall_varoom", "j_stall_revavroom" }, label = function() return localize { type = "name_text", set = "Joker", key = "j_stall_varoom" } end, config_key = "Varoom" },
      }
    },
  }
}