local subdir = "src/enhancements/"
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)

for _, file in ipairs(files) do
  local enhancement = assert(SMODS.load_file(subdir .. file))()

	if enhancement.list and #enhancement.list > 0 then
		for _, item in pairs(enhancement.list) do
			SMODS.Enhancement(item)
		end
  end
end