local M = {}

function M.setup()
	-- Samsung S24F350 — gauche
	hl.monitor({
		output = "DP-3",
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1",
	})

	-- Philips 247ELH — droite
	hl.monitor({
		output = "HDMI-A-3",
		mode = "1920x1080@60",
		position = "1920x0",
		scale = "1",
	})
end

return M
