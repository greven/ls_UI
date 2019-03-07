local _, ns = ...
local E, C, M, L, P = ns.E, ns.C, ns.M, ns.L, ns.P
local MODULE = P:GetModule("Blizzard")

-- Lua
local _G = getfenv(0)
local hooksecurefunc = _G.hooksecurefunc
local next = _G.next
local s_trim = _G.string.trim
local s_upper = _G.string.upper

-- Blizz
local C_Timer = _G.C_Timer

--[[ luacheck: globals
	CharacterBackSlot CharacterChestSlot CharacterFeetSlot CharacterFinger0Slot CharacterFinger1Slot CharacterFrame
	CharacterHandsSlot CharacterHeadSlot CharacterLegsSlot CharacterMainHandSlot CharacterModelFrame CharacterNeckSlot
	CharacterSecondaryHandSlot CharacterShirtSlot CharacterShoulderSlot CharacterStatsPane CharacterTabardSlot
	CharacterTrinket0Slot CharacterTrinket1Slot CharacterWaistSlot CharacterWristSlot GetInventoryItemLink
	GetInventoryItemTexture HideUIPanel PaperDollEquipmentManagerPane PaperDollInnerBorderBottom
	PaperDollInnerBorderBottom2 PaperDollInnerBorderBottomLeft PaperDollInnerBorderBottomRight PaperDollInnerBorderLeft
	PaperDollInnerBorderRight PaperDollInnerBorderTop PaperDollInnerBorderTopLeft PaperDollInnerBorderTopRight
	PaperDollTitlesPane
]]

-- Mine
local isInit = false

local EQUIP_SLOTS = {
	[ 1] = "CharacterHeadSlot",
	[ 2] = "CharacterNeckSlot",
	[ 3] = "CharacterShoulderSlot",
	[ 5] = "CharacterChestSlot",
	[ 6] = "CharacterWaistSlot",
	[ 7] = "CharacterLegsSlot",
	[ 8] = "CharacterFeetSlot",
	[ 9] = "CharacterWristSlot",
	[10] = "CharacterHandsSlot",
	[11] = "CharacterFinger0Slot",
	[12] = "CharacterFinger1Slot",
	[13] = "CharacterTrinket0Slot",
	[14] = "CharacterTrinket1Slot",
	[15] = "CharacterBackSlot",
	[16] = "CharacterMainHandSlot",
	[17] = "CharacterSecondaryHandSlot",
}

local function scanSlot(slotID)
	local link = GetInventoryItemLink("player", slotID)
	if link then
		return true, E:GetItemEnchantGemInfo(link)
	elseif GetInventoryItemTexture("player", slotID) then
		return false, "", "", "", ""
	end

	return true, "", "", "", ""
end

local function updateSlot(slotID)
	local isOk, enchant, gem1, gem2, gem3 = scanSlot(slotID)
	if isOk then
		_G[EQUIP_SLOTS[slotID]].EnchantText:SetText(enchant)
		_G[EQUIP_SLOTS[slotID]].GemText:SetText(s_trim(gem1 .. gem2 .. gem3))
	else
		C_Timer.After(0.33, function() updateSlot(slotID) end)
	end
end

	local scanComplete, isOk, enchant, gem1, gem2, gem3 = true
	for slotID, slotName in next, EQUIP_SLOTS do
		isOk, enchant, gem1, gem2, gem3 = scanSlot(slotID)

		_G[slotName].EnchantText:SetText(enchant)
		_G[slotName].GemText:SetText(s_trim(gem1 .. gem2 .. gem3))

		scanComplete = scanComplete and isOk
	end

	if not scanComplete then
		C_Timer.After(0.33, scanAllSlots)
	end
end

local INV_SLOTS = {
	[CharacterBackSlot] = true,
	[CharacterChestSlot] = true,
	[CharacterFeetSlot] = false,
	[CharacterFinger0Slot] = false,
	[CharacterFinger1Slot] = false,
	[CharacterHandsSlot] = false,
	[CharacterHeadSlot] = true,
	[CharacterLegsSlot] = false,
	[CharacterMainHandSlot] = false,
	[CharacterNeckSlot] = true,
	[CharacterSecondaryHandSlot] = true,
	[CharacterShirtSlot] = true,
	[CharacterShoulderSlot] = true,
	[CharacterTabardSlot] = true,
	[CharacterTrinket0Slot] = false,
	[CharacterTrinket1Slot] = false,
	[CharacterWaistSlot] = false,
	[CharacterWristSlot] = true,
}

local RIGHT_PANES = {
	-- CharacterStatsPane,
	PaperDollTitlesPane,
	PaperDollEquipmentManagerPane,
}

local SLOT_TEXTURES_TO_REMOVE = {
	["410248"] = true,
	["INTERFACE\\CHARACTERFRAME\\CHAR-PAPERDOLL-PARTS"] = true,
}

local TEXTURES_TO_REMOVE = {
	CharacterModelFrame.BackgroundBotLeft,
	CharacterModelFrame.BackgroundBotRight,
	CharacterModelFrame.BackgroundOverlay,
	CharacterModelFrame.BackgroundTopLeft,
	CharacterModelFrame.BackgroundTopRight,
	CharacterStatsPane.ClassBackground,
	PaperDollInnerBorderBottom,
	PaperDollInnerBorderBottom2,
	PaperDollInnerBorderBottomLeft,
	PaperDollInnerBorderBottomRight,
	PaperDollInnerBorderLeft,
	PaperDollInnerBorderRight,
	PaperDollInnerBorderTop,
	PaperDollInnerBorderTopLeft,
	PaperDollInnerBorderTopRight,
}

function MODULE:HasCharacterFrame()
	return isInit
end

function MODULE:SetUpCharacterFrame()
	if not isInit and C.db.char.blizzard.character_frame.enabled then
		if CharacterFrame:IsShown() then
			HideUIPanel(CharacterFrame)
		end

		for slot, textOnRight in next, INV_SLOTS do
			for _, v in next, {slot:GetRegions()} do
				if v:IsObjectType("Texture") and SLOT_TEXTURES_TO_REMOVE[s_upper(v:GetTexture() or "")] then
					v:SetTexture(nil)
					v:Hide()
				end
			end

			E:SkinInvSlotButton(slot)
			slot:SetSize(36, 36)

			local enchText = slot:CreateFontString(nil, "ARTWORK", "LSFont10_Outline")
			enchText:SetSize(160, 22)
			enchText:SetJustifyH(textOnRight and "LEFT" or "RIGHT")
			enchText:SetJustifyV("TOP")
			enchText:SetTextColor(0, 1, 0)
			slot.EnchantText = enchText

			local gemText = slot:CreateFontString(nil, "ARTWORK", "LSIcon14Font")
			gemText:SetSize(157, 14)
			gemText:SetJustifyH(textOnRight and "LEFT" or "RIGHT")
			slot.GemText = gemText

			if textOnRight then
				enchText:SetPoint("TOPLEFT", slot, "TOPRIGHT", 4, 0)
				gemText:SetPoint("BOTTOMLEFT", slot, "BOTTOMRIGHT", 7, 0)
			else
				enchText:SetPoint("TOPRIGHT", slot, "TOPLEFT", -4, 0)
				gemText:SetPoint("BOTTOMRIGHT", slot, "BOTTOMLEFT", -7, 0)
			end
		end

		CharacterHeadSlot:SetPoint("TOPLEFT", CharacterFrame.Inset, "TOPLEFT", 6, -6)
		CharacterHandsSlot:SetPoint("TOPRIGHT", CharacterFrame.Inset, "TOPRIGHT", -6, -6)
		CharacterMainHandSlot:SetPoint("BOTTOMLEFT", CharacterFrame.Inset, "BOTTOMLEFT", 176, 5)
		CharacterSecondaryHandSlot:ClearAllPoints()
		CharacterSecondaryHandSlot:SetPoint("BOTTOMRIGHT", CharacterFrame.Inset, "BOTTOMRIGHT", -176, 5)

		CharacterModelFrame:SetSize(0, 0)
		CharacterModelFrame:SetAllPoints(CharacterFrame.Inset)

		for _, texture in next, TEXTURES_TO_REMOVE do
			texture:SetTexture(nil)
			texture:Hide()
		end

		PaperDollEquipmentManagerPane.EquipSet:SetPoint("TOPLEFT", 2, 0)

		for _, pane in next, RIGHT_PANES do
			pane:SetSize(0, 0)
			pane:SetPoint("TOPLEFT", CharacterFrame.InsetRight, "TOPLEFT", 3, -2)
			pane:SetPoint("BOTTOMRIGHT", CharacterFrame.InsetRight, "BOTTOMRIGHT", -21, 4)

			pane.scrollBar:SetPoint("TOPLEFT", pane, "TOPRIGHT", 0, -18)
			pane.scrollBar:SetPoint("BOTTOMLEFT", pane, "BOTTOMRIGHT", 0, 13)

			for _, button in next, pane.buttons do
				button:SetWidth(0)
				button:SetPoint("RIGHT", 2, 0)

				button.BgTop:SetTexture(nil)
				button.BgBottom:SetTexture(nil)
				button.BgMiddle:SetTexture(nil)
			end
		end

		hooksecurefunc("CharacterFrame_Expand", function()
			CharacterFrame:SetSize(640, 431) -- 540 + 100, 424 + 7
			CharacterFrame.Inset:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMLEFT", 432, 4)

			CharacterFrame.Inset.Bg:SetTexture("Interface\\DressUpFrame\\DressingRoom" .. E.PLAYER_CLASS)
			CharacterFrame.Inset.Bg:SetTexCoord(1 / 512, 479 / 512, 46 / 512, 455 / 512)
			CharacterFrame.Inset.Bg:SetHorizTile(false)
			CharacterFrame.Inset.Bg:SetVertTile(false)

			scanAllSlots()
		end)

		hooksecurefunc("CharacterFrame_Collapse", function()
			CharacterFrame:SetHeight(424)
			CharacterFrame.Inset:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMLEFT", 332, 4)

			CharacterFrame.Inset.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Marble", "REPEAT", "REPEAT")
			CharacterFrame.Inset.Bg:SetTexCoord(0, 1, 0, 1)
			CharacterFrame.Inset.Bg:SetHorizTile(true)
			CharacterFrame.Inset.Bg:SetVertTile(true)
		end)

		E:RegisterEvent("ITEM_LOCK_CHANGED", function(bagOrSlotID, slotID)
			if CharacterFrame:IsShown() and bagOrSlotID and not slotID and EQUIP_SLOTS[bagOrSlotID] then
				updateSlot(bagOrSlotID)
			end
		end)

		E:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", function(slotID)
			if CharacterFrame:IsShown() then
				updateSlot(slotID)
			end
		end)

		isInit = true
	end
end