local subdir = "src/seals/"
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)

for _, file in ipairs(files) do
  local seal = assert(SMODS.load_file(subdir .. file))()

	if seal.list and #seal.list > 0 then
		for _, item in pairs(seal.list) do
			SMODS.Seal(item)
		end
  end
end
