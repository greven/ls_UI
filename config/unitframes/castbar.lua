local _, ns = ...
local E, C, M, L, P, D, oUF = ns.E, ns.C, ns.M, ns.L, ns.P, ns.D, ns.oUF
local CONFIG = P:GetModule("Config")
local UNITFRAMES = P:GetModule("UnitFrames")

-- Lua
local _G = getfenv(0)

-- Mine
local offsets = {"", "   ", "      "}
local function d(c, o, v)
	print(offsets[o].."|cff"..c..v.."|r")
end

local orders = {0, 0, 0}

local function reset(order)
	orders[order] = 1
	-- d("d20000", order, orders[order])
	return orders[order]
end

local function inc(order)
	orders[order] = orders[order] + 1
	-- d("00d200", order, orders[order])
	return orders[order]
end

function CONFIG:CreateUnitFrameCastbarPanel(order, unit)
	local temp = {
		order = order,
		type = "group",
		name = L["CASTBAR"],
		get = function(info)
			return C.db.profile.units[unit].castbar[info[#info]]
		end,
		set = function(info, value)
			if C.db.profile.units[unit].castbar[info[#info]] ~= value then
				C.db.profile.units[unit].castbar[info[#info]] = value

				UNITFRAMES:For(unit, "UpdateCastbar")
			end
		end,
		args = {
			enabled = {
				order = reset(1),
				type = "toggle",
				name = L["ENABLE"],
			},
			reset = {
				type = "execute",
				order = inc(1),
				name = L["RESTORE_DEFAULTS"],
				confirm = CONFIG.ConfirmReset,
				func = function()
					CONFIG:CopySettings(D.profile.units[unit].castbar, C.db.profile.units[unit].castbar)
					UNITFRAMES:For(unit, "UpdateCastbar")
				end,
			},
			spacer_1 = {
				order = inc(1),
				type = "description",
				name = " ",
			},
			latency = {
				order = inc(1),
				type = "toggle",
				name = L["LATENCY"],
				set = function(_, value)
					if C.db.profile.units[unit].castbar.latency ~= value then
						C.db.profile.units[unit].castbar.latency = value

						UNITFRAMES:For(unit, "For", "Castbar", "UpdateConfig")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateLatency")
					end
				end,
			},
			spacer_2 = {
				order = inc(1),
				type = "description",
				name = " ",
			},
			detached = {
				order = inc(1),
				type = "toggle",
				name = L["DETACH_FROM_FRAME"],
			},
			width_override = {
				order = inc(1),
				type = "range",
				name = L["WIDTH_OVERRIDE"],
				desc = L["SIZE_OVERRIDE_DESC"],
				min = 0, max = 1024, step = 2,
				softMin = 96,
				disabled = function()
					return not C.db.profile.units[unit].castbar.detached
				end,
				set = function(info, value)
					if C.db.profile.units[unit].castbar.width_override ~= value then
						if value < info.option.softMin then
							value = info.option.min
						end

						C.db.profile.units[unit].castbar.width_override = value

						UNITFRAMES:For(unit, "For", "Castbar", "UpdateConfig")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateSize")
					end
				end,
			},
			height = {
				order = inc(1),
				type = "range",
				name = L["HEIGHT"],
				min = 8, max = 32, step = 4,
				set = function(_, value)
					if C.db.profile.units[unit].castbar.height ~= value then
						C.db.profile.units[unit].castbar.height = value

						UNITFRAMES:For(unit, "For", "Castbar", "UpdateConfig")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateSize")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateIcon")
					end
				end,
			},
			icon = {
				order = inc(1),
				type = "select",
				name = L["ICON"],
				values = CONFIG.CASTBAR_ICON_POSITIONS,
				get = function()
					return C.db.profile.units[unit].castbar.icon.position
				end,
				set = function(_, value)
					if C.db.profile.units[unit].castbar.icon.position ~= value then
						C.db.profile.units[unit].castbar.icon.position = value

						UNITFRAMES:For(unit, "For", "Castbar", "UpdateConfig")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateIcon")
					end
				end,
			},
			text = {
				order = inc(1),
				type = "range",
				name = L["BAR_TEXT"],
				min = 8, max = 32, step = 1,
				get = function()
					return C.db.profile.units[unit].castbar.text.size
				end,
				set = function(_, value)
					if C.db.profile.units[unit].castbar.text.size ~= value then
						C.db.profile.units[unit].castbar.text.size = value

						UNITFRAMES:For(unit, "For", "Castbar", "UpdateConfig")
						UNITFRAMES:For(unit, "For", "Castbar", "UpdateFonts")
					end
				end,
			},
		},
	}

	if unit ~= "player" then
		temp.args.latency = nil
		temp.args.spacer_2 = nil
	end

	if E.UI_LAYOUT == "ls" and (unit == "player" or unit == "pet") then
		temp.args.detached = nil
		temp.args.width_override.name = L["WIDTH"]
		temp.args.width_override.desc = nil
	end

	return temp
end
