local _, ns = ...
local E, C, M, L, P = ns.E, ns.C, ns.M, ns.L, ns.P
local UF = P:GetModule("UnitFrames")

-- Lua
local _G = getfenv(0)

--[[ luacheck: globals
]]

-- Mine
local isInit = false

function UF:HasFocusFrame()
	return isInit
end

function UF:CreateFocusFrame(frame)
	isInit = true

	return self:CreateLargeFrame(frame)
end
