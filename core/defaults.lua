local _, ns = ...
local D = ns.D

D["units"] = {
	enabled =  true,
	player = {
		enabled = true,
		point = {"BOTTOM", "UIParent", "BOTTOM", -312 , 74},
		health = {
			orientation = "VERTICAL",
			update_on_mouseover = true,
			color = {
				class = false,
			},
			text = {
				-- tag = "", -- I probably should use tags here
				point1 = {
					p = "BOTTOM",
					anchor = "", -- frame[anchpr] or "" if anchor is frame itself
					rP = "CENTER",
					x = 0,
					y = 1,
				},
			},
		},
		health_prediction = {
			enabled = true,
			orientation = "VERTICAL",
		},
		power = {
			enabled = true,
			orientation = "VERTICAL",
			update_on_mouseover = true,
			text = {
				-- tag = "", -- I probably should use tags here
				point1 = {
					p = "TOP",
					anchor = "Health",
					rP = "CENTER",
					x = 0,
					y = -1,
				},
			},
		},
		castbar = {
			enabled = true,
			width = 200,
			icon = true,
			latency = true,
		},
		raid_target = {
			enabled = true,
			size = 24,
			point1 = {
				p = "CENTER",
				anchor = "",
				rP = "TOP",
				x = 0,
				y = -6,
			},
		},
	},
	pet = {
		point = {"RIGHT", "LSPlayerFrame" , "LEFT", -2, 0},
		health = {
			orientation = "VERTICAL",
			update_on_mouseover = true,
			color = {
				class = false,
			},
			text = {
				h_alignment = "RIGHT",
				point1 = {
					p = "BOTTOMRIGHT",
					anchor = "",
					rP = "BOTTOMRIGHT",
					x = 8,
					y = 26,
				},
			},
		},
		health_prediction = {
			enabled = true,
			orientation = "VERTICAL",
		},
		power = {
			enabled = true,
			orientation = "VERTICAL",
			update_on_mouseover = true,
			text = {
				-- tag = "", -- I probably should use tags here
				h_alignment = "RIGHT",
				point1 = {
					p = "BOTTOMRIGHT",
					anchor = "",
					rP = "BOTTOMLEFT",
					x = 8,
					y = 14,
				},
			},
		},
		castbar = {
			enabled = true,
			width = 200,
			icon = true,
			latency = true,
		},
		raid_target = {
			enabled = true,
			size = 24,
			point1 = {
				p = "CENTER",
				anchor = "",
				rP = "TOP",
				x = 0,
				y = 6,
			},
		},
	},
	target = {
		enabled = true,
		width = 250,
		height = 52,
		point = {"BOTTOM", "UIParent", "BOTTOM", 268, 336},
		insets = {
			t_height = 14,
			b_height = 14,
			l_width = 10,
			r_width = 10,
		},
		health = {
			orientation = "HORIZONTAL",
			update_on_mouseover = true,
			color = {
				class = false,
				tapped = true,
				disconnected = true,
				reaction = true,
			},
			text = {
				-- tag = "", -- I probably should use tags here
				h_alignment = "RIGHT",
				point1 = {
					p = "RIGHT",
					anchor = "Health",
					rP = "RIGHT",
					x = -2,
					y = 0,
				point2 = {},
				},
			},
		},
		health_prediction = {
			enabled = true,
			orientation = "HORIZONTAL",
		},
		power = {
			enabled = true,
			orientation = "HORIZONTAL",
			update_on_mouseover = true,
			text = {
				-- tag = "", -- I probably should use tags here
				h_alignment = "RIGHT",
				point1 = {
					p = "RIGHT",
					anchor = "Power",
					rP = "RIGHT",
					x = -2,
					y = 0,
				point2 = {},
				},
			},
		},
		castbar = {
			enabled = true,
			width = 244,
			icon = true,
		},
		name = {
			tag = "[ls:difficulty][ls:effectivelevel][shortclassification]|r [ls:name][ls:server]",
			h_alignment = "LEFT",
			point1 = {
				p = "LEFT",
				anchor = "Health",
				rP = "LEFT",
				x = 2,
				y = 0,
			},
			point2 = {
				p = "RIGHT",
				anchor = "Health.Text",
				rP = "LEFT",
				x = -2,
				y = 0,
			},
		},
		raid_target = {
			enabled = true,
			size = 24,
			point1 = {
				p = "CENTER",
				anchor = "",
				rP = "TOP",
				x = 0,
				y = 6,
			},
		},
		auras = {
			enabled = true,
			-- 0x0000000X -- friendly buff
			-- 0x000000X0 -- hostile buff
			-- 0x00000X00 -- friendly debuff
			-- 0x0000X000 -- hostile debuff
			show_boss = 0x0000ffff,
			show_mount = 0x000000ff,
			show_selfcast = 0x0000ffff,
			show_selfcast_permanent = 0x0000ffff,
			show_blizzard = 0x0000ffff,
			show_player = 0x0000ffff,
			show_dispellable = 0x00000ff0, -- friendly debuff / hostile buff
		},
	},
	targettarget = {
		width = 96,
		height = 24,
		point = { "BOTTOMLEFT", "LSTargetFrame", "BOTTOMRIGHT", 8, 0},
		health = {
			orientation = "HORIZONTAL",
			update_on_mouseover = true,
			color = {
				class = false,
				tapped = true,
				disconnected = true,
				reaction = true,
			},
		},
		health_prediction = {
			enabled = true,
			orientation = "HORIZONTAL",
		},
		name = {
			tag = "[ls:name][ls:server]|r",
			point1 = {
				p = "TOPLEFT",
				anchor = "Health",
				rP = "TOPLEFT",
				x = 2,
				y = -2,
			},
			point2 = {
				p = "BOTTOMRIGHT",
				anchor = "Health",
				rP = "BOTTOMRIGHT",
				x = -2,
				y = 2,
			},
		},
		raid_target = {
			enabled = true,
			size = 24,
			point1 = {
				p = "CENTER",
				anchor = "",
				rP = "TOP",
				x = 0,
				y = 6,
			},
		},
	},
	focus = {
		enabled = true,
		castbar = true,
		point = {"BOTTOM", "UIParent", "BOTTOM", -268, 336},
		auras = {
			enabled = true,
			show_boss = 0x0000ffff,
			show_mount = 0x000000ff,
			show_selfcast = 0x0000ffff,
			show_selfcast_permanent = 0x0000ffff,
			show_blizzard = 0x0000ffff,
			show_player = 0x0000ffff,
			show_dispellable = 0x00000ff0, -- friendly debuff / hostile buff
		},
	},
	focustarget = {
		point = { "RIGHT", "LSFocusFrame", "LEFT", -6, 0},
	},
	boss = {
		enabled = true,
		castbar = true,
		point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -76, -240},
	},
	-- arena = {
	-- 	enabled = true,
	-- 	point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -72, -240},
	-- 	castbar = true,
	-- },
}

D["auratracker"] = {
	enabled = true,
	locked = false,
	button_size = 36,
	button_gap = 4,
	init_anchor = "TOPLEFT",
	buttons_per_row = 12,
	HELPFUL = {},
	HARMFUL = {},
}

D["minimap"] = {
	enabled = true,
	point = {"BOTTOM", "UIParent", "BOTTOM", 312 , 74},
}

D["bars"] = {
	enabled = true,
	restricted = true,
	show_hotkey = true,
	show_name = true,
	use_icon_as_indicator = true,
	bar1 = { -- MainMenuBar
		visible = true,
		point = {"BOTTOM", 0, 16},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 12,
	},
	bar2 = { -- MultiBarBottomLeft
		visible = true,
		point = {"BOTTOM", 0, 52},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 12,
	},
	bar3 = { -- MultiBarBottomRight
		visible = true,
		point = {"BOTTOM", 0, 88},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 12,
	},
	bar4 = { -- MultiBarLeft
		visible = true,
		point = {"BOTTOMRIGHT", -40, 240},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPRIGHT",
		buttons_per_row = 1,
	},
	bar5 = { -- MultiBarRight
		visible = true,
		point = {"BOTTOMRIGHT", -4, 240},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPRIGHT",
		buttons_per_row = 1,
	},
	bar6 = { --PetAction
		visible = true,
		button_size = 24,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 10,
	},
	bar7 = { -- Stance
		visible = true,
		button_size = 24,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 10,
	},
	extra = { -- ExtraAction
		visible = true,
		point = {"BOTTOM", -170, 138},
		button_size = 40,
	},
	vehicle = { -- LeaveVehicle
		visible = true,
		point = {"BOTTOM", 170, 138},
		button_size = 40,
	},
	garrison = {
		visible = true,
		point = {"BOTTOM", -170, 182},
		button_size = 40,
	},
	micromenu = {
		visible = true,
		holder1 = {
			point = {"BOTTOM", -280, 16},
		},
		holder2 = {
			point = {"BOTTOM", 280, 16},
		},
	},
	bags = {
		enabled = true,
		visible = true,
		point = {"BOTTOM", 434, 16},
		button_size = 32,
		button_gap = 4,
		init_anchor = "TOPLEFT",
		buttons_per_row = 5,
	},
	xpbar = {
		enabled = true,
		point = {"BOTTOM", "UIParent", "BOTTOM", 0, 4},
	},
}

D["auras"] = {
	enabled = true,
	buff = {
		point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -4, -4},
	},
	debuff = {
		point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -4, -76},
	},
	tempench = {
		point = {"TOPRIGHT", "UIParent", "TOPRIGHT", -4, -112},
	},
	aura_size = 32,
	aura_gap = 4,
}

D["tooltips"] = {
	enabled = true,
	show_id = true,
	unit = {
		name_color_pvp_hostility = true,
		name_color_class = true,
		name_color_tapping = true,
		name_color_reaction = true,
	}
}

D["movers"] = {}

D["blizzard"] ={
	enabled = true,
	command_bar = { -- OrderHallCommandBar
		enabled = true
	},
	digsite_bar = { -- ArcheologyDigsiteProgressBar
		enabled = true,
	},
	durability = { -- DurabilityFrame
		enabled = true
	},
	gm = { -- TicketStatusFrame
		enabled = true
	},
	npe = { -- NPE_TutorialInterfaceHelp
		enabled = true
	},
	objective_tracker = { -- ObjectiveTrackerFrame
		enabled = true,
		height = 600,
	},
	player_alt_power_bar = { -- PlayerPowerBarAlt
		enabled = true
	},
	talking_head = { -- TalkingHeadFrame
		enabled = true
	},
	timer = { -- MirrorTimer*, TimerTrackerTimer*
		enabled = true
	},
	vehicle = { -- VehicleSeatIndicator
		enabled = true
	},
}

D["login_msg"] = true
