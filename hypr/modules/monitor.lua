local hostname = io.popen("hostname"):read("*l")
local ok, monitors = pcall(require, "modules.monitors." .. hostname)

if not ok then
	-- fallback si hostname inconnu
	hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
	hl.notify("WARN", "monitor: pas de config pour " .. hostname .. ", fallback générique")
else
	monitors.setup()
end
