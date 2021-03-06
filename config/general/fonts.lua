local _, ns = ...
local E, C, M, L, P, D, oUF = ns.E, ns.C, ns.M, ns.L, ns.P, ns.D, ns.oUF
local CONFIG = P:GetModule("Config")

-- Lua
local _G = getfenv(0)

--[[ luacheck: globals
]]

-- Mine
local LSM = LibStub("LibSharedMedia-3.0")

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

local function getOptions(order, name)
	local temp = {
		order = order,
		type = "group",
		inline = true,
		name = "",
		args = {
			font = {
				order = reset(2),
				type = "select",
				name = name,
				width = 1.25,
				dialogControl = "LSM30_Font",
				values = LSM:HashTable("font"),
				get = function(info)
					return LSM:IsValid("font", C.db.global.fonts[info[#info - 1]].font)
						and C.db.global.fonts[info[#info - 1]].font or LSM:GetDefault("font")
				end,
			},
			outline = {
				order = inc(2),
				type = "toggle",
				name = L["OUTLINE"],
			},
			shadow = {
				order = inc(2),
				type = "toggle",
				name = L["SHADOW"],
			},
		},
	}

	return temp
end

function CONFIG:CreateGeneralFontsPanel(order)
	C.options.args.general.args.fonts = {
		order = order,
		type = "group",
		name = L["FONTS"],
		get = function(info)
			return C.db.global.fonts[info[#info - 1]][info[#info]]
		end,
		set = function(info, value)
			if C.db.global.fonts[info[#info - 1]][info[#info]] ~= value then
				C.db.global.fonts[info[#info - 1]][info[#info]] = value

				E.FontStrings:UpdateAll(info[#info - 1])
			end
		end,
		args = {
			cooldown = getOptions(reset(1), L["COOLDOWNS"]),
			button = getOptions(inc(1), L["BUTTONS"]),
			unit = getOptions(inc(1), L["UNIT_FRAME"]),
			statusbar = getOptions(inc(1), L["PROGRESS_BARS"]),
		},
	}
end
