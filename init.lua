local addonName, ns = ...
local E, C, D, M, L, P = ns.E, ns.C, ns.D, ns.M, ns.L, ns.P

-- Lua
local _G = getfenv(0)
local type = _G.type
local next = _G.next

--[[ luacheck: globals
	LibStub
]]

-- Mine
local function cleanUpStep1()
	-- -> 80000.12
	if not C.db.profile.version or C.db.profile.version < 8000012 then
		if C.db.profile.units.player and C.db.profile.units.player.ls then
			E:CopyTable(C.db.profile.units.player.ls, C.db.profile.units.ls.player)

			C.db.profile.units.player.ls = nil
		end

		if C.db.profile.units.player and C.db.profile.units.player.traditional then
			E:CopyTable(C.db.profile.units.player.traditional, C.db.profile.units.traditional.player)

			C.db.profile.units.player.traditional = nil
		end

		if C.db.profile.units.pet and C.db.profile.units.pet.ls then
			E:CopyTable(C.db.profile.units.pet.ls, C.db.profile.units.ls.pet)

			C.db.profile.units.pet.ls = nil
		end

		if C.db.profile.units.pet and C.db.profile.units.pet.traditional then
			E:CopyTable(C.db.profile.units.pet.traditional, C.db.profile.units.traditional.pet)

			C.db.profile.units.pet.traditional = nil
		end

		local bars = {"bar1", "bar2", "bar3", "bar4", "bar5", "bar6", "bar7", "pet_battle", "extra",
		"zone"}

		for _, bar in next, bars do
			if C.db.profile.bars[bar] then
				if C.db.profile.bars[bar].cooldown then
					C.db.profile.bars[bar].cooldown.text.h_alignment = nil
				end
			end
		end

		C.db.profile.auras.HELPFUL.cooldown.text.h_alignment = nil
		C.db.profile.auras.HARMFUL.cooldown.text.h_alignment = nil
		C.db.profile.auras.TOTEM.cooldown.text.h_alignment = nil

		C.db.profile.blizzard.castbar.icon.enabled = nil
		C.db.profile.blizzard.castbar.text.flag = nil
	end
end

local function cleanUpStep2()
	if not C.db.profile.version or C.db.profile.version < 8000012 then
		local units = {"player", "pet", "target", "targettarget", "focustarget", "boss"}

		for _, unit in next, units do
			if C.db.profile.units[unit] then
				if C.db.profile.units[unit].castbar then
					C.db.profile.units[unit].castbar.icon.enabled = nil
					C.db.profile.units[unit].castbar.text.flag = nil
				end

				if C.db.profile.units[unit].debuff then
					C.db.profile.units[unit].debuff.h_alignment = nil
				end

				if C.db.profile.units[unit].auras then
					C.db.profile.units[unit].auras.cooldown.text.h_alignment = nil
				end
			end
		end
	end
end

local function addRefs()
	C.db.profile.units.player = C.db.profile.units[E.UI_LAYOUT].player
	C.db.profile.units.pet = C.db.profile.units[E.UI_LAYOUT].pet

	C.db.profile.colors.power[ 0] = C.db.profile.colors.power.MANA
	C.db.profile.colors.power[ 1] = C.db.profile.colors.power.RAGE
	C.db.profile.colors.power[ 2] = C.db.profile.colors.power.FOCUS
	C.db.profile.colors.power[ 3] = C.db.profile.colors.power.ENERGY
	C.db.profile.colors.power[ 4] = C.db.profile.colors.power.CHI
	C.db.profile.colors.power[ 5] = C.db.profile.colors.power.RUNES
	C.db.profile.colors.power[ 6] = C.db.profile.colors.power.RUNIC_POWER
	C.db.profile.colors.power[ 7] = C.db.profile.colors.power.SOUL_SHARDS
	C.db.profile.colors.power[ 8] = C.db.profile.colors.power.LUNAR_POWER
	C.db.profile.colors.power[ 9] = C.db.profile.colors.power.HOLY_POWER
	C.db.profile.colors.power[11] = C.db.profile.colors.power.MAELSTROM
	C.db.profile.colors.power[13] = C.db.profile.colors.power.INSANITY
	C.db.profile.colors.power[17] = C.db.profile.colors.power.FURY
	C.db.profile.colors.power[18] = C.db.profile.colors.power.PAIN

	C.db.profile.colors.selection[255 * 65536 + 255 * 256 + 139] = C.db.profile.colors.selection[1]
	C.db.profile.colors.selection[255 * 65536 + 255 * 256 +   0] = C.db.profile.colors.selection[2]
	C.db.profile.colors.selection[255 * 65536 + 129 * 256 +   0] = C.db.profile.colors.selection[3]
	C.db.profile.colors.selection[255 * 65536 +   0 * 256 +   0] = C.db.profile.colors.selection[4]
	C.db.profile.colors.selection[128 * 65536 + 128 * 256 + 128] = C.db.profile.colors.selection[5]
	C.db.profile.colors.selection[  0 * 65536 + 255 * 256 +   0] = C.db.profile.colors.selection[6]
	C.db.profile.colors.selection[  0 * 65536 +   0 * 256 + 255] = C.db.profile.colors.selection[7]
end

local function removeRefs()
	C.db.profile.units.player = nil
	C.db.profile.units.pet = nil

	C.db.profile.colors.power[ 0] = nil
	C.db.profile.colors.power[ 1] = nil
	C.db.profile.colors.power[ 2] = nil
	C.db.profile.colors.power[ 3] = nil
	C.db.profile.colors.power[ 4] = nil
	C.db.profile.colors.power[ 5] = nil
	C.db.profile.colors.power[ 6] = nil
	C.db.profile.colors.power[ 7] = nil
	C.db.profile.colors.power[ 8] = nil
	C.db.profile.colors.power[ 9] = nil
	C.db.profile.colors.power[11] = nil
	C.db.profile.colors.power[13] = nil
	C.db.profile.colors.power[17] = nil
	C.db.profile.colors.power[18] = nil

	C.db.profile.colors.selection[255 * 65536 + 255 * 256 + 139] = nil
	C.db.profile.colors.selection[255 * 65536 + 255 * 256 +   0] = nil
	C.db.profile.colors.selection[255 * 65536 + 129 * 256 +   0] = nil
	C.db.profile.colors.selection[255 * 65536 +   0 * 256 +   0] = nil
	C.db.profile.colors.selection[128 * 65536 + 128 * 256 + 128] = nil
	C.db.profile.colors.selection[  0 * 65536 + 255 * 256 +   0] = nil
	C.db.profile.colors.selection[  0 * 65536 +   0 * 256 + 255] = nil
end

local function updateAll()
	cleanUpStep1()
	addRefs()
	cleanUpStep2()

	P:UpdateModules()
	P.Movers:UpdateConfig()
end

E:RegisterEvent("ADDON_LOADED", function(arg1)
	if arg1 ~= addonName then return end

	C.db = LibStub("AceDB-3.0"):New("LS_UI_GLOBAL_CONFIG", D)
	LibStub("LibDualSpec-1.0"):EnhanceDatabase(C.db, "LS_UI_GLOBAL_CONFIG")

	-- layout type change shouldn't affect anything after SVs are loaded
	E.UI_LAYOUT = C.db.char.layout

	D.profile.units.player = D.profile.units[E.UI_LAYOUT].player
	D.profile.units.pet = D.profile.units[E.UI_LAYOUT].pet

	cleanUpStep1()
	addRefs()
	cleanUpStep2()

	C.db:RegisterCallback("OnDatabaseShutdown", function()
		C.db.char.version = E.VER.number
		C.db.profile.version = E.VER.number

		removeRefs()

		P.Movers:CleanUpConfig()
	end)

	C.db:RegisterCallback("OnProfileShutdown", function()
		C.db.profile.version = E.VER.number

		removeRefs()

		P.Movers:CleanUpConfig()
	end)

	C.db:RegisterCallback("OnProfileChanged", updateAll)
	C.db:RegisterCallback("OnProfileCopied", updateAll)
	C.db:RegisterCallback("OnProfileReset", updateAll)

	E:RegisterEvent("PLAYER_LOGIN", function()
		E:UpdateConstants()

		P:InitModules()
	end)

	-- No one needs to see these
	ns.C, ns.D, ns.L, ns.P = nil, nil, nil, nil
end)
