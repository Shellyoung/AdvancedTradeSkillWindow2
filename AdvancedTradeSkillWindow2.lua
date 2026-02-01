-- copyright 2006 by Rene Schneider (Slarti on EU-Blackhand), 2017 by laytya
-- Modified by Alexander Shelokhnev (Dreamios on Tel'Abim (Turtle-WoW)) in 2022

local _G = getfenv(0)

ATSW_MAX_TRADESKILL_TABS 			= 8
ATSW_TRADESKILL_HEIGHT 				= 18

ATSW_RECIPES_DISPLAYED 				= 23
ATSW_TASKS_DISPLAYED 					= 5
ATSW_TOOLS_DISPLAYED 					= 4
ATSW_NECESSARIES_DISPLAYED 		= 20
ATSW_AUCTION_ITEMS_DISPLAYED 	= 5

ATSW_TABLE_CREATION_SIZE 			= 10

ATSW_NECESSARY_REAGENT_ADD		= 1
ATSW_NECESSARY_REAGENT_DELETE	= 2

ATSW_POSSIBLE_BAGS						= 1
ATSW_POSSIBLE_BANK						= 2
ATSW_POSSIBLE_ALTS						= 3
ATSW_POSSIBLE_MERCHANT				= 4
ATSW_POSSIBLE_NOTASK					= 5

ATSW_CAST 										= 1
ATSW_FLASH 									= 2
ATSW_FADEOUT 								= 3

ATSW_FLASH_TIME							= 5/60
ATSW_FADEOUT_TIME						= 10/60

ERR_LEARN_RECIPE_PATTERN 			= string.gsub(ERR_LEARN_RECIPE_S, 			'%%s', '(.+)'		)
ERR_LEARN_SPELL_PATTERN 				= string.gsub(ERR_LEARN_SPELL_S, 			'%%s', '(.+)'		)
ERR_LEARN_ABILITY_PATTERN 			= string.gsub(ERR_LEARN_ABILITY_S, 		'%%s', '(.+)'		)
ERR_UNLEARN_RECIPE_PATTERN			= string.gsub(ERR_SPELL_UNLEARNED_S, 	'%%s', '(.+)'		)
ERR_SKILL_UP_PATTERN 					= string.gsub(string.gsub(ERR_SKILL_UP_SI,'%%d', '%%d+'),'%%s','(.+)')
ERR_SKILL_GAINED_PATTERN 				= string.gsub(ERR_SKILL_GAINED_S, 			'%%s', '(.+)'		)
LOOT_ITEM_CREATED_SELF_PATTERN = string.gsub(LOOT_ITEM_CREATED_SELF,	'%%s',	'(.+)'		)

UIPanelWindows['ATSWFrame'			] 	= { area = 'left', 		pushable = 8 }
UIPanelWindows['ATSWCSFrame'		] 	= { area = 'left', 		pushable = 8 }
UIPanelWindows['ATSWConfigFrame'	]	= { area = 'center', 	pushable = 1 }

ATSWTypeColor = {
	['optimal'	]	= {	R = 1.00,	G = 0.50,	B = 0.25	},
	['medium'	]	= {	R = 1.00,	G = 1.00,	B = 0.00	},
	['easy'		]	= {	R = 0.25,	G = 0.75,	B = 0.25	},
	['trivial'		]	= {	R = 0.50,	G = 0.50,	B = 0.50	},
	['used'		]	= {	R = 0.50,	G = 0.50,	B = 0.50	},
	['header'	]	= {	R = 1.00,	G = 0.82,	B = 0		},
	['none'		]	= {	R = 0.25,	G = 0.75,	B = 0.25	}
}

local QualityColor = {
	[1] = {	R = 0.62,	G = 0.62, 	B = 0.62	},
	[2] = {	R = 1,		G = 1, 		B = 1		},
	[3] = {	R = 0.12,	G = 1, 		B = 0		},
	[4] = {	R = 0,		G = 0.44, 	B = 0.87	},
	[5] = {	R = 0.64,	G = 0.21, 	B = 0.93	},
	[6] = {	R = 1,		G = 0.5, 	B = 0		},
	[7] = {	R = 0.9,	G = 0.8, 	B = 0.5		},
	[8] = {	R = 0,		G = 0.8, 	B = 1		}
}

local ToolID = {
	['Blacksmith Hammer'			] 		= 5956,
	['Arclight Spanner'				] 		= 6219,
	['Gyromatic Micro-Adjustor'	]		= 10498,
	['Philosopher\'s Stone'			] 		= 9149,
	['Runed Copper Rod'			] 		= 6218,
	['Runed Silver Rod'				] 		= 6339,
	['Runed Golden Rod'			] 		= 11130,
	['Runed Truesilver Rod'		] 		= 11145,
	['Runed Arcanite Rod'			] 		= 16207
}

local Professions	= {
	'Trade_Engraving',				-- Enchanting
	'Trade_Tailoring',				-- Tailoring
	'Trade_Engineering',			-- Engineering
	'Trade_BlackSmithing',			-- Blacksmithing
	'INV_Jewelry_Necklace_11',	-- Jewelcrafting
	'Spell_Fire_FlameBlades',		-- Smelting
	'Trade_Alchemy',				-- Alchemy
	'INV_Misc_ArmorKit_17',		-- Leatherworking
	'INV_Misc_Food_15',			-- Cooking
	'Spell_Holy_SealOfSacrifice',	-- First Aid
	'Trade_Survival',					-- Survival
	'Ability_Hunter_BeastCall02',	-- Beast Training
	'Trade_BrewPoison'				-- Poisons
}

-- For AtlasLoot addon
local ProfessionNamesForAtlasLoot = {
	['Interface\\Icons\\Trade_Engraving'] = { -- Enchanting
		'EnchantingApprentice1',
		'EnchantingJourneyman1',
		'EnchantingJourneyman2',
		'EnchantingExpert1',
		'EnchantingExpert2',
		'EnchantingArtisan1',
		'EnchantingArtisan2',
		'EnchantingArtisan3'
	},
	['Interface\\Icons\\Trade_Tailoring'] = { -- Tailoring
		'TailoringApprentice1',
		'TailoringJourneyman1',
		'TailoringJourneyman2',
		'TailoringExpert1',
		'TailoringExpert2',
		'TailoringArtisan1',
		'TailoringArtisan2',
		'TailoringArtisan3',
		'TailoringArtisan4'
	},
	['Interface\\Icons\\Trade_Engineering'] = { -- Engineering
		'EngineeringApprentice1',
		'EngineeringJourneyman1',
		'EngineeringJourneyman2',
		'EngineeringExpert1',
		'EngineeringExpert2',
		'EngineeringArtisan1',
		'EngineeringArtisan2',
		'Gnomish1',
		'Goblin1'
	},
	['Interface\\Icons\\Trade_BlackSmithing'] ={ -- Blacksmithing
		'SmithingApprentice1',
		'SmithingJourneyman1',
		'SmithingJourneyman2',
		'SmithingExpert1',
		'SmithingExpert2',
		'SmithingArtisan1',
		'SmithingArtisan2',
		'SmithingArtisan3',
		'Armorsmith1',
		'Weaponsmith1',
		'Axesmith1',
		'Hammersmith1',
		'Swordsmith1'
	},
	['Interface\\Icons\\INV_Jewelry_Necklace_11'] = { -- Jewelcrafting
		'JewelcraftingApprentice1',
		'JewelcraftingJourneyman1',
		'JewelcraftingJourneyman2',
		'JewelcraftingExpert1',
		'JewelcraftingExpert2',
		'JewelcraftingExpert3',
		'JewelcraftingArtisan1',
		'JewelcraftingArtisan2'
	},
	['Interface\\Icons\\Spell_Fire_FlameBlades'] = { -- Smelting
		'Smelting1'
	},
	['Interface\\Icons\\Trade_Alchemy'] = { -- Alchemy
		'AlchemyApprentice1',
		'AlchemyJourneyman1',
		'AlchemyExpert1',
		'AlchemyArtisan1',
		'AlchemyArtisan2'
	},
	['Interface\\Icons\\INV_Misc_ArmorKit_17'] = { -- Leatherworking
		'LeatherApprentice1',
		'LeatherJourneyman1',
		'LeatherJourneyman2',
		'LeatherExpert1',
		'LeatherExpert2',
		'LeatherArtisan1',
		'LeatherArtisan2',
		'LeatherArtisan3',
		'Dragonscale1',
		'Elemental1',
		'Tribal1'
	},
	['Interface\\Icons\\INV_Misc_Food_15'] = { -- Cooking
		'CookingApprentice1',
		'CookingJourneyman1',
		'CookingExpert1',
		'CookingArtisan1'
	},
	['Interface\\Icons\\Spell_Holy_SealOfSacrifice'] = { -- First Aid
		'FirstAid1'
	},
	['Interface\\Icons\\Trade_Survival'] = { -- Survival
		'Survival1',
		'Survival2'
	}, 
	['Interface\\Icons\\Ability_Hunter_BeastCall02'] = {''}, -- Beast Training
	['Interface\\Icons\\Trade_BrewPoison'] = { -- Poisons
		'Poisons1'
	}
}

ATSW_Specializations = {
	['Interface\\Icons\\Trade_Engineering'] = {		-- Engineering
		'INV_Gizmo_02', 					-- Gnomish Engineer
		'Spell_Fire_SelfDestruct' 			-- Goblin Engineer
	},
	['Interface\\Icons\\Trade_BlackSmithing'] ={		-- Blacksmithing
		'INV_Chest_Plate04', 				-- Armorsmith
		'INV_Sword_25', 					-- Weaponsmith
		'INV_Axe_05', 						-- Master Axesmith
		'INV_Hammer_23', 					-- Master Hammersmith
		'INV_Sword_41' 						-- Master Swordsmith
	},
	['Interface\\Icons\\INV_Misc_ArmorKit_17'] = {	-- Leatherworking
		'INV_Misc_MonsterScales_03',	-- Dragonscale Leatherworking
		'Spell_Fire_Volcano', 				-- Elemental Leatherworking
		'Spell_Nature_NullWard'	 		-- Tribal Leatherworking
	}
}

ATSW_Background = {
	['Interface\\Icons\\Trade_Engraving'					]	= 'Enchanting',
	['Interface\\Icons\\Trade_Tailoring'					]	= 'Tailoring',
	['Interface\\Icons\\Trade_Engineering'				]	= 'Engineering',
	['Interface\\Icons\\Trade_BlackSmithing'			]	= 'Blacksmithing',
	['Interface\\Icons\\INV_Jewelry_Necklace_11'	]	= 'Jewelcrafting',
	['Interface\\Icons\\Spell_Fire_FlameBlades'			]	= 'Smelting',
	['Interface\\Icons\\Trade_Alchemy'					]	= 'Alchemy',
	['Interface\\Icons\\INV_Misc_ArmorKit_17'			]	= 'Leatherworking',
	['Interface\\Icons\\INV_Misc_Food_15'				]	= 'Cooking',
	['Interface\\Icons\\Spell_Holy_SealOfSacrifice'		]	= 'FirstAid',
	['Interface\\Icons\\Trade_Survival'						]	= 'Survival',
	['Interface\\Icons\\Ability_Hunter_BeastCall02'	]	= 'BeastTraining',
	['Interface\\Icons\\Trade_BrewPoison'				]	= 'Poisons'
}

-- Colors are stored for code readability
local Color = {
	GREY 		= '|cff7f7f7f',
	LIGHTGREY= '|cff9F9F9F',
	RED 			= '|cffff0000',
	WHITE 		= '|cffFFFFFF',
	GREEN 		= '|cff00FF00',
	DARKGREEN = '|cff1f8f1f',
	PURPLE 	= '|cff9F3FFF',
	BLUE 		= '|cff0070dd',
	ORANGE 	= '|cffff7f3f',
	YELLOW 	= '|cffffff00',
	DEFAULT 	= '|cffFFd200'
}

local function GetUnitClass(Unit)
	local _, Class = UnitClass(Unit)
	
	if Class and string.len(Class) > 0 then
		local First = string.upper(string.sub(Class, 1, 1))
		local Rest = string.upper(string.sub(Class, 2))
		
		Class = First .. Rest
	end
	
	return Class
end

local realm 										= GetRealmName()
local player 										= UnitName('player')
local class											= GetUnitClass('player')
ATSW_player										= player
ATSW_realm										= realm

ATSW_Characters 								= {}
ATSW_Characters[realm] 					= {}

local TradeSkill

function ATSW_TradeSkill()
	return TradeSkill
end

local InitializedOnShow 						= false
local ReagentsDataIsComplete 				= true
local RecipesDataIsComplete 				= -1
local RecipesDataTries 						= 0
local CooldownUpdateTime 					= 0
local LoadingProfessions 						= false
local UpdateCount								= 0
local LastCastName 							= nil
local NoDropDownUpdate					= false
local BankFrameOpened						= false

local s 				= ERR_USE_LOCKED_WITH_ITEM_S 		-- 'Requires %s'
local sRequires 	= string.sub(s, 1, string.find(s, '%s')) 	-- Delete %s

ATSW_Debug 									= false

ATSW_SwitchingFrames						= false
ATSW_SwitchingToEditor					= false
ATSW_SwitchingToMain						= false

-- Selected
ATSW_Profession 								= {}
ATSW_Profession[realm]						= {}
ATSW_Profession[realm][player] 			= nil
ATSW_SelectedRecipe 						= {}
ATSW_SelectedRecipe[realm]				= {}
ATSW_SelectedRecipe[realm][player]	= {}

-- Top control panel
ATSW_SortBy 									= {}
ATSW_SortBy[realm] 							= {}
ATSW_SortBy[realm][player] 				= {}
ATSW_SearchString 							= {}
ATSW_SearchString[realm] 					= {}
ATSW_SearchString[realm][player] 		= {}
ATSW_BlockSearchTextChanged 			= false
ATSW_SubClassFilter 							= {}
ATSW_SubClassFilter[realm] 					= {}
ATSW_SubClassFilter[realm][player] 		= {}
ATSW_InvSlotFilter 							= {}
ATSW_InvSlotFilter[realm] 					= {}
ATSW_InvSlotFilter[realm][player] 		= {}

-- Recipes auxiliary arrays
ATSW_ContractedCategories 				= {}
ATSW_ContractedCategories[realm] 		= {}
ATSW_ContractedCategories[realm][player] = {}
ATSW_ScrollOffset 								= {}
ATSW_ScrollOffset[realm] 					= {}
ATSW_ScrollOffset[realm][player] 			= {}
ATSW_NeedToUpdate 						= {}
ATSW_NeedToUpdate[realm] 				= {}
ATSW_NeedToUpdate[realm][player] 	= {}

-- Previous recipes
ATSW_PreviousRecipes 						= {}
ATSW_PreviousRecipes[realm] 				= {}
ATSW_PreviousRecipes[realm][player] 	= {}

-- Tasks
ATSW_Tasks 										= {}
ATSW_Tasks[realm] 							= {}
ATSW_Tasks[realm][player] 					= {}
ATSW_NecessaryReagents 					= {}
ATSW_NecessaryReagents[realm] 		= {}
ATSW_NecessaryReagents[realm][player] = {}
ATSW_TimeCost									= {}

-- Bottom control panel
ATSW_Amount 									= {}
ATSW_Amount[realm] 						= {}
ATSW_Amount[realm][player] 				= {}

-- Processing
local Processing = {
	Active			= false,
	Profession		= nil,
	Recipe			= nil,
	Texture			= nil,
	RecipeTime	= 0,
	Amount			= 0,
	Time				= 0,
	Delay				= 0,
	Complete		= 0,
	Stop				= false
}

-- Options
ATSW_Options = {
	Unified 							= true,
	ConsiderBank 					= false,
	ConsiderAlts 					= false,
	ConsiderMerchants 			= false,
	RecipeTooltip 				= true,
	AutoBuy 						= false,
	DisplayShoppingList 			= true,
}

ATSW_Attributes = {}
ATSW_Attributes[realm] = {}
ATSW_Attributes[realm][player] = {}

-- Transform old settings. Remove in the future, 2026 year maybe.
if ATSW_Unified ~= nil then
	ATSW_Options.Unified 						= ATSW_Unified
	ATSW_Options.ConsiderBank 				= ATSW_ConsiderBank
	ATSW_Options.ConsiderAlts 				= ATSW_ConsiderAlts
	ATSW_Options.ConsiderMerchants 		= ATSW_ConsiderMerchants
	ATSW_Options.RecipeTooltip 				= ATSW_RecipeTooltip
	ATSW_Options.AutoBuy 						= ATSW_AutoBuy
	ATSW_Options.DisplayShoppingList 		= ATSW_DisplayShoppingList
	ATSW_Unified = nil
	ATSW_ConsiderBank = nil
	ATSW_ConsiderAlts = nil
	ATSW_ConsiderMerchants = nil
	ATSW_RecipeTooltip = nil
	ATSW_AutoBuy = nil
	ATSW_DisplayShoppingList = nil
end

-- Controllable tables instead of standard tables do not leave garbage if they change in the game

ATSW = {
	Recipes 									= {},
	RecipesSize 							= {},
	RecipesSorted 						= {},
	RecipesSortedSize 					= {},
}

ATSW.Recipes[realm] 							= {}
ATSW.Recipes[realm][player] 				= {}
ATSW.RecipesSize[realm] 					= {}
ATSW.RecipesSize[realm][player] 			= {}
ATSW.RecipesSorted[realm] 				= {}
ATSW.RecipesSorted[realm][player] 		= {}
ATSW.RecipesSortedSize[realm] 			= {}
ATSW.RecipesSortedSize[realm][player]	= {}

-- Utility functions
local function SetVisible(Frame, State)
	if Frame then
		if State then
			Frame:Show()
		else
			Frame:Hide()
		end
	end
end

local function SetEnabled(Frame, State)
	if Frame then
		if State then
			Frame:Enable()
		else
			Frame:Disable()
		end
	end
end

local function SetSize(Object, Size, SizeY)
	Object:SetWidth(Size)
	Object:SetHeight(SizeY or Size)
end

local function FormatTime(Seconds, FourDigits)
	if tonumber(Seconds) then
		local Time
		local D, H, M, S = ChatFrame_TimeBreakDown(Seconds)
	  
		if D > 0 then
			Time =  string.format('%dd:%dh', D, H)
		elseif H > 0 then
			Time = string.format('%dh:%dm', H, M)
		else
			if FourDigits then
				Time = string.format( '%02d:%02d', M, S)
			else
				if M > 0 then
					Time = string.format('%d:%02d', M, S)
				elseif S > 0 then
					Time = string.format('%d', S)
				end
			end
		end
		
		return Time
	end
end

local function FormatCooldown(Cooldown)
	if Cooldown then
		local Time = math.floor(Cooldown)
		
		if Time > 0 then
			Time = SecondsToTime(Time, false)
			Time = string.gsub(Time, 'Day', 'day')
			Time = string.gsub(Time, 'Hr', 'hour')
			Time = string.gsub(Time, 'Min', 'minute')
			Time = string.gsub(Time, 'Sec', 'second')
		end
		
		return Time
	end
end

local function ShortFormatCooldown(Cooldown, FourDigits)
	if Cooldown and type(Cooldown) == 'number' and Cooldown >= 0 then
		return FormatTime(Cooldown, FourDigits)
	else
		return ''
	end
end

local function ConvertCooldown(Cooldown, Long)
	if Cooldown then
		local S = Cooldown - GetTime()
		
		if S >= 0 then
			if Long then
				return FormatCooldown(S)
			else
				return ' |cffE00000(' .. ShortFormatCooldown(S) .. ')|r'
			end
		end
	end
end

local function HexToDec(Hex)
    Hex = string.upper(Hex)
	
    local Total = 0
	
    for I = 1, string.len(Hex) do
        local Char = string.byte(Hex, I)
        local Numeric
		
        if Char > 64 then
            Numeric = Char - 55
        else
            Numeric = Char - 48
        end
		
        Total = Total + Numeric * math.pow(16, string.len(Hex) - I)
    end
	
    return Total
end

local function Round(number, decimals)
    return math.floor((number * math.pow(10, decimals) + 0.5)) / math.pow(10, decimals)
end

local function LinkToName(Link)
	if Link then
		return string.gsub(Link,'^.*%[(.*)%].*$','%1')
	end
end

local function LinkToColor(Link)
    if Link then
        return string.gsub(Link, '^.*|cff(.-)|.*$', '%1')
    end
end

local function GetLinkColorRGB(Link)
    if Link then
        local Color = HexToDec(LinkToColor(Link))
        local R	= math.floor(Color / 65536)
        local G	= math.floor((Color - R * 65536) / 256)
        local B	= math.floor((Color - R * 65536 - G * 256))
		
        return R/255, G/255, B/255
    end
end

local function ColorToQuality(R, G, B)
	if R then
		for I = 1, table.getn(QualityColor) do
			local C = QualityColor[I]
			
			if C.R == Round(R, 2) and C.G == Round(G, 2) and C.B == Round(B, 2) then
				return I
			end
		end
	end
	
	return 0
end

local function LinkToQuality(Link)
	local R, G, B = GetLinkColorRGB(Link)
	
	return ColorToQuality(R, G, B)
end

local function ATSW_LinkToID(Link)
    if Link then
		local _, _, LinkType, ID = string.find(Link, '^.*|H?([^:]*):?(%d+)')
		
        return tonumber(ID)
    end
end

local ITEM_MIN_LEVEL_PATTERN = string.gsub(ITEM_MIN_LEVEL,'%%d', '(%%d+)')

local function GetItemMinLevel(ID, Reagent)
	local Stats = {GetTradeSkillItemStats(ID)}

	for I, V in pairs(Stats) do
		local _, _, Level = string.find(V, ITEM_MIN_LEVEL_PATTERN)

		if Level then
			return tonumber(Level)
		end
	end
end

local function GetItemTexture(ID)
	local _, _, _, _, _, _, _, _, Texture = GetItemInfo(ID)
	
	return Texture
end

local function RemoveEscapeCharacters(String)
	local Result = tostring(String)
	
	Result = gsub(Result, '|c........', ''			) 	-- Remove color start.
	Result = gsub(Result, '|r', ''						) 	-- Remove color end.
	Result = gsub(Result, '|H.-|h(.-)|h', '%1'	) 	-- Remove links.
	Result = gsub(Result, '|T.-|t', ''				) 	-- Remove textures.
	Result = gsub(Result, '{.-}', ''					) 	-- Remove raid target icons.
	
	return Result
end

local function GetCategoryTexture(Expanded)
	return 'Interface\\Buttons\\UI-' .. (Expanded and 'Min' or 'Pl') .. 'usButton-Up'
end

local function GetSpellNum(Name)
	local I, SName = 0
	
	repeat
		I = I + 1
		SName = GetSpellName(I, BOOKTYPE_SPELL)
		
		if SName and Name and string.find(SName, Name) then
			return I
		end
	until not SName
end

local function GetProfessionTexture(Name)
	local SpellNum = GetSpellNum(Name)
	
	if SpellNum then
		return GetSpellTexture(SpellNum, BOOKTYPE_SPELL)
	end
end

local function Icon(Name)
	return Name and ('Interface\\Icons\\' .. Name)
end

local function IsEnchant(Index)
	local I = Icon('Spell_Holy_GreaterHeal')
	
	if type(Index) == 'string' then
		return Index == I
	elseif type(Index) == 'number' then
		return ATSW_GetCraftTexture(Index) == I
	end
end

local function GetLatency()
	local _, _, lag = GetNetStats()
	
	return lag / 1000
end

local function Debug(Message)
	if ATSW_Debug then
		ChatFrame1:AddMessage('ATSW Debug: ' .. (Message or 'nil'))
	end
end

local Key = {
	Ctrl = function()
		return IsControlKeyDown()
	end,
	Shift = function()
		return IsShiftKeyDown()
	end,
	Alt = function()
		return IsAltKeyDown()
	end
}

local Delayed										= false
ATSW_InTime									= 0

-- Game information get functions

local function GetCraftCaption()
	local Skill, Rank, MaxRank, Name
	
	if TradeSkill	then		Skill, Rank, MaxRank = GetTradeSkillLine()
						else		Skill 						= GetCraftName()
									_, Rank, MaxRank 	= GetCraftDisplaySkillLine()	end
	
	if ATSW_ProfessionExists(Skill) then
		Name = Skill
	else
		Name = LastCastName
	end
	
	return Name, Rank, MaxRank
end

local function GetCraftCount()
	if TradeSkill	then	return GetNumTradeSkills()
						else	return GetNumCrafts() end
end

local function GetFirstCraft()
	if TradeSkill	then	return GetFirstTradeSkill()
						else	local _, _, Type = GetCraftInfo(1)
								return 1 + (Type == 'header' and 1 or 0) end
end

local function GetCraftNameType		(Index)
	local Name, Type, SubName
	
	if TradeSkill	then	Name, Type = GetTradeSkillInfo(Index)
						else	Name, SubName, Type = GetCraftInfo(Index) end
	
	return Name, SubName, Type
end

local function GetCraftLink					(Index)
	if TradeSkill	then	return GetTradeSkillItemLink(Index)
						else	return GetCraftItemLink(Index) end
end

ATSW_AtlasIDCache = {}

local function CraftIDtoAtlasID(ID, Enchants)
	if ATSW_AtlasIDCache[ID] then
		return ATSW_AtlasIDCache[ID]
	end
	
	local DB = GetSpellInfoVanillaDB or GetSpellInfoAtlasLootDB
	local Table
	
	if Enchants then
		Table = DB['enchants']
	else
		Table = DB['craftspells']
	end
	
	if Table then
		for I, Value in pairs(Table) do
			local Item = Value.craftItem or Value.item
			
			if Item and ID and Item == ID then
				ATSW_AtlasIDCache[ID] = I
				
				return I
			end
		end
	end
end

local function GetCraftTexture			(Index)
	local Icon
	local DB = GetSpellInfoVanillaDB or GetSpellInfoAtlasLootDB
	
	if DB then
		local ID = ATSW_LinkToID(GetCraftLink(Index))
		local AtlasID = CraftIDtoAtlasID(ID, not TradeSkill)
		local Info = DB['enchants'][AtlasID] or DB['craftspells'][AtlasID]
		
		Icon = Info and (Info['icon'] or GetItemTexture(Info['craftItem']))
	end
	
	if not Icon then
		if TradeSkill	then	Icon = GetTradeSkillIcon(Index)
							else	Icon = GetCraftIcon(Index) end
	end
	
	return Icon
end

function ATSW_GetCraftTexture			(Index)
	return GetCraftTexture(Index)
end

local function GetCraftMinMax				(Index)
	local Min, Max
	
	if TradeSkill	then	Min, Max = GetTradeSkillNumMade(Index)
						else	Min, Max = 1, 1 end
	
	return Min, Max
end

local function GetCraftCooldown			(Index)
	if TradeSkill	then	return GetTradeSkillCooldown(Index) end
end

local function GetReagentCount			(Index)
	if TradeSkill	then	return GetTradeSkillNumReagents(Index)
						else	return GetCraftNumReagents(Index) end
end

local function GetCraftInformation		(Index)
	local Name, SubName, Type, Available, Expanded, Action, TrainingCost, RequiredLevel
	
	if TradeSkill	then	Name, 				 Type, Available, Expanded, Action 								= GetTradeSkillInfo(Index)
						else	Name, SubName, Type, Available, Expanded, TrainingCost, RequiredLevel	= GetCraftInfo(Index) end
	
	return Name, SubName, Type, Available, Expanded, Action or TrainingCost, RequiredLevel
end

local function GetCraftData				(Index)
	local Name, SubName, Type, Available, Expanded, ActionOrTrainingCost, RequiredLevel = GetCraftInformation(Index)
	local Min, Max = GetCraftMinMax(Index)
	
	return 	Name, SubName, Type,
				GetCraftTexture		(Index),
				GetCraftLink			(Index),
				Min, Max,
				GetCraftCooldown	(Index),
				GetReagentCount	(Index),
				ActionOrTrainingCost,
				RequiredLevel
end

local function GetReagentInformation	(Index, ReagentIndex)
	if TradeSkill	then	return GetTradeSkillReagentInfo(Index, ReagentIndex)
						else	return GetCraftReagentInfo(Index, ReagentIndex) end
end

local function GetReagentLink			(Index, ReagentIndex)
	if TradeSkill	then	return GetTradeSkillReagentItemLink(Index, ReagentIndex)
						else	return GetCraftReagentItemLink(Index, ReagentIndex) end
end

local function GetReagentData			(Index, ReagentIndex)
	local Name, Texture, Amount, PlayerAmount = GetReagentInformation(Index, ReagentIndex)
	local Link = GetReagentLink(Index, ReagentIndex)
	
	return Name, Texture, Amount, PlayerAmount, Link
end

local function GetCraftRequirements	(Index)
	if TradeSkill	then	return GetTradeSkillTools(Index)
						else	return GetCraftSpellFocus(Index) end
end

local function SelectCraftItem				(Index)
	if TradeSkill	then	return SelectTradeSkill(Index)
						else	return SelectCraft(Index) end
end

local function Craft							(Index, Amount)
	if TradeSkill	then	DoTradeSkill(Index, Amount)
						else	DoCraft(Index) end
end

local function Profession()
	return ATSW_Profession[realm] and ATSW_Profession[realm][player]
end

local function RecipeSelected()
	return ATSW_SelectedRecipe[realm][player][Profession()]
end

function ATSW_RecipeSelected()
	return RecipeSelected()
end

local function Recipes(Prof)
	return ATSW.Recipes[realm][player][Prof or Profession()]
end

local function RecipesSize(Value)
	if tonumber(Value) and Profession() then
		ATSW.RecipesSize[realm][player][Profession()] = Value
	else
		return ATSW.RecipesSize[realm][player][Value or Profession()] or 0
	end
end

local function Recipe(I, Prof)
	return Recipes(Prof or Profession() )[I]
end

function ATSW_Recipe(I)
	return Recipe(I)
end

local function AddRecipe(Index)
	local Size = RecipesSize() + 1
	
	if Size > table.getn(Recipes()) then
		for I = 1, ATSW_TABLE_CREATION_SIZE do
			table.insert(Recipes(),
								{	
									Name 			= nil,
									SubName		= nil,
									Type 			= nil,
									Texture 		= nil,
									Position 		= nil,
									Link 				= nil,
									ProductMin 	= 0,
									ProductMax 	= 0,
									Cooldown 		= nil,
									Reagents		= {},
									ReagentsSize 	= 0,
									TrainingCost	= 0,
									RequiredLevel	= nil
								})
			
			for RI = 1, MAX_TRADE_SKILL_REAGENTS do
				table.insert(Recipe(Size-1+I).Reagents, 
								{
									Name 			= nil,
									Texture			= nil,
									Amount			= 0,
									PlayerAmount	= 0,
									Link				= nil
								})
			end
		end
	end
	
	local R = Recipe(Size)
	
	R.Name, 		R.SubName, 		R.Type, 			R.Texture, 	R.Link, 	R.ProductMin, 	R.ProductMax,
	R.Cooldown, 	R.ReagentsSize, 	R.TrainingCost, 	R.RequiredLevel = GetCraftData(Index)
	R.Position = Index
	
	for I = 1, R.ReagentsSize do
		Rt = R.Reagents[I]
		
		Rt.Name, Rt.Texture, Rt.Amount, Rt.PlayerAmount, Rt.Link = GetReagentData(Index, I)
	end
	
	if R.Cooldown then
		R.Cooldown = GetTime() + R.Cooldown
	end
	
	RecipesSize(Size)
end

local function RecipesSorted()
	return ATSW.RecipesSorted[realm][player][Profession()]
end

local function RecipesSortedSize(Value)
	if Value and Profession() then
		ATSW.RecipesSortedSize[realm][player][Profession()] = Value
	end
	
	return ATSW.RecipesSortedSize[realm][player][Profession()] or 0
end

local function RecipeSorted(I)
	return RecipesSorted()[I]
end

local function AddRecipeSorted(R)
	local Size = RecipesSortedSize() + 1
	
	if Size > table.getn(RecipesSorted()) then
		for I = 1, ATSW_TABLE_CREATION_SIZE do
			table.insert(RecipesSorted(), nil )
		end
	end
	
	RecipesSorted()[Size] = R
	RecipesSortedSize(Size)
end

-- Wrap functions with smaller names for easy access from code

local function NeedToUpdate()
	return ATSW_NeedToUpdate[realm][player][Profession()]
end

local function SetNeedToUpdate(Prof, Value)
	if Value == nil then Value = true end
	
	if Prof then
		ATSW_NeedToUpdate[realm][player][Prof] = Value
	else
		for I in pairs(ATSW_NeedToUpdate[realm][player]) do
			ATSW_NeedToUpdate[realm][player][I] = Value
		end
	end
end

local function PreviousRecipes(Prof)
	return ATSW_PreviousRecipes[realm][player][Prof or Profession()]
end

local function PreviousRecipesSize(Prof)
	return table.getn(PreviousRecipes(Prof or Profession()) or {})
end

local function PreviousRecipe(I)
	return PreviousRecipes()[I]
end

local function SortBy()
	return ATSW_SortBy[realm][player][Profession()]
end

local function SearchString()
	return ATSW_SearchString[realm][player][Profession()]
end

local function SetSearchString(Text)
	ATSW_SearchString[realm][player][Profession()] = Text
end

local function ScrollOffset()
	return ATSW_ScrollOffset[realm][player][Profession()]
end

local function Contracted()
	return ATSW_ContractedCategories[realm][player][Profession()][SortBy()]
end

function ATSW_Contracted()
	return Contracted()
end

local function SubClass()
	return ATSW_SubClassFilter[realm][player][Profession()]
end

local function InvSlot()
	return ATSW_InvSlotFilter[realm][player][Profession()]
end

local function SetSubClass(Value)
	if Profession() then
		ATSW_SubClassFilter[realm][player][Profession()] = Value
	end
end

local function SetInvSlot(Value)
	if Profession() then
		ATSW_InvSlotFilter[realm][player][Profession()] = Value
	end
end

local function Tasks(Prof)
	return ATSW_Tasks[realm][player][Prof or Profession()]
end

local function TasksSize(Prof)
	return table.getn(Tasks(Prof or Profession()) or {})
end

local function Task(I, Prof)
	return Tasks(Prof or Profession())[I]
end
	
local function DoTaskExist(Name, Prof)
	for I, V in pairs(Tasks(Prof or Profession())) do
		if V.Name == Name then
			return I
		end
	end
end

local function NoTasks()
	if ATSW_Tasks and ATSW_Tasks[realm] and ATSW_Tasks[realm][player] then
		local TotalAmount = 0
		
		for I in pairs(ATSW_Tasks[realm][player]) do
			TotalAmount = TotalAmount + TasksSize(I)
		end
		
		return TotalAmount == 0
	else
		return true
	end
end

local function NecessaryReagents()
	return ATSW_NecessaryReagents[realm][player]
end

local function NecessaryReagentsSize()
	return table.getn(NecessaryReagents())
end

local function NecessaryReagent(I)
	return NecessaryReagents()[I]
end

local function ResetNecessaries()
	for I = 1, NecessaryReagentsSize() do
		table.remove(NecessaryReagents(), NecessaryReagentsSize()+1-I)
	end
end

function ATSW_ShowAttributes(Value)
	if Value ~= nil and Profession() then
		ATSW_Attributes[realm][player][Profession()] = Value
		
		if SearchString() ~= '' then
			ATSW_GetRecipesSorted(true)
		end
	else
		return ATSW_Attributes[realm][player][Profession()]
	end
end

-- Sound (Open/Close) management functions and reading of last casted spell

Original_PlaySound = PlaySound

local function Stub() end

local Original_CastSpellByName = CastSpellByName
local function MyCastSpellByName(Name, OnSelf)
	local Storage = PlaySound
	
	LastCastName = Name
	
	PlaySound = Stub	
	Original_CastSpellByName(Name, OnSelf)
	PlaySound = Storage
end
CastSpellByName = MyCastSpellByName

local Original_CastSpell = CastSpell
local function MyCastSpell(spellID, spellbookType)
	
	local Storage = PlaySound
	
	LastCastName = GetSpellName(spellID, spellbookType)
	
	PlaySound = Stub
	Original_CastSpell(spellID, spellbookType)
	PlaySound = Storage
end
CastSpell = MyCastSpell

local function GetNameFromTooltip(Slot)
	ATSWActionNameTooltip:SetParent(UIParent)
	ATSWActionNameTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
	ATSWActionNameTooltip:SetAction(Slot)
	
	return ATSWActionNameTooltipTextLeft1:GetText()
end

local Original_UseAction = UseAction
local function MyUseAction(Slot, CheckCursor, OnSelf)
	local Storage = PlaySound
	
	LastCastName = GetNameFromTooltip(Slot)
	
	PlaySound = Stub
	Original_UseAction(Slot, CheckCursor, OnSelf)
	PlaySound = Storage
end
UseAction = MyUseAction

-- Craft delay detection functions

local Original_PickupContainerItem = PickupContainerItem
local function MyPickupContainerItem(Bag, Slot)
	Processing.Delay = GetTime()
	Original_PickupContainerItem(Bag, Slot)
end
PickupContainerItem = MyPickupContainerItem

local Original_BindEnchant = BindEnchant
local function MyBindEnchant()
	Processing.Delay = GetTime()
	Original_BindEnchant()
end
BindEnchant = MyBindEnchant

local Original_ReplaceEnchant = ReplaceEnchant
local function MyReplaceEnchant()
	Processing.Delay = GetTime()
	Original_ReplaceEnchant()
end
ReplaceEnchant = MyReplaceEnchant

local Original_ReplaceTradeEnchant = ReplaceTradeEnchant
local function MyReplaceTradeEnchant()
	Processing.Delay = GetTime()
	Original_ReplaceTradeEnchant()
end
ReplaceTradeEnchant = MyReplaceTradeEnchant

-- Getting information from craft list functions

local function GetRecipeID(Name)
	if Name then
		return ATSW_LinkToID(Recipe(ATSW_GetRecipePosition(Name)).Link)
	end
end

local function GetTradeSkillsPosition(Name)
	for I = 1, GetCraftCount() do
		if GetCraftNameType(I) == Name then
			return I
		end
	end
	
	return false
end

local function IsInTradeSkills(Name)
	return GetTradeSkillsPosition(Name) ~= false
end

local function DropDownFilterPass(Name)
	return not (SubClass() > 0 or InvSlot() > 0) or IsInTradeSkills(Name)
end

local function SubNameToString(SubName)
	return SubName and SubName ~= '' and ('     ' .. Color.GREY .. '(' .. SubName .. ')|r') or ''
end

function ATSW_SubNameToString(SubName)
	return SubNameToString(SubName)
end

local function SubNameToName(Name)
	if Name then
		local LName
		local _, _, SubName = string.find(Name, '%s%s%s%(+(.+)%)+')
		
		-- Triple space means SubName is in Name
		local TripleSpace = string.find(Name, '%s%s%s')
		
		if TripleSpace then
			LName = string.sub(Name, 1, TripleSpace - 1)
		else
			LName = Name
		end
		
		return LName, SubName
	end
end

local function RecipePosition(Name, List, ListSize)
	if Name and ListSize > 0 then
		local LName, SubName = SubNameToName(Name)
		
		if SubName == '' then
			SubName = nil
		end
		
		for I = 1, ListSize do
			local R = List[I]
			
			if R.Name == LName and (SubName and R.SubName == SubName or SubName == nil) then
				return R.Position
			end
		end
	end
end

local function GetRecipePosition(Name, Prof)
	if Prof == nil then
		Prof = Profession()
	end
	
	return RecipePosition(Name, Recipes(Prof), RecipesSize(Prof))
end

function ATSW_GetRecipePosition(Name, Prof)
	return GetRecipePosition(Name, Prof)
end

local function GetRecipeSortedPosition(Name)
	return RecipePosition(Name, RecipesSorted(), RecipesSortedSize())
end

local function GetPositionFromGame(Name)
	local I = 0
	local GName, GSubName
	
	local Name, SubName = SubNameToName(Name)
	
	repeat
		I = I + 1
		
		GName, GSubName = GetCraftNameType(I)

		if GName and GName == Name and (SubName and GSubName == SubName or SubName == nil) then
			return I
		end
	until not GName
	
	if not GName then
		return GetRecipePosition(Name)
	end
end

function ATSW_GetPositionFromGame(Name)
	return GetPositionFromGame(Name)
end

function ATSW_GetContractedPos(Name)
    for I = 1, table.getn(Contracted()) do
        if Contracted()[I] == Name then
            return I
        end
    end
end

function ATSW_IsContracted(Name)
	return ATSW_GetContractedPos(Name)
end

local function IsExpanded(Name)
	return not ATSW_IsContracted(Name)
end

function ATSW_GetProfessionTexture(Name)
	return GetProfessionTexture(Name)
end

local function IsBeastTraining()
	return GetProfessionTexture(Profession()) == Icon('Ability_Hunter_BeastCall02')
end

local function IsSmelting()
	return GetProfessionTexture(Profession()) == Icon('Spell_Fire_FlameBlades')
end

local function IsPoisons()
	return GetProfessionTexture(Profession()) == Icon('Trade_BrewPoison')
end

local function ClassColorize(Name)
	local Color = {
		['Druid']		= '|cffff7c0a',
		['Hunter']	= '|cffaad372',
		['Mage']		= '|cff3fc7eb',
		['Paladin']	= '|cfff48cba',
		['Priest']	= '|cffffffff',
		['Rogue']	= '|cfffff468',
		['Shaman']	= '|cff0070dd',
		['Warlock']	= '|cff8788ee',
		['Warrior']	= '|cffc69b6d'
	}

	for I in ipairs(ATSW_Characters[realm]) do
		if ATSW_Characters[realm][I].Name == Name then
			return Color[ATSW_Characters[realm][I].Class] .. Name .. '|r'
		end
	end
	
	return Name
end

local function GetCraftingTime(Name, Amount)
	local ID = GetRecipeID(Name)
	local Cost = ATSW_TimeCost[ID]
	local DB = GetSpellInfoVanillaDB or GetSpellInfoAtlasLootDB
	
	if Cost then
		return Cost*(Amount or 0)
	elseif DB then
		local AtlasID = CraftIDtoAtlasID(ID)
		
		if AtlasID then
			local castTime = DB['craftspells'][AtlasID]['castTime']
			
			return castTime
		end
	end
end

ATSW_TEST = 9000

function ATSW_TooltipSetSkill(Tooltip, Index)
	if ATSW_TradeSkill() then
		Tooltip:SetTradeSkillItem(Index)
	else
		Tooltip:SetCraftSpell(Index)
	end
end

-- Main code section

local function SetSizeAndPoints(S, Width, Point, RelativePoint, RelativeTo, X, Y)
	S:SetJustifyH('LEFT')
	S:SetJustifyV('TOP')
	S:SetWidth(Width)
	S:SetPoint(Point, RelativePoint, RelativeTo, X, Y)
end

local HelpItems = 0

local function AddHelpItem(Parameter, Description, NoReplace)
	local C = HelpItems
	
	if not Parameter 	then Parameter 	= '' end
	if not Description 	then Description	= '' end
	
	if not NoReplace then
		Parameter 	= string.gsub(Parameter, '|c', '|cffFFD100')
		Description = string.gsub(Description, '|c', '|cffFFD100')
	end
	
	local Frame 				= ATSWSearchHelpFrame
	
	local S = Frame:CreateFontString('ATSWHelp' .. C + 1, 'ARTWORK', 'GameFontHighlightSmall')
	
	if C == 0 then
		SetSizeAndPoints(S, 120, 'TOPLEFT', ATSWSearchHelpFrame, 'TOPLEFT', 20, -50)
	else
		SetSizeAndPoints(S, 120, 'TOPLEFT', 'ATSWHelp' .. C, 'BOTTOMLEFT', 0, -15)
	end
	
	S:SetText(Parameter)
	
	local D = Frame:CreateFontString('ATSWHelp' .. C + 1 .. 'Description', 'ARTWORK', 'GameFontHighlightSmall')
	
	SetSizeAndPoints(D, 265, 'TOPLEFT', S, 'TOPRIGHT')
	
	D:SetText(Description)
	
	HelpItems = C + 1
end

function ATSW_CreateListButtons()
	-- Create recipe buttons
	for R = 1, ATSW_RECIPES_DISPLAYED do
		local B = CreateFrame('Button', 'ATSWRecipe' .. R, ATSWFrame, 'ATSWRecipeButtonTemplate')
		
		B.XOffset 	= 22
		B.Position	= nil
		B.Name 	= nil
		B.Type 		= nil
		B.Possible 	= nil
		B.Text		= nil
		
		if R == 1 then
			B:SetPoint	('TOP', ATSWFrame, 'TOP', 0, -77)
		else
			B:SetPoint	('TOP', 'ATSWRecipe' .. R - 1, 'BOTTOM', 0, 0)
		end
		
		B:SetWidth	(ATSWListScrollFrame:GetWidth())
		B:SetHeight	(ATSW_TRADESKILL_HEIGHT)
		
		B:SetPoint		('LEFT', ATSWFrame, 'LEFT', B.XOffset, 0)
	end
	
	-- Set highlight frame
	ATSWHighlight:SetHeight(ATSW_TRADESKILL_HEIGHT)
	ATSWHighlightMouseOver:SetHeight(ATSW_TRADESKILL_HEIGHT)
	
	-- Create tool buttons
	for T = 1, ATSW_TOOLS_DISPLAYED do
		local B = CreateFrame('Button', 'ATSWTool' .. T, ATSWFrame, 'ATSWToolTemplate')
		
		if T == 1 then
			B:SetPoint	('LEFT', ATSWToolsLabel, 'RIGHT', 4, 0)
		else
			B:SetPoint	('LEFT', 'ATSWTool' .. T - 1, 'RIGHT', 6, 0)
		end
	end
	
	-- Create reagent buttons
	local Columns = 4
	local Row, Column
	
	for R = 1, MAX_TRADE_SKILL_REAGENTS do
		local B 	= CreateFrame('Button', 'ATSWReagent' .. R, ATSWFrame, 'ATSWReagentTemplate')
		
		Row 		= math.ceil(R/Columns)
		Column 	= R - ((Row - 1) * Columns)
		
		if Column == 1 then
			if Row == 1 then
				B:SetPoint	('TOPLEFT', ATSWReagentsLabel, 'BOTTOMLEFT', 11, -6)
			else
				B:SetPoint	('TOPLEFT', 'ATSWReagent' .. 1 + (Columns * (math.max(Row - 2, 0))) , 'BOTTOMLEFT', 0, -30)
			end
		else
			B:SetPoint		('LEFT', 'ATSWReagent' .. R - 1, 'RIGHT', 55, 0)
		end
		
		B:SetID(R)
	end
	
	-- Create task buttons
	for T = 1, ATSW_TASKS_DISPLAYED do
		local B 	= CreateFrame('Button', 'ATSWTask' .. T, ATSWFrame, 'ATSWTaskButtonTemplate')
		
		if T == 1 then
			B:SetPoint	('TOPLEFT', ATSWHorizontalBar1Left, 'TOPLEFT', 6, -14)
		else
			B:SetPoint	('TOPLEFT', 'ATSWTask' .. T - 1, 'BOTTOMLEFT', 0, -5)
		end
		
		B:SetWidth	(314)
		B:SetHeight	(ATSW_TRADESKILL_HEIGHT)
		
		local D = CreateFrame('Button', 'ATSWTask' .. T .. 'DeleteButton', B, 'UIPanelCloseButton')
		
		D:SetWidth	(18)
		D:SetHeight	(18)
		D:SetPoint		('RIGHT', ATSWTaskScrollFrame, 'RIGHT', -3, 0)
		D:SetPoint		('TOP', B, 'TOP', 0, 1)
		D:SetScript	('OnClick', ATSW_TaskDeleteOnClick)
	end
	
	-- Create search help strings
	AddHelpItem(ATSW_HELP_REAGENT, 				ATSW_HELP_REAGENT_DESC)
	AddHelpItem(ATSW_HELP_LEVEL, 					ATSW_HELP_LEVEL_DESC)
	AddHelpItem(ATSW_HELP_QUALITY, 				ATSW_HELP_QUALITY_DESC)
	AddHelpItem(ATSW_HELP_POSSIBLE, 				ATSW_HELP_POSSIBLE_DESC)
	AddHelpItem(ATSW_HELP_POSSIBLE_TOTAL, 	ATSW_HELP_POSSIBLE_TOTAL_DESC)
	AddHelpItem()
	AddHelpItem()
	AddHelpItem()
	AddHelpItem(ATSW_HELP_QNAMES, 				ATSW_HELP_QNAMES_DESC, 	true)
	AddHelpItem(ATSW_HELP_QCOLORS, 				ATSW_HELP_QCOLORS_DESC,	true)
end

local function UnregisterEvents(Frame, ...)
	for _, Event in ipairs(arg) do
		Frame:UnregisterEvent(Event)
	end
end

local function RegisterEvents(Frame, ...)
	for _, Event in ipairs(arg) do
		Frame:RegisterEvent(Event)
	end
end

function ATSW_OnLoad()
	-- Unregister events from Blizzard professions frames
	EnableAddOn('Blizzard_TradeSkillUI')
	EnableAddOn('Blizzard_CraftUI')
	LoadAddOn('Blizzard_TradeSkillUI')
	LoadAddOn('Blizzard_CraftUI')
	
	UnregisterEvents(TradeSkillFrame,
		'SKILL_LINES_CHANGED',
		'PLAYER_ENTERING_WORLD',
		'TRADE_SKILL_UPDATE',
		'UNIT_PORTRAIT_UPDATE')
	
	UnregisterEvents(CraftFrame,
		'SKILL_LINES_CHANGED',
		'CRAFT_UPDATE',
		'UNIT_PORTRAIT_UPDATE',
		'SPELLS_CHANGED',
		'UNIT_PET_TRAINING_POINTS')
	
	UnregisterEvents(UIParent,
		'TRADE_SKILL_SHOW',
		'TRADE_SKILL_CLOSE',
		'CRAFT_SHOW',
		'CRAFT_CLOSE')
	
	-- Register slash commands
    SLASH_ATSW1 				= '/atsw'
    SLASH_ATSW2 				= '/advancedtradeskillwindow'
    SlashCmdList['ATSW'] 	= ATSW_Command
	
	-- Register events
	RegisterEvents(ATSWFrame,
		'TRADE_SKILL_SHOW',
		'TRADE_SKILL_CLOSE',
		'CRAFT_SHOW',
		'CRAFT_CLOSE',
		'UNIT_PET',
		'UNIT_PET_TRAINING_POINTS',
		'BAG_UPDATE',
		'BANKFRAME_OPENED',
		'BANKFRAME_CLOSED',
		'MERCHANT_SHOW',
		'MERCHANT_UPDATE',
		'MERCHANT_CLOSED',
		'AUCTION_HOUSE_CLOSED',
		'AUCTION_HOUSE_SHOW',
		'PLAYERBANKSLOTS_CHANGED',
		'PLAYERBANKBAGSLOTS_CHANGED',
		'PLAYER_ENTERING_WORLD',
		'CHAT_MSG_SYSTEM',
		'CHAT_MSG_SKILL',
		'CHAT_MSG_LOOT',
		'CVAR_UPDATE',
		'UI_ERROR_MESSAGE')
	
	-- Attach name sort checkbox
	ATSWNameSortCheckbox:SetPoint('LEFT', ATSWDifficultySortCheckbox, 'RIGHT', ATSWDifficultySortCheckboxText2:GetWidth()+5, 0)
	
	-- Create side tabs
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local CB = CreateFrame('CheckButton', 'ATSWFrameTab' .. T, ATSWFrameSideTabsFrame, 'ATSWTabTemplate')
		
		if T == 1 then
			CB:SetPoint('TOPLEFT', ATSWFrameSideTabsFrame, 'TOPRIGHT', 0, -36)
		else
			CB:SetPoint('TOPLEFT', 'ATSWFrameTab' .. T - 1, 'BOTTOMLEFT', 0, -17)
		end
	end
	
	-- Fix Blizzard GameTooltip edges insets (from 5 to 4)
	local R, G, B, A = GameTooltip:GetBackdropColor()
	
	GameTooltip:SetBackdrop({bgFile=[[Interface\Tooltips\UI-Tooltip-Background]], edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]], tile = true, edgeSize = 16, tileSize = 16, insets = {left = 4, right = 4, top = 4, bottom = 4}})
	GameTooltip:SetBackdropColor(R, G, B, A)
	
	-- Fix a bug which shows error 'skillOffset is nil' on line 171 of Blizzard_TradeSkillUI.lua (modified by Turtle-WoW team)
	FauxScrollFrame_SetOffset(TradeSkillListScrollFrame, 0)
	
	ATSWFrame:SetMovable(true)
	ATSWFrame:EnableMouse(true)
	ATSWFrame:RegisterForDrag('LeftButton')
	ATSWFrame:SetScript('OnDragStart', function() this:StartMoving() end)
	ATSWFrame:SetScript('OnDragStop',
		function()
			this:StopMovingOrSizing()
		end
	)
end

local function SetDropDownFilter(SubClass, InvSlot)
	ATSWFrame:UnregisterEvent(	'TRADE_SKILL_UPDATE'	)
	
	local SubClasses 	= table.getn({GetTradeSkillSubClasses()})
	local InvSlots 	= table.getn({GetTradeSkillInvSlots()})
	
	if SubClasses < SubClass then
		SubClass = 0
	end
	
	if InvSlots < InvSlot then
		InvSlot = 0
	end
	
	SetTradeSkillSubClassFilter		(	SubClass, 1, 1					)
	SetTradeSkillInvSlotFilter			(	InvSlot, 1, 1					)
	
	if ATSWFrame.UpdateIsRegistered then
		ATSWFrame:RegisterEvent	(	'TRADE_SKILL_UPDATE'	)
	end
end

function ATSW_UpdateListScroll()
	FauxScrollFrame_Update			(	ATSWListScrollFrame, RecipesSortedSize(),
													ATSW_RECIPES_DISPLAYED,
													ATSW_TRADESKILL_HEIGHT,
													nil, nil, nil, ATSWHighlight, 300, 300	)
end

function ATSW_UpdateTaskListScroll()
	FauxScrollFrame_Update			(	ATSWTaskScrollFrame, TasksSize(),
													ATSW_TASKS_DISPLAYED,
													ATSW_TRADESKILL_HEIGHT-1			)
end

local function SetSortBy(Sort)
	if Profession() then
		ATSW_SortBy[realm][player][Profession()] = Sort
		ATSW_GetRecipesSorted(true)
	end
end

local OldCraftCount = 0

local function WhatReagentIsLackingData()
	for I = 1, MAX_TRADE_SKILL_REAGENTS do
		local Button 				= _G['ATSWReagent' .. I]
		local ButtonTexture 	= _G['ATSWReagent' .. I .. 'Texture']
		
		if Button:IsVisible() then
			if not (ButtonTexture:GetTexture() and Button.Name and Button.Link) then
				return Button
			end
		end
	end
	
	return false
end

function ATSW_OnUpdate(TimePassed)
	-- Loading recipes
	
    if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
		-- Update frame if trade skill count is changed
		if ATSWFrame.UpdateIsRegistered then
			if NeedToUpdate() then
				ATSW_UpdateFrame()
			end
			
			if 	UpdateCount > 0 then
				if IsBeastTraining() then
					ATSW_UpdateFrame()
				end
				
				ATSW_UpdateStatusBarRank()
				
				UpdateCount = 0
			end
		else
			 -- This check is necessary for fast initial loading while data is not in the game cache
			if OldCraftCount ~= GetCraftCount() then
				OldCraftCount = GetCraftCount()
				ATSW_UpdateFrame()
			end
		end
		
		-- Update missing recipes data
		if RecipesDataIsComplete > -1 then
			if RecipesDataTries > 0 then
				RecipesDataTries = RecipesDataTries - 1
			else
				local Complete = false
				
				SetDropDownFilter(0, 0) -- It is needed for congruence of Recipe index and Game index
				
				if RecipesSize() ~= GetCraftCount() then
					Complete = true
				else
					for I = 1, RecipesSize() do
						local R = Recipe(I)
						
						if R.Type ~= 'header' then
							if not (R.Name and R.Texture) then
								local Name 	= GetCraftNameType(I)
								local Texture	= GetCraftTexture(I)
								
								if Name and Texture then
									Complete = true
								end
							end
						end
					end
				end
				
				SetDropDownFilter(SubClass(), InvSlot())
				
				if Complete then
					RecipesDataIsComplete = -1
					ATSW_GetRecipes(true)
					ATSW_SelectRecipe(RecipeSelected())
				else
					RecipesDataIsComplete 	= RecipesDataIsComplete + 2
					RecipesDataTries 			= RecipesDataIsComplete
				end
			end
		end
		
		-- Update missing reagents data
		if not ReagentsDataIsComplete and RecipeSelected() then
			local B = WhatReagentIsLackingData()
			
			if B then
				local Name, Texture, _, _, Link = GetReagentData(B.RecipeIndex, B.ReagentIndex)
				
				ReagentsDataIsComplete = (Name and Texture and Link) ~= nil
				
				if ReagentsDataIsComplete then
					for I = 1, RecipesSize() do
						local R = Recipe(I)
						
						for J = 1, R.ReagentsSize do
							local Rt = R.Reagents[J]
							
							Rt.Name, Rt.Texture, Rt.Amount, Rt.PlayerAmount, Rt.Link = GetReagentData(I, J)
						end
					end
					
					ATSW_SelectRecipe(RecipeSelected())
				end
			end
		end
		
		-- Update scroll offset
		if ScrollOffset() and ATSWListScrollFrameScrollBar:GetValue() ~= ScrollOffset() then
			ATSWListScrollFrameScrollBar:SetValue(ScrollOffset())
		end
		
		-- Update cooldowns
		if GetTime() - 1 >= CooldownUpdateTime then
			-- Set cooldowns for recipe buttons
			for I = 1, ATSW_RECIPES_DISPLAYED do
				local Button = _G['ATSWRecipe' .. I]
				local ButtonSubText = _G['ATSWRecipe' .. I .. 'SubText']
				
				if Button:IsVisible() and Button.Position and not IsBeastTraining() then
					ButtonSubText:SetText(ConvertCooldown(Recipe(Button.Position).Cooldown) or '')
				end
			end
			
			-- Set cooldowns for task buttons
			for I = 1, ATSW_TASKS_DISPLAYED do
				local Button = _G['ATSWTask' .. I]
				
				if Button:IsVisible() and Button.Position then
					Button:SetText(Button.Text .. (ConvertCooldown(Recipe(Button.Position).Cooldown) or ''))
				end
			end
			
			-- Set cooldown for schematic
			if ATSWRecipeCooldown.Cooldown then
				local CD = ConvertCooldown(ATSWRecipeCooldown.Cooldown, true)
				
				if CD then
					ATSWRecipeCooldown:SetText(COOLDOWN_REMAINING .. ' ' .. CD)
				else
					ATSWRecipeCooldown.Cooldown = nil
					ATSWRecipeCooldown:SetText('')
				end
			end
			
			-- If cooldowns in recipes are expired, then set them to nil and update Create button
			for I = 1, RecipesSize() do
				local R = Recipe(I)
				
				if R.Cooldown and R.Cooldown < GetTime() then
					R.Cooldown = nil
					
					if DoTaskExist(R.Name) or R.Name == RecipeSelected() then
						ATSW_UpdateCreateButton()
					end
				end
			end
			
			CooldownUpdateTime = GetTime()
		end
		
		ATSW_ArmorCraftCompatibility()
    end
	
	-- Progress bar
	
	if ATSWProgressBar.Working then
		local Bar 			= ATSWProgressBar
		local Border 		= ATSWProgressBarBorder
		local Spark 		= ATSWProgressBarSpark
		local Stop			= ATSWProgressBarStop
		local Glow 		= ATSWProgressBarGlow
		local ItemFound
		
		for I = 1, ATSW_TASKS_DISPLAYED do
			local Button 	= _G['ATSWTask' .. I]
		
			if Button.Name == Processing.Recipe then	
				ItemFound = true
				
				if not Bar.TaskItem or Bar.TaskItem ~= Button then
					Bar:		SetParent(Button)
					Bar:		SetPoint('TOPLEFT', Button:GetName(), 'TOPLEFT', -2, 0)
					Bar:		SetFrameLevel(12)
					Border:	SetFrameLevel(13)
					Spark:	SetFrameLevel(14)
					Button:	SetFrameLevel(15)
					
					Bar.TaskItem = Button
				end
				
				break
			end
		end
		
		if ItemFound then
			if not Bar:IsVisible() then
				Bar:			Show()
				
				if Bar.Mode == ATSW_CAST then
					Spark:	Show()
					Stop:	SetParent(Bar)
					Stop:	SetFrameLevel(15)
					Stop:	Show()
				end
			end
		else
			Bar:				Hide()
			Stop:			Hide()
		end
		
		if Bar.Mode == ATSW_CAST then
			if GetTime() < Bar.EndTime then
				Bar:		SetValue(GetTime())
				Spark:	SetPoint('CENTER', Bar, 'LEFT', (1 - (Bar.EndTime - GetTime())/(Bar.EndTime - Bar.StartTime)) * Bar:GetWidth(), -1)
			else
				if IsEnchant(Processing.Texture) then
					Bar.Mode = ATSW_FLASH
				end
			end
			
			local TimeLeft 	= Bar.EndTime - GetTime()
			
			ATSWProgressBarStopSubText:SetText(ShortFormatCooldown(TimeLeft+1, true))
		elseif Bar.Mode == ATSW_FLASH then 		-- Glow appearing
			local Alpha = Glow:GetAlpha() + TimePassed / ATSW_FLASH_TIME
			
			Glow:			SetAlpha(math.min(Alpha, 1))
			
			if Spark:IsVisible() then
				local Min, Max = Bar:GetMinMaxValues()
				
				Bar:		SetValue(Max)
				Stop:	Hide()
				Spark:	Hide()
			end
			
			if Alpha >= 1 then
				Bar.Mode = ATSW_FADEOUT
			end
		elseif Bar.Mode == ATSW_FADEOUT then 	-- Glow disappearing
			local Alpha = Glow:GetAlpha() - TimePassed / ATSW_FADEOUT_TIME
			
			if Alpha > 0 then
				Glow:	SetAlpha(Alpha)
				Bar:		SetAlpha(Alpha)
				
				if Bar:IsVisible() and Task(Bar.TaskItem.TaskIndex).Amount == 1 then
					Bar.TaskItem:SetAlpha(Alpha)
				end
			else
				ATSW_CompleteTask()
				Bar:		Hide()
			end
		end
	end
	
	-- Delay functions
	
	if Delayed and GetTime() > ATSW_InTime then
		ATSW_Delayed()
		Delayed = false
	end
end

function ATSW_Delayed()
end

local function Delay(Function, Time)
	ATSW_Delayed = Function
	ATSW_InTime = GetTime() + Time
	Delayed = true
end

function ATSW_ProfessionExists(Prof)
	if Prof then
		local _, _, _, NumSpells = GetSpellTabInfo(1)
		
		for I in ipairs(Professions) do
			local ProfessionTexture = Icon(Professions[I])
		
			for B = 1, NumSpells do
				local Texture 	= GetSpellTexture	(B, 'BOOKTYPE_SPELL')
				local Name		= GetSpellName		(B, 'BOOKTYPE_SPELL')
				
				if Texture and Texture == ProfessionTexture and string.find(Name, Prof) then
					return true
				end
			end
		end
	end
end

local function GetFirstProfession()
	local _, _, _, NumSpells = GetSpellTabInfo(1)
	
	-- Search spell book by texture
	for I in ipairs(Professions) do
		local ProfessionTexture = Icon(Professions[I])
		
		for B = 1, NumSpells do
			local Texture	= GetSpellTexture	(B, 'BOOKTYPE_SPELL')
			
			if Texture and Texture == ProfessionTexture then
				return GetSpellName(B, 'BOOKTYPE_SPELL')
			end
		end
	end
end

local function ResetTabs()
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local Tab = _G['ATSWFrameTab'..T]
		
		if Tab then
			Tab.Name = nil
			
			local NormalTexture = Tab:GetNormalTexture()
			
			if NormalTexture then
				NormalTexture:SetTexture(nil)
			end
		end
	end
end

local function TabExists(Texture)
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local Tab = _G['ATSWFrameTab'..T]
		
		if Tab then
			local NormalTexture = Tab:GetNormalTexture()
			
			if NormalTexture then
				local TabTexture = NormalTexture:GetTexture()
				
				if TabTexture and string.lower(TabTexture) == string.lower(Texture) then
					return true
				end
			end
		end
	end
end

local function ChangeSmeltingIcon(Texture)
	if Texture == 'Interface\\Icons\\Spell_Fire_FlameBlades' then
		return 'Interface\\AddOns\\AdvancedTradeSkillWindow2\\Textures\\Smelting'
	end
	
	return Texture
end

function ATSW_ConfigureSkillButtons(Exception)
	local _, _, _, NumSpells = GetSpellTabInfo(1)

	ResetTabs()
	
	-- Iterate tabs
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local Tab = _G['ATSWFrameTab' .. T]
		local TabName, TabTexture
		
		-- Iterate professions
		for I in ipairs(Professions) do
			local ProfessionTexture = Icon(Professions[I])
			
			ProfessionTexture = ChangeSmeltingIcon(ProfessionTexture)
			
			if not TabExists(ProfessionTexture) then
				-- Scan spell book for professions
				for B = 1, NumSpells do
					local Texture 	= GetSpellTexture	(B, 'BOOKTYPE_SPELL')
					local Name		= GetSpellName		(B, 'BOOKTYPE_SPELL')
					
					Texture = ChangeSmeltingIcon(Texture)
					
					if Name ~= Exception and Texture and Texture == ProfessionTexture then
						TabName 		= GetSpellName(B, 'BOOKTYPE_SPELL')
						TabTexture 	= Texture
						
						break
					end
				end
				
				if TabTexture then
					break
				end
			end
		end
		
		SetVisible(Tab, TabTexture)
		
		Tab.Name = TabName
		Tab:SetNormalTexture(TabTexture)
	end
	
	if Profession() then
		ATSW_SelectTab(Profession())
	end
end

function ATSW_SelectTab(Name)
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local Tab = _G['ATSWFrameTab' .. T]
		
		Tab:SetChecked(Tab.Name == Name)
	end
end

function ATSW_AttachTabsTo(Frame)
	if ATSWFrameSideTabsFrame:GetParent() ~= Frame then
		ATSWFrameSideTabsFrame:SetParent(Frame)
		ATSWFrameSideTabsFrame:SetPoint('TOPLEFT', Frame, 'TOPRIGHT', -59, -28)
		ATSWFrameSideTabsFrame:Show()
	end
end

function ATSW_SwitchToFrame(Frame)
	local function GetFrame(F)
		if 			F == 1 then return ATSWFrame
		elseif 	F == 2 then return ATSWCSFrame end
	end
	
	ATSW_SwitchingFrames = true
	
	if ATSW_SwitchingToMain then
		ATSW_SwitchingToMain = false
	else
		if Frame and not (GetFrame(1):IsVisible() or GetFrame(2):IsVisible()) then
			Original_PlaySound('igCharacterInfoOpen')
		end
	end
	
	for I = 1, 2 do
		local F = GetFrame(I)
		
		if F:IsVisible() and F ~= Frame then
			if Frame == ATSWCSFrame then
				ATSW_SwitchingToEditor = true
			end
			
			HideUIPanel(F)
		end
	end
	
	for I = 1, 2 do
		local F = GetFrame(I)
		
		if not F:IsVisible() and F == Frame then
			ShowUIPanel				(F)
			ATSW_AttachTabsTo	(F)
			
			if not (BlizzMo and ATSWFrame.settings and ATSWFrame.settings.save) then
				if MerchantFrame:IsVisible() then
					local oldCenter = UIParent.center
					
					UIParent.center = nil
					SetCenterFrame(F)
					UIParent.center = oldCenter
				else
					local oldLeft = UIParent.left 
					
					UIParent.left = nil
					SetLeftFrame(F)
					UIParent.left = oldLeft
				end
			end
		end
	end
	
	if not Frame and Processing.Active then
		Processing.Stop = true
	end
	
	ATSW_SwitchingFrames = false
end

local function LoadAllProfessionsOnce()
	if not LoadingProfessions then
		LoadingProfessions 			= true
		
		local CurrentProfession 	= GetCraftCaption()
		local LastName				=	CurrentProfession
		
		local _, _, _, NumSpells 	= GetSpellTabInfo(1)
		
		ATSWFrame:	UnregisterEvent(	'TRADE_SKILL_SHOW'	)
		ATSWFrame:	UnregisterEvent(	'TRADE_SKILL_CLOSE'	)
		ATSWFrame:	UnregisterEvent(	'CRAFT_SHOW'				)
		ATSWFrame:	UnregisterEvent(	'CRAFT_CLOSE'				)
		
		local OldSound 				= PlaySound
		PlaySound 					= Stub
		
		for I in ipairs(Professions) do
			local ProfessionTexture = Icon(Professions[I])
			
			for B = 1, NumSpells do
				local Texture			= GetSpellTexture	(B, 'BOOKTYPE_SPELL')
				local Name 			= GetSpellName		(B, 'BOOKTYPE_SPELL')
				
				if Name and not string.find(Name, CurrentProfession) and Texture == ProfessionTexture then
					CastSpellByName(Name)
					LastName = Name
					
					break
				end
			end
		end
		
		if LastName ~= CurrentProfession then
			CloseTradeSkill()
			CloseCraft()
			CastSpellByName(CurrentProfession)
		end
		
		PlaySound 						= OldSound
		
		ATSWFrame:	RegisterEvent(	'TRADE_SKILL_SHOW'	)
		ATSWFrame:	RegisterEvent(	'TRADE_SKILL_CLOSE'	)
		ATSWFrame:	RegisterEvent(	'CRAFT_SHOW'				)
		ATSWFrame:	RegisterEvent(	'CRAFT_CLOSE'				)
	end
end

local function ATSW_Show()
	LoadAllProfessionsOnce()
	-- This function will cause all learned professions recipe data to load into the game from the server at once.
	-- After the user chose another profession the recipe data is already in the game to be loaded into the frame.
	
	if not InitializedOnShow then
		ATSW_CreateListButtons()
		
		for I = 1, ATSW_TASKS_DISPLAYED do
			_G['ATSWTask' .. I .. 'DeleteButton']:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
			_G['ATSWTask' .. I .. 'DeleteButton']:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
		end
		
		ATSW_ConfigureSkillButtons()
		ATSW_AtlasLoot = ATSW_CheckForAtlasLootLoaded()
		
		InitializedOnShow = true
	end
	
	ATSW_InitializeFrame					()
	ATSW_UpdateCaption					()
	ATSW_ShowSort						()
	ATSW_ShowSearch					()
	ATSW_UpdateBackground			()
	ATSW_SelectTab						(Profession())
	ATSW_ShowAmount					()
	ATSW_ShowAmountMenu			(TradeSkill)
	ATSW_ShowDropDownMenu		(TradeSkill)
	ATSW_ShowReagentsButton		(not IsBeastTraining())
	ATSW_ShowTaskButton				(not IsBeastTraining())
	ATSW_ShowTrainingPointsMenu	(IsBeastTraining())
	
	ATSWAttributesButton:SetChecked(ATSW_ShowAttributes())
	
	if RecipesSize() > 0 then
		ATSW_GetRecipes()
		ATSW_ShowSelection()
		ATSW_UpdateTasks()
		
		if SortBy() == 'Custom' then
			ATSWCS_FillAllRecipes()
			ATSWCS_Update()
		end
	end
	
	if NoTasks() then
		ResetNecessaries()
	end
	
	ATSW_SwitchToFrame(ATSWFrame)
	
	ATSWUpdaterFrame:Show()
	ATSW_UpdateListScroll()
end

function CloseATSW()
	if ATSW_TradeSkill() then
		CloseTradeSkill()
	else
		CloseCraft()
	end
end

function ATSW_Hide()
	if UIParent:IsVisible() then
		ATSW_SwitchToFrame()
		Original_PlaySound('igCharacterInfoClose')
	end
	
	if ATSW_SwitchingToEditor then
		ATSW_SwitchingToEditor = false
	else
		PlaySound('igCharacterInfoClose')
	end
	
	ATSWUpdaterFrame:Hide()
end

local function InitializeTable(Table, Value, Prof)
	if Prof == nil then
		Prof = Profession()
	end

	if Table 							== nil 	then Table 								= {} 		end
	if Table[realm] 					== nil 	then Table[realm] 						= {} 		end
	if Table[realm][player] 		== nil 	then Table[realm][player] 			= {} 		end
	if Table[realm][player][Prof] == nil 	then Table[realm][player][Prof]	= Value 	end
end

local function InitializeTables()
	local function InitializeContractedCategories()
		local Table = ATSW_ContractedCategories
		
		InitializeTable(Table, {})
		
		if 	Table[realm][player][Profession()]['Category'] == nil 	then
			Table[realm][player][Profession()]['Category'] = {}
		end
		
		if 	Table[realm][player][Profession()]['Custom'] == nil 	then
			Table[realm][player][Profession()]['Custom'] = {}
		end
	end
	
	InitializeTable(ATSW.Recipes, 				{}			)
	InitializeTable(ATSW.RecipesSize, 			0				)
	InitializeTable(ATSW.RecipesSorted, 		{}			)
	InitializeTable(ATSW.RecipesSortedSize, 0				)
	InitializeTable(ATSW_SelectedRecipe, 	nil			)
	InitializeTable(ATSW_Attributes, 			false			)
	InitializeTable(ATSW_NeedToUpdate, 	true			)
	InitializeTable(ATSW_SortBy, 				'Category'	)
	InitializeTable(ATSW_SearchString, 		''				)
	InitializeTable(ATSW_SubClassFilter, 		0				)
	InitializeTable(ATSW_InvSlotFilter, 		0				)
	InitializeTable(ATSW_ScrollOffset, 			0				)
	InitializeTable(ATSW_Amount, 				0				)
	InitializeTable(ATSW_PreviousRecipes, 	{}			)
	InitializeTable(ATSW_Tasks, 					{}			)
	InitializeTable(ATSW_CustomCategories, {}			)
	InitializeTable(ATSW_CSOpenCategory, 	0				)
	InitializeTable(ATSW_CSSelected, 			''				)
	
	InitializeContractedCategories()
end

local function InitializeProfession()
	local Table = ATSW_Profession
	
	if not Table 						then Table = {} 						end
	if not Table[realm] 			then Table[realm] = {} 				end
	if not Table[realm][player] 	then Table[realm][player] = nil 	end
end

local function GetProfession()
	InitializeProfession()
	
	local Skill = GetCraftCaption()
	
	if Skill and Skill ~= 'UNKNOWN' then
		ATSW_Profession[realm][player] = Skill
	end
	
	return Skill
end

function ATSW_UpdateStatusBarRank()
	local _, Rank, MaxRank 	= GetCraftCaption()
	
	SetVisible(ATSWRankFrame, 		Rank > 0)
	SetVisible(ATSWRankFrameRank, 	MaxRank > 0)
	SetVisible(ATSWRankFrameSpark,	Rank ~= MaxRank)
	
	if ATSWRankFrame:IsVisible() then
		ATSWRankFrame:			SetMinMaxValues(0, MaxRank)
		ATSWRankFrame:			SetValue(Rank)
		ATSWRankFrameSpark:	SetPoint('CENTER', ATSWRankFrame, 'LEFT', ATSWRankFrame:GetWidth() * Rank/MaxRank, 0)
	end
	
	if ATSWRankFrameRank:IsVisible() then
		ATSWRankFrameRank:		SetText(Rank .. '/' .. MaxRank)
	end
end

function ATSW_InitializeFrame()
	local SameProfession = GetCraftCaption() == Profession()
	
	if not SameProfession or RecipesSize() == 0 then
		GetProfession					()
		InitializeTables					()
		ATSW_ShowDropDown	()
		
		if RecipesSize() == 0 then
			ATSW_HideRecipes			()
			ATSW_HideRecipe			()

			ATSW_HideTasks			()
		end
	end
	
	if IsBeastTraining() then -- This is an easy and quick fix of an issue, not a solid complete solution
		ATSW_HideRecipe()
	end
end

function ATSW_UpdateBackground()
	local BG = ATSW_Background[GetProfessionTexture(Profession())]
	
	if BG then
		ATSWBackground:SetTexture('Interface\\AddOns\\AdvancedTradeSkillWindow2\\Textures\\Background\\' .. BG)
	else
		ATSWBackground:SetTexture(nil)
	end
end

function ATSW_FindSpecialization()
		local I = 0
		local STexture
		local Specs = ATSW_Specializations[GetProfessionTexture(Profession())]
		
		if Specs then
			repeat
				I = I + 1
				
				STexture = GetSpellTexture(I, BOOKTYPE_SPELL)
				
				if STexture then
					for S = 1, table.getn(Specs) do
						if STexture == Icon(Specs[S]) then
							return Color.GREY .. ' (' .. GetSpellName(I, BOOKTYPE_SPELL) .. ')|r'
						end
					end
				end
			until not STexture or I == 36
		end
		
		return ''
	end

function ATSW_UpdateCaption()
	local Name = GetCraftCaption()
	
	-- Set status bar info
	
	ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), Name) .. ATSW_FindSpecialization())
	ATSW_UpdateStatusBarRank()
	
	-- Set skill portrait
	SetPortraitToTexture(ATSWFramePortrait, GetProfessionTexture(Name))
end

function ATSW_UpdateFrame()
	ATSW_InitializeFrame()
	ATSW_GetRecipes(true)
	ATSW_ShowSelection()
	
	if NoDropDownUpdate then
		NoDropDownUpdate = false
	else
		ATSW_ShowDropDown()
	end
	
	if SortBy() == 'Custom' then
		ATSWCS_FillAllRecipes()
		ATSWCS_Update()
	end
	
	SetNeedToUpdate(Profession(), false)
	
	if not ATSWFrame.UpdateIsRegistered and RecipesSize() > 0 and RecipesSize() == GetCraftCount()  then
		ATSWFrame:RegisterEvent(	'TRADE_SKILL_UPDATE'				)
		ATSWFrame:RegisterEvent(	'CRAFT_UPDATE'						)
		ATSWFrame.UpdateIsRegistered = true
	end
	
	ATSW_UpdateTasks()
	ATSW_ShowTrainingPoints()
end

function ATSW_OnEvent()
	if ATSW_Debug then
		local s = ''
		
		if arg1 	then s = s .. ' (|cffB0B0B0arg1|r = '  .. 	'|cffFFD100' .. arg1 .. '|r' 	end
		if arg2 	then s = s .. ', |cffB0B0B0arg2|r = '  ..	'|cffFFD100' .. arg2 .. '|r' 	end
		if arg3 	then s = s .. ', |cffB0B0B0arg3|r = '  ..	'|cffFFD100' .. arg3 .. '|r' 	end
		if arg4 	then s = s .. ', |cffB0B0B0arg4|r = '  ..	'|cffFFD100' .. arg4 .. '|r' 	end
		if arg5 	then s = s .. ', |cffB0B0B0arg5|r = '  ..	'|cffFFD100' .. arg5 .. '|r' 	end
		if arg6 	then s = s .. ', |cffB0B0B0arg6|r = '  ..	'|cffFFD100' .. arg6 .. '|r' 	end
		if arg7 	then s = s .. ', |cffB0B0B0arg7|r = '  ..	'|cffFFD100' .. arg7 .. '|r' 	end
		if arg8 	then s = s .. ', |cffB0B0B0arg8|r = '  ..	'|cffFFD100' .. arg8 .. '|r' 	end
		if arg9 	then s = s .. ', |cffB0B0B0arg9|r = '  ..	'|cffFFD100' .. arg9 .. '|r' 	end
		if arg10	then s = s .. ', |cffB0B0B0arg10|r = ' ..	'|cffFFD100' .. arg10 .. '|r' 	end
		
		if s ~= '' then s = s .. ')' end
		
		-- Filter NPCScan TargetUnit() spam
		if not (event == 'UI_ERROR_MESSAGE' and string.find(arg1, ERR_UNIT_NOT_FOUND)) then
			Debug('|cffB0B0B0event|r = ' .. '|cffFFD100' .. tostring(event) .. '|r' .. s)
		end
	end
	
    if 			event == 'UNIT_PET'									then
	
		ATSW_ShowTrainingPoints()
		
    elseif 	event == 'UNIT_PET_TRAINING_POINTS' 		then
	
		ATSW_ShowTrainingPoints()
	
    elseif 	event == 'BANKFRAME_OPENED'
    or 		event == 'PLAYERBANKSLOTS_CHANGED'
    or 		event == 'PLAYERBANKBAGSLOTS_CHANGED' 	then
		
		BankFrameOpened = true
        ATSW_SaveBank()
	
    elseif 	event == 'BANKFRAME_CLOSED' 					then
	
		BankFrameOpened = false
	
    elseif 	event == 'MERCHANT_SHOW' 						then
		
        ATSW_UpdateMerchant()
        
		if ATSW_Options.AutoBuy then
			ATSW_BuyFromMerchant()
		else
			ATSW_SetBuyFrameVisible()
		end
		
		if ATSWFrame:IsVisible() and not (BlizzMo and ATSWFrame.settings and ATSWFrame.settings.save) then
			local oldCenter = UIParent.center
			
			UIParent.center = nil
			SetCenterFrame(ATSWFrame)
			UIParent.center = oldCenter
		end
    elseif 	event == 'MERCHANT_CLOSED' 						then
	
		ATSWBuyNecessaryFrame:Hide()
		
		if ATSWFrame:IsVisible() and not (BlizzMo and ATSWFrame.settings and ATSWFrame.settings.save) then
			local oldLeft = UIParent.left 
			
			UIParent.left = nil
			SetLeftFrame(ATSWFrame)
			UIParent.left = oldLeft
		end
    elseif 	event == 'MERCHANT_UPDATE' 						then
	
		ATSW_UpdateMerchant()
	
    elseif 	event == 'AUCTION_HOUSE_SHOW' 				then
	
        ATSW_ShowAuctionShoppingList()
	
    elseif 	event == 'AUCTION_HOUSE_CLOSED' 			then
	
        ATSWShoppingListFrame:Hide()
	
    elseif 	event == 'BAG_UPDATE' 								then
		if BankFrameOpened then
			ATSW_SaveBank()
		end
		
		ATSW_SaveBag(arg1)
		
		if ATSWFrame:IsVisible() then
			-- Check if a selected tool is update
			for Slot = 1, GetContainerNumSlots(arg1) do
				local function ToolIsUpdating(BID)
					for I = 1, ATSW_TOOLS_DISPLAYED do
						local Button = _G['ATSWTool' .. I]
						
						if Button:IsVisible() then
							local ToolID = ToolID[Button.Name]
						
							if BID == ToolID then
								return true
							end
						end
					end
					
					return false
				end
				
				local BID = ATSW_LinkToID(GetContainerItemLink(arg1, Slot))
				
				if ToolIsUpdating(BID) then
					ATSW_SelectRecipe(RecipeSelected())
				end
			end
		end
		
		-- Update all frame sections
		
		if ATSWFrame:					IsVisible() 	then 	ATSW_UpdateRecipes					()
																			ATSW_UpdateTasks					()
																			
		if RecipeSelected()								then 	ATSW_SelectRecipe(RecipeSelected()) 	end end
		
		if ATSWCSFrame:				IsVisible() 	then 	ATSWCS_UpdateATSWFrame		()
																			ATSWCS_Update						()		end
		
		ATSW_UpdateNecessaryReagents()
		
		if MerchantFrame:				IsVisible() 	then 	ATSW_SetBuyFrameVisible			() 	end
		if ATSWShoppingListFrame:	IsVisible() 	then 	ATSW_UpdateAuctionList			() 	end
		
    elseif 	event == 'TRADE_SKILL_UPDATE'
	or 		event == 'CRAFT_UPDATE' 							then
		
		UpdateCount = UpdateCount + 1
	
    elseif 	event == 'SPELLCAST_START'  						then
		
		if arg1 == Processing.Recipe and not Processing.Active then
			local function ColorizeProgressBar()
				local R, G, B = 1, 0.82, 0
				
				local Colors = {
					[2840] 	= {R = 0.72, G = 0.45, B = 0.20}, -- Copper
					[3576] 	= {R = 1.00, G = 0.89, B = 0.48}, -- Tin
					[2841] 	= {R = 0.80, G = 0.67, B = 0.36}, -- Bronze
					[2842] 	= {R = 0.75, G = 0.75, B = 0.78}, -- Silver
					[3575] 	= {R = 0.62, G = 0.63, B = 0.65}, -- Iron
					[3577] 	= {R = 1.00, G = 0.84, B = 0.00}, -- Gold
					[3859] 	= {R = 0.64, G = 0.72, B = 0.68}, -- Steel
					[3860] 	= {R = 0.74, G = 0.85, B = 0.67}, -- Mithril
					[6037] 	= {R = 0.85, G = 0.98 ,B = 0.98}, -- Truesilver
					[12359] = {R = 0.50, G = 0.75, B = 0.71}, -- Thorium
					[11371] = {R = 0.57, G = 0.56, B = 0.54}, -- Dark Iron
					[17771] = {R = 0.78, G = 0.73 ,B = 0.86}, -- Elementium
				}
				
				local function GetColor(ID)
					return Colors[ID].R, Colors[ID].G, Colors[ID].B
				end
				
				if IsSmelting() then
					R, G, B = GetColor(GetRecipeID(Processing.Recipe))
				end
				
				ATSWProgressBarTexture:SetVertexColor(R, G, B)
			end
			
			Processing.RecipeTime = arg2 / 1000
			
			local ID = GetRecipeID(arg1)
			
			if ID then
				ATSW_TimeCost[ID] = Processing.RecipeTime
			end
			
			local CastTime = Processing.RecipeTime
			
			if TradeSkill then
				CastTime = CastTime * Processing.Amount
			end
			
			ATSW_InitializeProgressBar(Processing.Delay, (Processing.Delay + CastTime))
			ColorizeProgressBar()
			Processing.Delay = GetTime() - Processing.Delay
			ATSW_StartProcessing()
		end
		
	elseif	event == 'SPELLCAST_INTERRUPTED'				then
		
		ATSW_StopProcessing()
		
	elseif 	event == 'PLAYER_ENTERING_WORLD' 			then
		
		ATSW_SaveBag(0)
		ATSW_Hide()
		
		-- Initialize Table
		local Table = ATSW_NecessaryReagents

		if Table == nil then
			Table = {}
		end
		
		if Table[realm] == nil then
			Table[realm] = {}
		end
		
		if Table[realm][player] == nil then
			Table[realm][player] = {}
		end
		
		if ATSW_Characters then 
			if ATSW_Characters[realm] then
				for I in ipairs(ATSW_Characters[realm]) do
					if ATSW_Characters[realm][I].Name == player then
						return
					end
				end
			else
				ATSW_Characters[realm] = {}
			end
		end
		
		table.insert(ATSW_Characters[realm], {
			Name 	= player,
			Class		= class
		})
		
	elseif 	event == 'CHAT_MSG_SYSTEM' 						then
	
		if string.find(arg1, ERR_LEARN_RECIPE_PATTERN)
		or string.find(arg1, ERR_LEARN_SPELL_PATTERN) then 				-- Learn new recipe event
			SetNeedToUpdate()
		end
		
		if string.find(arg1, ERR_UNLEARN_RECIPE_PATTERN) then 			-- Unlearn profession event
			local _, _, Skill = string.find(arg1, ERR_UNLEARN_RECIPE_PATTERN)
			
			if ATSW_ProfessionExists(Skill) then
				-- Reset previous recipes
				for I = 1, PreviousRecipesSize(Skill) do
					table.remove(PreviousRecipes(Skill), PreviousRecipesSize(Skill)-1+I)
				end
				
				ATSW_ConfigureSkillButtons(Skill) -- Reconfigure tabs except Skill
				
				-- Reset tasks
				for I = 1, TasksSize(Skill) do
					ATSW_DeleteTask(Task(I, Skill).Name, nil, Skill)
				end
				
				-- Reset necessary settings
				ATSW_SelectedRecipe	[realm][player][Skill]	= nil
				ATSW.RecipesSize			[realm][player][Skill]	= 0
				ATSW.RecipesSortedSize	[realm][player][Skill]	= 0
				ATSW_SubClassFilter		[realm][player][Skill]	= 0
				ATSW_InvSlotFilter			[realm][player][Skill]	= 0
				ATSW_SelectedRecipe	[realm][player][Skill]	= nil
				ATSW_ScrollOffset			[realm][player][Skill]	= 0
				
				if Skill == Profession() then
					ATSW_Profession[realm][player]		= nil
					
					ATSW_SwitchToFrame() -- Hide frame if Skill is selected
				end
			end
		end
	elseif 	event == 'CHAT_MSG_LOOT' 						then
		
		-- Task completion
		if Processing.Active then
			if string.find(arg1, LOOT_ITEM_CREATED_SELF_PATTERN) then -- React on 'You create: %s' pattern
				Bar = ATSWProgressBar
				
				if Processing.Amount > 1 then
					ATSW_CompleteTask()
				else
					if Processing.Stop then
						ATSW_CompleteTask() -- Complete immediately
					else
						Bar.Mode = ATSW_FLASH -- Start flash animation
					end
				end
				
				RecipesRemaining = Processing.Amount - Processing.Complete
				
				TimePassed 	= GetTime() - Bar.StartTime
				ERT 				= (Processing.RecipeTime + GetLatency()) * RecipesRemaining -- Estimated remaining time
				
				Bar.EndTime = GetTime() + TimePassed + ERT
				
				Bar:SetMinMaxValues(Bar.StartTime, Bar.EndTime)
			end
		end
	elseif 	event == 'CHAT_MSG_SKILL' 							then
	
		if string.find(arg1, ERR_SKILL_UP_PATTERN) then						-- Increase profession rank event
			local _, _, Skill = string.find(arg1, ERR_SKILL_UP_PATTERN)
			
			NoDropDownUpdate = true
			
			if ATSW_ProfessionExists(Skill) then
				SetNeedToUpdate(Skill)
			else
				SetNeedToUpdate()
			end
			
			ATSW_UpdateStatusBarRank()
		elseif string.find(arg1, ERR_SKILL_GAINED_PATTERN) then 			-- Learn new profession event
			ATSW_ConfigureSkillButtons()
		end
	elseif 	event == 'CVAR_UPDATE' 								then
		if arg1 		== 'USE_UISCALE' 		then
			ATSWRecipeTooltip:SetScale(GetCVar('uiscale'))
		elseif arg1	== 'WINDOWED_MODE'	then
			-- Fix for BarGlow texture becomes white if toggling windowed mode
			ATSWProgressBarGlow:SetTexture(nil)
			ATSWProgressBarGlow:SetTexture('Interface\\AddOns\\AdvancedTradeSkillWindow2\\Textures\\ProgressBarFlash')
			ATSWOptionsMenuHeader:SetTexture(nil)
			ATSWOptionsMenuHeader:SetTexture('Interface\\AddOns\\AdvancedTradeSkillWindow2\\Textures\\UI-DialogBox-Header')
		end
	elseif 	event == 'UI_ERROR_MESSAGE' 						then
		if Processing.Active and (string.find(arg1, ERR_INV_FULL) or string.find(arg1, ERR_ITEM_MAX_COUNT) or string.find(arg1, sRequires)) then
			ATSW_StopProcessing()
		end
	elseif 	event == 'TRADE_SKILL_SHOW' 						then
		if UIParent:IsVisible() then
			if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
				ATSWFrame:	UnregisterEvent	('CRAFT_CLOSE'		)
				CloseCraft()
				ATSWFrame:	RegisterEvent		('CRAFT_CLOSE'		)
			end
			
			TradeSkill = true
			ATSW_Show()
		else
			CloseTradeSkill()
		end
	elseif 	event == 'CRAFT_SHOW' 									then
		if UIParent:IsVisible() then
			if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
				ATSWFrame:	UnregisterEvent	('TRADE_SKILL_CLOSE')
				CloseTradeSkill()
				
				if TradeSkill then
					Processing.Stop = true
				end
				
				ATSWFrame:	RegisterEvent		('TRADE_SKILL_CLOSE')
			end
		
			TradeSkill = false
			ATSW_Show()
		else
			CloseCraft()
		end
	elseif event == 'TRADE_SKILL_CLOSE' then
		ATSW_Hide()
	elseif event == 'CRAFT_CLOSE' then
		ATSW_Hide()
    end
end

-- Control

local function SetSortCheckboxes(Sort)
	ATSWCategorySortCheckbox:	SetChecked(	Sort == 'Category'	)
	ATSWDifficultySortCheckbox:	SetChecked(	Sort == 'Difficulty'		)
	ATSWNameSortCheckbox:		SetChecked(	Sort == 'Name'			)
	ATSWCustomSortCheckbox:		SetChecked(	Sort == 'Custom'		)
	SetVisible(ATSWCustomEditorButton, Sort == 'Custom')
end

function ATSW_SortCheckbox_OnClick()
	SetSortBy(this.Sort)
	SetSortCheckboxes(this.Sort)
end

local function FilterDropDownButton_OnClick(This, Filter, SetFilter, FilterDropDown, SetTradeSkillFilter)
	local Value = This:GetID() - 1
	
	if Value ~= Filter then
		SetFilter(Value)
		UIDropDownMenu_SetSelectedID(FilterDropDown, Value + 1)
		SetTradeSkillFilter(Value, 1, 1)
		
		ATSW_GetRecipesSorted(true)
	end
end

function ATSWSubClassDropDownButton_OnClick()
	FilterDropDownButton_OnClick(this, SubClass, SetSubClass, ATSWSubClassDropDown, SetTradeSkillSubClassFilter)
end

function ATSWInvSlotDropDownButton_OnClick()
	FilterDropDownButton_OnClick(this, InvSlot, SetInvSlot, ATSWInvSlotDropDown, SetTradeSkillInvSlotFilter)
end

local function InsertIntoAuction(Link)
	local _, _, Name = string.find(Link, '%[?([^%[%]]*)%]')

	if aux_frame and aux_frame:IsVisible() then
		local aux = require 'aux'
		local info = require 'aux.util.info'
		
		local _, _, ID = string.find(Link, 'item:(%d+)')
		local Item = string.format('item:%d', tonumber(ID))
		local item_info = info.item(tonumber(aux.select(3, strfind(Item, '^item:(%d+)'))))
		
		if item_info and aux.get_tab().CLICK_LINK then
			aux.get_tab().CLICK_LINK(item_info)
		end
	elseif AuxBuySearchBox and AuxBuySearchBox:IsVisible() then
		AuxBuySearchBox:SetText(Name)
		AuxBuySearchButton_OnClick()
	elseif AuxBuyNameInputBox and AuxBuyNameInputBox:IsVisible() then 
		AuxBuyNameInputBox:SetText(Name)
		Aux.buy.SearchButton_onclick()
	elseif CanSendAuctionQuery() and AuctionFrame and AuctionFrame:IsVisible() then
		BrowseName:SetText(Name)
		AuctionFrameBrowse_Search()
		BrowseNoResultsText:SetText(BROWSE_NO_RESULTS)
	end
end

function ATSWRecipeButton_OnClick(Button)
	local Link 		= this.Link
	
	if Button == 'LeftButton' then
		local Name 	= this.Name
		local Type 	= this.Type
		
		if not Key.Ctrl() and Key.Shift() and not Key.Alt() and not (Type == 'header') then
			if ChatFrameEditBox:IsVisible() or WIM_EditBoxInFocus then
				ATSW_SayReagents(this.Position)
			elseif not (IsBeastTraining() or Type == 'header') then
				local Possible = ATSW_HowManyItemsArePossibleToCreate(Name)
				
				ATSW_AddTask(Name, Possible > 0 and Possible or 1)
			end
		elseif Key.Ctrl() and not Key.Shift() and not Key.Alt() and Link then
			DressUpItemLink(Link)
		else
			ATSW_SelectRecipe(Name, Type)
		end
	elseif Button == 'RightButton' then
		InsertIntoAuction(Link)
	end
end

function ATSW_TaskDeleteOnClick()
	ATSW_DeleteTask(this:GetParent().Name)
end

function ATSWTool_OnClick(Button)
	if Button == 'LeftButton' then
		table.insert(PreviousRecipes(), RecipeSelected())
		ATSW_SelectRecipe(this.Name)
	end
end

function ATSWReagentsButton_OnClick()
    if ATSWReagentsFrame:IsVisible() then
        ATSWReagentsFrame:Hide()
    else
		for R = 1, ATSW_NECESSARIES_DISPLAYED do -- Create reagent frame buttons
			local F = CreateFrame('Frame', 'ATSWRFReagent' .. R, ATSWReagentsFrame, 'ATSWRFReagentTemplate')
			
			if R == 1 then
				F:SetPoint('TOPLEFT', 26, -59)
			else
				F:SetPoint('TOPLEFT', 'ATSWRFReagent' .. R - 1, 'BOTTOMLEFT')
			end
		end
		
        ATSW_UpdateNecessaryReagents()
		ATSWReagentsFrame:Show()
    end
end

local function Crement(Edge, Step)
	local Amount	= ATSWAmountBox:GetNumber()
	
	if not Key.Ctrl() and Key.Shift() and not Key.Alt() then
		Amount = Edge
	end
	
	if Amount ~= Edge then
		ATSWAmountBox:SetNumber(Amount + Step)
	else
		if Edge == 0 then
			ATSWAmountBox:SetText(ATSW_ALL)
		else
			ATSWAmountBox:SetText(Edge)
		end
	end
end

function ATSWFrameDecrement_OnClick()
	Crement(0, -1)
end

function ATSWFrameIncrement_OnClick()
	Crement(100, 1)
end

function ATSWTask_OnClick(arg1)
	if arg1 == 'LeftButton' then
		if not Key.Ctrl() and Key.Shift() and not Key.Alt() and not Processing.Active and not Recipe(this.Position).Cooldown then
			local QName 			= Task(this.TaskIndex).Name
			local QAmount 		= Task(this.TaskIndex).Amount
			local IncludeTasks 	= true
			local Possible 			= ATSW_HowManyItemsArePossibleToCreate(QName, ATSW_POSSIBLE_NOTASK) > 0
			
			if Possible then
				ATSW_Craft(QName, QAmount)
			end
		else
			ATSWRecipeButton_OnClick(arg1)
		end
	end
end

function ATSWTaskButton_OnClick()
	local Amount = ATSWAmountBox:GetNumber()
	local Name = RecipeSelected()
	
	if Amount == 0 and TradeSkill then
		if ATSW_Options.ConsiderBank or ATSW_Options.ConsiderAlts or ATSW_Options.ConsiderMerchants then
			Amount = ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
		else
			Amount = ATSW_HowManyItemsArePossibleToCreate(Name)
		end
	end
	
	if Amount == 0 then
		Amount = 1
	end

	ATSW_AddTask(Name, Amount)
end

function ATSWCreateButton_OnClick()
	local Amount = ATSWAmountBox:GetNumber()
	local Name, QName, QAmount = RecipeSelected()
	local IncludeTasks = true
	
	if IsBeastTraining() then
		Craft(GetRecipePosition(Name))
	elseif not Processing.Active then
		if Amount == 0 then
			if TradeSkill then
				Amount = ATSW_HowManyItemsArePossibleToCreate(Name)
			else
				Amount = 1
			end
		end
		
		for I = 1, TasksSize() do
			if ATSW_HowManyItemsArePossibleToCreate(Task(I).Name, ATSW_POSSIBLE_NOTASK) > 0 then
				QName		= Task(I).Name
				QAmount	= Task(I).Amount
				
				break
			end
		end
		
		if TasksSize() == 0 or not (QName and QAmount) then
			ATSW_AddTask(Name, Amount)
			QName		= Name
			QAmount	= Amount
		end
		
		if QName and QAmount then
			ATSW_Craft(QName, QAmount)
		end
	end
end

function ATSW_ShowFrame()
	CastSpellByName(ATSW_ProfessionExists(Profession()) and Profession() or GetFirstProfession() or '')
end

function ATSW_Command(Command)
	local function Chat(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
	
    if 			Command == 'options'
	or 		Command == 'configuration' 
	or 		Command == 'config' 	then
		ATSW_ToggleOptionsFrame()
	elseif 	Command == 'debug' 	then
		ATSW_Debug = not ATSW_Debug
    else
		ATSW_ShowFrame()
	end
end

function ATSW_ToggleOptionsFrame()
    if ATSWConfigFrame:IsVisible() then
		HideUIPanel(ATSWConfigFrame)
    else
		ATSWOFUnifiedButton:					SetChecked(ATSW_Options.Unified)
		ATSWOFSeparateButton:					SetChecked(not ATSW_Options.Unified)
		ATSWOFIncludeBankButton:			SetChecked(ATSW_Options.ConsiderBank)
		ATSWOFIncludeAltsButton:				SetChecked(ATSW_Options.ConsiderAlts)
		ATSWOFIncludeMerchantsButton:		SetChecked(ATSW_Options.ConsiderMerchants)
		ATSWOFAutoBuyButton:					SetChecked(ATSW_Options.AutoBuy)
		ATSWOFTooltipButton:					SetChecked(ATSW_Options.RecipeTooltip)
		ATSWOFShoppingListButton:			SetChecked(ATSW_Options.DisplayShoppingList)
		
        ShowUIPanel(ATSWConfigFrame)
    end
end

function ATSWRecipe_OnClick()
	local Link = this.Link
	
    if arg1 == 'RightButton' then
        InsertIntoAuction(Link)
	elseif arg1 == 'LeftButton' then
		if Key.Ctrl() and not Key.Shift() and not Key.Alt() then
			DressUpItemLink(Link)
		elseif not Key.Ctrl() and Key.Shift() and not Key.Alt() then
			if WIM_EditBoxInFocus then
				WIM_EditBoxInFocus:Insert(Link)
			elseif ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Insert(Link)
			else
				if Link then
					ATSWSearchBox:SetText(':r ' .. (LinkToName(Link) or ''))
				end
			end
		elseif string.find(this:GetName(), 'ATSWReagent') then
			local ReagentID = ATSW_LinkToID(GetReagentLink(GetPositionFromGame(RecipeSelected()), this:GetID()))
			
			for I = 1, RecipesSize() do
				if ReagentID == ATSW_LinkToID(Recipe(I).Link) then
					table.insert(PreviousRecipes(), RecipeSelected())
					
					ATSW_SelectRecipe(Recipe(I).Name)
				end
			end
		end
	end
end

function ATSWPreviousItemButton_OnClick()
	ATSW_SelectRecipe(table.remove(PreviousRecipes()))
end

function ATSWSubClassDropDown_OnLoad()
	_G[this:GetName()..'Button']:SetHeight(26)
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
	UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1)
end

function ATSWSubClassDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
end

function ATSWSubClassDropDown_Initialize()
    ATSWFilterFrame_LoadSubClasses(GetTradeSkillSubClasses())
end

local function SetDropDownText(frame, filter, t, DefaultText)
	local Text
	
	if filter > 0 then
		Text = t[filter]
	elseif table.getn(t) == 1 then
		Text = t[1]
	else
		Text = DefaultText
	end
	
	UIDropDownMenu_SetText(Text, frame)
end

function ATSWFilterFrame_LoadSubClasses(...)
    local info = {}
	local filter = SubClass()
	
	if not filter then
		filter = 0
	end
	
	if filter > arg.n then
		filter = 0
	end
	
	info.func = ATSWSubClassDropDownButton_OnClick
	
    if arg.n > 1 then
        info.text = ALL_SUBCLASSES
		info.checked = filter == 0
        UIDropDownMenu_AddButton(info)
		
		if info.checked then
			UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1)
		end
    end
	
    for I = 1, arg.n do
        info.text = arg[I]
		info.checked = filter == I
        UIDropDownMenu_AddButton(info)
		
		if info.checked then
			UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, I+1)
		end
    end
	
	if filter == 0 then
		UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1)
	end
	
	SetDropDownText(ATSWSubClassDropDown, filter, arg, ALL_SUBCLASSES)
end

function ATSWInvSlotDropDown_OnLoad()
	_G[this:GetName()..'Button']:SetHeight(26)
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
	UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1)
end

function ATSWInvSlotDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
end

function ATSWInvSlotDropDown_Initialize()
    ATSWFilterFrame_LoadInvSlots(GetTradeSkillInvSlots())
end

function ATSWFilterFrame_LoadInvSlots(...)
    local info = {}
	local filter = InvSlot()
	
	if not filter then
		filter = 0
	end
	
	if filter > arg.n then
		filter = 0
	end
	
	info.func = ATSWInvSlotDropDownButton_OnClick
	
    if arg.n > 1 then
        info.text = ALL_INVENTORY_SLOTS
		info.checked = filter == 0
        UIDropDownMenu_AddButton(info)
		
		if info.checked then
			UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1)
		end
    end
	
    for I = 1, arg.n do
        info.text = arg[I]
		info.checked = filter == I
        UIDropDownMenu_AddButton(info)
		
		if info.checked then
			UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, I+1)
		end
    end
	
	if filter == 0 then
		UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1)
	end
	
	SetDropDownText(ATSWInvSlotDropDown, filter, arg, ALL_INVENTORY_SLOTS)
end

-- Get recipes from server

function ATSW_GetRecipes(New)
	if RecipesSize() == 0 or New then
		SetDropDownFilter(0, 0) -- It is needed for full trade skill list initial loading
		RecipesSize(0)
		
		for I = 1, GetCraftCount() do
			AddRecipe(I)
		end
	end
	
	SetDropDownFilter(SubClass(), InvSlot())
	ATSW_GetRecipesSorted(New)
end

function ATSW_GetRecipesSorted(New)
	if RecipesSortedSize() == 0 or New then
		if 			SortBy() == 'Category' 	then ATSW_GetRecipesSortedByCategory	()
		elseif 	SortBy() == 'Difficulty' 	then ATSW_GetRecipesSortedByDifficulty	()
		elseif 	SortBy() == 'Name' 		then ATSW_GetRecipesSortedByName		()
		elseif 	SortBy() == 'Custom' 	then ATSW_GetRecipesSortedByCustom	() end
	end
	
	ATSW_UpdateRecipes()
end

-- Sorting of recipes

function ATSW_GetRecipesSortedByCategory()
	RecipesSortedSize(0)
	
	local Expanded, H = true
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type == 'header' then
			H = R
		else
			if ATSW_Filter(R) and DropDownFilterPass(R.Name) then
				if H then
					Expanded = IsExpanded(H.Name)
					AddRecipeSorted(H)
					H = nil
				end
				
				if Expanded then
					AddRecipeSorted(R)
				end
			end
		end
	end
end

local function GetRecipesSortedWithoutHeaders()
	RecipesSortedSize(0)
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type ~= 'header' and ATSW_Filter(R) and DropDownFilterPass(R.Name) then
			AddRecipeSorted(R)
		end
	end
end

function ATSW_TypeToNumber(Type)
	local Number = 0
	
	if Type 	== 'trivial' 	then Number = 4 end
	if Type 	== 'easy' 	then Number = 3 end
	if Type 	== 'medium'	then Number = 2 end
	if Type 	== 'optimal' 	then Number = 1 end
	if Type 	== 'none' 	then Number = 0 end
	
	return Number
end

local function GetReagentDataProfName(Name)
	return ProfessionNamesForReagentData[GetProfessionTexture(Name)]
end

function ATSW_CompareDifficulty(Left, Right)
	return ATSW_TypeToNumber(Left.Type) < ATSW_TypeToNumber(Right.Type)
end

function ATSW_GetRecipesSortedByDifficulty()
	GetRecipesSortedWithoutHeaders()
	
	ATSW_Sort(RecipesSorted(), RecipesSortedSize(), ATSW_CompareDifficulty)
	
	-- Compatibility with AtlasLoot
	if ATSW_AtlasLoot then
		ATSW_Sort(RecipesSorted(), RecipesSortedSize(), ATSW_CompareDifficultyUsingExternalData)
	end
end

function ATSW_GetRecipesSortedByName()
	local function CompareName(Left, Right)
		return string.lower(Left.Name) < string.lower(Right.Name)
	end

	GetRecipesSortedWithoutHeaders()
	ATSW_Sort(RecipesSorted(), RecipesSortedSize(), CompareName)
end

function ATSW_GetRecipesSortedByCustom()
	RecipesSortedSize(0)
	
	-- First add all custom categories and recipes in them
	local function Categories()
		return ATSW_CustomCategories[realm][player][Profession()]
	end
	
	local Size = table.getn(Categories())
	
	local function Category(C)
		return Categories()[C]
	end
	
	local function CatRecipe(C, I)
		return Category(C).Items[I]
	end
	
	local Expanded, HeaderAdded
	
	for C = 1, Size do
		Expanded = IsExpanded(Category(C).Name)
		HeaderAdded = false
		
		for I = 1, table.getn(Category(C).Items) do
			local R = CatRecipe(C, I)

			if R.Type ~= 'header' and ATSW_Filter(R) and DropDownFilterPass(R.Name) and IsInTradeSkills(R.Name) then
				if not HeaderAdded then
					AddRecipeSorted(Category(C))
					HeaderAdded = true
				end
				
				if Expanded then
					AddRecipeSorted(Recipe(GetRecipePosition(R.Name)))
				end
			end
		end
	end
	
	-- Then add uncategorized recipes into the category 'Uncategorized'
	
	HeaderAdded = false
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type ~= 'header' and not ATSWCS_IsCategorized(R.Name, R.SubName) and ATSW_Filter(R) and DropDownFilterPass(R.Name) then
			if not HeaderAdded then
				AddRecipeSorted({Name = ATSW_UNCATEGORIZED, Type = 'header'})
				HeaderAdded = true
			end
			
			if IsExpanded(ATSW_UNCATEGORIZED) then
				AddRecipeSorted(R)
			end
		end
	end
end

-- Thank you kikito for the function(https://stackoverflow.com/users/312586/kikito)
-- https://stackoverflow.com/questions/36820438/how-can-built-in-sorting-algorithm-be-so-fast
function ATSW_Sort(Table, Size, SortingFunction)
	local function Sort(Table, Left, Right, SortingFunction)
		if Right - Left > 0 then
			local P = Left
			
			for I = Left + 1, Right do
				if SortingFunction(Table[I], Table[P]) then
					if I == P + 1 then	Table[P], Table[P+1] = Table[P+1], Table[P]
					else						Table[P], Table[P+1], Table[I] = Table[I], Table[P], Table[P+1] end
					
					P = P + 1
				end
			end
			
			Sort(Table, Left, P - 1, SortingFunction)
			Sort(Table, P + 1, Right, SortingFunction)
		end
	end
	
	Sort(Table, 1, Size, SortingFunction)
end

local StatW = Color.WHITE .. '%d' .. Color.LIGHTGREY
local StatWP = Color.WHITE .. '%d%%' .. Color.LIGHTGREY
local StatWS = Color.WHITE .. '%s' .. Color.LIGHTGREY
local StatG = Color.GREEN .. '%d' .. Color.LIGHTGREY
local StatGS = Color.GREEN .. '%s' .. Color.LIGHTGREY

local EnchantPatterns = {
	{Pattern = 'enchant[s]* a piece of (%a+) .+ increase[s]* the ([%a%s]+) of the wearer by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 1},
    {Pattern = 'enchant[s]* a piece of ([%a%s]+) armor to [%a]+ [+]*(%d+%%*) [to%s]*([%a%s]+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* a piece of ([%a%s]+) armor so it has.+ (%d+%%*) chance per hit of giving.+ (%d+) points of ([%a%s]+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%4$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to [%a]+ [+]*(%d+%%*) ([%a%s]+) skill.', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to increase (%a+).* resistance by (%d+).', Return = Color.WHITE .. '%3$d' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_RESIST .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 4},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to [%a]+ [+]*(%d+%%*).* (%a+) resistance', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_RESIST .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 4},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to restore (%d+%%*) (%a+) every (.+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_EVERY .. Color.WHITE .. '%4$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to do (%d+%%*) additional[%s%a]* damage [%a]+ (%a+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_DAMAGE_TO .. Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to [%a]+ [+]*(%d+%%*)[%s%a]* ([%a%s]+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to [%a]+ [%a%s]*(%d+%%*) chance [%s%a]* ([%a%s]+).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to decrease (%a+) .+by (%d+%%*).', Return = Color.WHITE .. '-%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = 'enchant[s]* [a%s]*([%a%s]+) to [%a%s]+ [+]*(%d*%%*)([%a%s]+) bonus([%a%s]*).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s%4$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to [%a]+ a slight ([%a%s]+) increase.', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to often .+ the target reducing their ([%a%s]+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_TO_REDUCE .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to often strike.+ (%d+).+ (%a+) damage.', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_DAMAGE_ON_HIT .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s-]+) to have a chance of (%a+) and [%a%s]+ damage to (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%2$s' .. ATSW_AND_DAMAGING .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_ON_HIT_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) so .+ the ([%a%s]+) skill of the wearer is increased by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) so that it increases[%a%s]* resistance to (%a+) [%a%s]*by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_RESIST .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 2},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) so that it increases the ([%a%s]+) of .+ by (%d+).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 2},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) so that it increases ([%a%s]+) by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 2},
    {Pattern = 'enchant[s]*[%s]*[a%s]*.* (%a+) so .+ the wearer\'s ([%a%s]+) by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = 'enchant[s]* [a%s]*([%a%s]+) to increase the ([%a%s]+) of the wearer by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 1},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to increase.* healing.+ by.* (%d+%%*).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_HEALING .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 1},
    {Pattern = 'enchant[s]*[%a%s]* (%a+) to increase ([%a%s]+) by (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 1},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to [%a]+ ([%a%s]+) damage by[%a%s]* (%d+%%*).', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_SPELL_DAMAGE .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to [%a]+ .+(%d+%%*).+ (%a+) damage when casting.+spells.', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%3$s' .. ATSW_SPELL_DAMAGE .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to [%a%s]+ (%d+%%*) ([%a%s]*)damage to .*spells.', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. '%3$s' .. ATSW_SPELL_DAMAGE .. ATSW_FOR .. Color.WHITE .. '%1$s'},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to do (%d+%%*) additional[%s%a]* damage.', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_DAMAGE .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) to.* steal life.* and give it to.+', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. ATSW_VAMPIRISM .. Color.LIGHTGREY .. ATSW_ON_HIT_FOR .. Color.WHITE .. '%1$s'}, -- Lifestealing
    {Pattern = 'enchant[s]* [a%s]*([%a%s]+) so that often when attacking.* heals.* (%d+) to (%d+).* (%a+) by (%d+) for (.+)', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.GREEN .. '%2$d' .. Color.WHITE .. '-' .. Color.GREEN .. '%3$d' .. Color.LIGHTGREY .. ATSW_HEALTH_AND .. Color.WHITE .. '%5$d' .. Color.LIGHTGREY .. ' ' .. '%4$s' .. ATSW_FOR .. Color.WHITE .. '%6$s' .. Color.LIGHTGREY .. ATSW_ON_HIT_FOR .. Color.WHITE .. '%1$s'} -- Crusader
}

local PoisonPatterns = {
    {Pattern = '.+ (%d+)%% chance .+ (%d+) to (%d+) ([%a%s]*)damage', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_TO .. Color.WHITE .. '%2$d-%3$d ' .. Color.LIGHTGREY .. '%4$sdmg', Similar = 1},
    {Pattern = '.+ threat.+', Return = Color.WHITE .. ATSW_PLUS_THREAT},
    {Pattern = '.+ (%d+)%% chance .+ (%d+) (%a*[%s]*)damage', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_TO .. Color.WHITE .. '%2$d ' .. Color.LIGHTGREY .. '%3$sdmg', Similar = 1},
    {Pattern = '.+ (%d+)%% chance .+ slowing their ([%a%s]+) by (%d+)%% for (%d+) (%a+)', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_TO .. Color.WHITE .. '-%3$d%% ' .. Color.LIGHTGREY .. '%2$s' .. ATSW_FOR .. Color.WHITE .. '%4$d %5$s', Similar = 1},
    {Pattern = '.+ (%d+)%% chance .+ increasing their casting time by (%d+)%% for (%d+) (%a+)', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_TO .. Color.WHITE .. '-%2$d%% ' .. Color.LIGHTGREY .. ATSW_CAST_TIME .. ATSW_FOR .. Color.WHITE .. '%3$d %4$s', Similar = 1},
    {Pattern = '.+ (%d+)%% chance .+ reducing all healing .+ by (%d+%%*) for (%d+) (%a+)', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_TO .. Color.WHITE .. '-%2$s ' .. Color.LIGHTGREY .. ATSW_INC_HEAL .. ATSW_FOR .. Color.WHITE .. '%3$d %4$s', Similar = 1},
    {Pattern = '. Stacks up to (%d+) times.', Return = Color.LIGHTGREY .. ATSW_STACK .. Color.WHITE .. '%1$d'},
    {Pattern = '(%d+) charges.', Return = Color.WHITE .. '%1$d' .. Color.LIGHTGREY .. ATSW_CHARGES},
}

local AttributePatterns = {
	{Pattern = '(%d+) Armor', Return = StatW .. ATSW_ARMOR},
    {Pattern = '[+-]+(%d+) [%a%s]*Strength', Return = StatW .. ATSW_STR},
    {Pattern = '[+-]+(%d+) [%a%s]*Agility', Return = StatW .. ATSW_AGI},
    {Pattern = '[+-]+(%d+) [%a%s]*Stamina', Return = StatW .. ATSW_STA},
    {Pattern = '[+-]+(%d+) [%a%s]*Intellect', Return = StatW .. ATSW_INT},
    {Pattern = '[+-]+(%d+) [%a%s]*Spirit', Return = StatW .. ATSW_SPI},
	
	{Pattern = 'gain (%d+) [%a%s]*Strength', Return = StatW .. ATSW_STR},
    {Pattern = 'gain (%d+) [%a%s]*Agility', Return = StatW .. ATSW_AGI},
    {Pattern = 'gain (%d+) [%a%s]*Stamina', Return = StatW .. ATSW_STA},
    {Pattern = 'gain (%d+) [%a%s]*Intellect', Return = StatW .. ATSW_INT},
    {Pattern = 'gain (%d+) [%a%s]*Spirit', Return = StatW .. ATSW_SPI},
	
	{Pattern = ' eat.+ increase.* (%a+) by (%d+)', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' ' .. '%1$s'},
	
	{Pattern = 'gain (%d+)%% ([%a]+)', Return = StatWP .. ' ' .. '%2$s'},
    {Pattern = 'gain .+ and (%d+) ([%a]+)', Return = StatW .. ' ' .. '%2$s'},
    {Pattern = 'eat.+ [%a]+ (%d+) ([%a]+) every (%d+) (%a+)', Return = StatW .. ' ' .. '%2$s' .. ATSW_EVERY .. '%3$d %4$s'},
	
    {Pattern = 'All Stats (.%d+)', Return = StatW .. ATSW_ALL_ATTRIBUTES},
    {Pattern = '[+-]+(%d+) (%a+) Resistance[%.]*$', Return = Color.WHITE .. '%1$d' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_RESIST},
    {Pattern = '[+-]+(%d+) All Resistances', Return = StatW .. ATSW_ALL_RESIST},
	
    {Pattern = '(%d+) Slot([%a%s]*) (%a+)', Return = StatW .. ATSW_SLOTS .. '%2$s' .. ' ' .. '%3$s'},
    {Pattern = 'Equip: (%a+) [+](%d+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' ' .. '%1$s'},
	
	{Pattern = 'gain[s]* (.%d+) (%a+) damage', Return = Color.WHITE .. '%1$d ' .. Color.LIGHTGREY .. '%2$s' .. ATSW_DAMAGE},
    {Pattern = 'Absorb[s]* (%d+) to (%d+) (%a+) damage.+Lasts (.+).', Return = Color.WHITE .. '%1$d-%2$d ' .. Color.LIGHTGREY .. '%3$s' .. ATSW_DAMAGE_ABSORB .. ATSW_FOR .. Color.WHITE .. '%4$s', Similar = 4},
    {Pattern = 'Absorb[s]* (%d+) (%a+) damage.+Lasts (.+).', Return = Color.WHITE .. '%1$d ' .. Color.LIGHTGREY .. '%2$s' .. ATSW_DAMAGE_ABSORB .. ATSW_FOR .. Color.WHITE .. '%3$s', Similar = 4},
    {Pattern = 'Reflect[s]* (%a+) .+ (%d+) sec.', Return = Color.LIGHTGREY .. '%1$s' .. ATSW_REFLECT .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%2$d sec.'},
	{Pattern = 'Chance on hit: decrease the ([%a%s]+) by (%d+%%*) for ([%d%.]+) (%a+).+affected.+ cannot stealth or turn invisible', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ', ' .. ATSW_MINUS_STEALTH_INVIS .. ATSW_FOR .. Color.WHITE .. '%3$d %4$s', Similar = 13},
	{Pattern = 'decrease the ([%a%s]+) by (%d+%%*) for ([%d%.]+) (%a+).', Return = Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_FOR .. Color.WHITE .. '%3$s %4$s', Similar = 13},
    {Pattern = 'increases Fishing by (%d+) (.+)', Return = StatW .. ATSW_FISHING .. '%s', Similar = 1},
    {Pattern = 'Increase[s]*[d]* Defense %+(%d+)', Return = StatW .. ATSW_DEFENSE},
    {Pattern = 'Reduces([%s%a]+) spell damage taken by (%d+%%*).', Return = Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. '%1$s' .. ATSW_DAMAGE_TAKEN},
    {Pattern = 'Reduc[%a]+ damage taken from critical hits and damage over time effects by (%d+)%%.', Return = Color.WHITE .. '-%1$d%%' .. Color.LIGHTGREY .. ATSW_DMG_TAKEN_CRITS_DOTS},
    {Pattern = 'Increases damage and healing done by magical spells and effects(.*) by up to (%d+)', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ATSW_SPELL_POWER .. '%1$s', Similar = 1},
    {Pattern = 'Increases (%a+) spell damage by up to (%d+) for (.+).', Return = Color.WHITE .. '%2$d ' .. Color.LIGHTGREY .. '%1$s' .. ATSW_DAMAGE_FOR .. Color.WHITE .. ' %3$s.'},
    {Pattern = 'Increases spell (%a+) damage by up to (%d+) for (.+).', Return = Color.WHITE .. '%2$d ' .. Color.LIGHTGREY .. '%1$s' .. ATSW_DAMAGE_FOR .. Color.WHITE .. ' %3$s.'},
    {Pattern = 'Increases (%a+) damage by up to (%d+) for (.+).', Return = Color.WHITE .. '%2$d ' .. Color.LIGHTGREY .. '%1$s' .. ATSW_DAMAGE_FOR .. Color.WHITE .. ' %3$s.'},
    {Pattern = 'Increases damage done to (%a+) by magical spells and effects by up to (%d+)', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ATSW_SPELL_DAMAGE_TO .. '%1$s', Similar = 1},
    {Pattern = 'Increases damage done by (%a+) spells and effects by up to (%d+)', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_DAMAGE, Similar = 1},
    {Pattern = 'Increases healing done by spells and effects by up to (%d+)', Return = StatW .. ATSW_HEALING, Similar = 1},
    {Pattern = '(%d+%.?%d*)%% of damage dealt is returned as healing', Return = StatWP .. ' ' .. ATSW_VAMPIRISM, Similar = 1},
    {Pattern = 'Increases .+ chance to block attacks .+ (%d+)%%.', Return = StatWP .. ATSW_BLOCK, Similar = 1},
    {Pattern = 'Increases .+ block value .+ (%d+).', Return = StatW .. ATSW_BLOCK, Similar = 1},
    {Pattern = 'Increases your chance to parry an attack by (%d+).', Return = StatWP .. ATSW_PARRY, Similar = 1},
    {Pattern = 'Decreases your chance to parry an attack by (%d+).', Return = Color.WHITE .. '-%1$d%%' .. Color.LIGHTGREY .. ATSW_PARRY, Similar = 1},
    {Pattern = 'Increases your chance to dodge an attack by (%d+).', Return = StatWP .. ATSW_DODGE, Similar = 1},
    {Pattern = 'Increases your attack and casting speed by (%d+).', Return = StatWP .. ATSW_ATTACK_AND_CASTING_SPEED, Similar = 1},
    {Pattern = 'Equip: .*Increases ([%a%s]+) by (%d+)%%%.', Return = Color.WHITE .. '%2$d%%' .. Color.LIGHTGREY .. ' ' .. '%1$s', Similar = 1},
	{Pattern = 'Equip: .*Increases [your]*[%s]*(.+) by ([%d]+[%%]*).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s', Similar = 1},
	{Pattern = 'Equip: .*Increases [the]*[your]*[%s]*([%a%s%d]+).', Return = Color.WHITE .. '+ %s', Similar = 1},
	{Pattern = 'Use: Slightly increases [the]*[your]*[%s]*([%a%s%d]+) for ([%a%s%d]+).', Return = Color.WHITE .. '+ %s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s', Similar = 1},
	{Pattern = 'Equip: .*Increase[s]* [your]*[%s]*(.+) by (%d+)%%.', Return = Color.WHITE .. '+%2$d%%' .. Color.LIGHTGREY .. ' ' .. '%1$s', Similar = 1},
	{Pattern = '.*Increase [your]*[%s]*([%a%s]+) for ([%a%s%d]+).', Return = Color.LIGHTGREY .. '+ %s' .. ATSW_FOR .. Color.WHITE .. '%s.', Similar = 1},
	{Pattern = 'Use: Increases [%a%s]*resistance to (%a+)[%a%s]* by (%d+%%*) for ([%d%s%a]+).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_RESIST .. ATSW_FOR .. Color.WHITE .. '%3$s', Similar = 3},
	{Pattern = 'Increases [%a%s]*resistance to (%a+)[%a%s]* by (%d+%%*).', Return = Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_RESIST, Similar = 3},
	{Pattern = 'Increases (%a+) by (%d+) and .+ critical hit by (%d+)%% for (.+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_AND .. Color.WHITE .. '%3$d%%' .. Color.LIGHTGREY .. ATSW_CRIT .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%4$s'},
	{Pattern = 'the attacker has a (%d+)%%+ chance of being inflicted with disease that increases their damage taken by (%d+) for ([%a%s%d%.]+). Lasts for ([%a%s%d%.]+).', Return = StatWP .. ATSW_OF .. Color.WHITE .. '+%d' .. Color.LIGHTGREY .. ' ' .. ATSW_DAMAGE_ATTACKER_FOR .. Color.WHITE .. '%s,' .. Color.LIGHTGREY .. ATSW_LASTS .. Color.WHITE .. '%s.'},
	{Pattern = '(%d+%%*) chance of dealing (%d+)([%s%a]*) on a successful melee attack.', Return = StatWS .. ' ' .. '%1$d%2$s' .. ATSW_ON_MELEE},
	{Pattern = 'Use: Imbiber is ([%a%s%d]+) for the next ([%a%s%d]+).', Return = StatWS .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Use: Increases your ([%a%s]+) by (%d+%%*) for ([%d%s%a%.]+).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_FOR .. Color.WHITE .. '%3$s', Similar = 3},
	{Pattern = 'Use: Increases the player\'s ([%a%s]+) by (%d+%%*) for ([%d%s%a]+).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_FOR .. Color.WHITE .. '%3$s', Similar = 3},
	{Pattern = 'Use: Increases ([%a%s]+) by (%d+%%*) for ([%d%s%a%.]+).', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_FOR .. Color.WHITE .. '%3$s', Similar = 3},
	{Pattern = 'Use: attempts to remove one (%a+), one (%a+) and one (%a+) from.+', Return = Color.WHITE .. '-%s, -%s, -%s'},
	
	{Pattern = 'Use: Increases ([%a%s%d]+) by (%d+) to (%d+) and increases (%a+) by (%d+) for ([%a%s%d%.]+).', Return = Color.WHITE .. '%2$d-%3$d ' .. Color.LIGHTGREY .. '%1$s, ' .. Color.WHITE .. '%5$d' .. Color.LIGHTGREY .. ' ' .. '%4$s' .. ATSW_FOR .. Color.WHITE .. '%6$s', Similar = 6},
	{Pattern = 'Use: Increases (.+) by (%d+) to (%d+).', Return = Color.WHITE .. '%2$d-%3$d ' .. Color.LIGHTGREY .. '%1$s', Similar = 6},
	{Pattern = 'Use: Your (.+) is increased and your (.+) goes up by (%d+%%*).+Lasts (.+).', Return = Color.WHITE .. '+%3$s ' .. Color.LIGHTGREY .. '%2$s' .. ATSW_AND .. '%1$s' .. ATSW_FOR .. Color.WHITE .. '%4$s'},
	{Pattern = 'Use: [%a]+ is cured of up to ([%a%s%d]+) poison[s]* up to ([%a%s%d]+).', Return = Color.WHITE .. '-%s' .. Color.LIGHTGREY .. ATSW_POISONS_OF .. Color.WHITE .. '%s'},
	{Pattern = 'Decreases the magical resistances of your spell targets by (%d+).', Return = Color.WHITE .. '-%d' .. Color.LIGHTGREY .. ATSW_TARGETS_ALL_RESIST},
	{Pattern = ': Removes (%d+) magic, curse, poison.+ disease effect.+ every (%d+) seconds for ([%a%s%d]+).', Return = Color.WHITE .. '-%d ' .. Color.LIGHTGREY .. ATSW_NON_PHYSICAL_DEBUFF .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_SECONDS_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Use: Regenerate (.+) for (.+).', Return = StatWS .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Use: Makes you immune to (.+) for [the%snext]*[%s]*([%a%s%d]+).', Return = Color.LIGHTGREY .. ATSW_IMMUNITY_TO .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s', Similar = 5},
	{Pattern = 'Use: Allows the imbiber to ([%a%s%d]+) for ([%a%s%d]+).', Return = Color.WHITE .. '+ %s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s', Similar = 2},
	{Pattern = 'Use: [%a]+s the imbiber ([%a%s%d]+) for ([%a%s%d]+).', Return = Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s', Similar = 2},
	{Pattern = 'Use: [%a]+s the imbiber ([%a%s%d]+) for ([%a%s%d]+).', Return = Color.WHITE .. '+ %s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s', Similar = 2},
	{Pattern = 'Shows the location of all nearby (%a+) on.+ minimap for ([%a%s%d]+)', Return = Color.LIGHTGREY .. ATSW_SHOWS .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Use: When applied to a melee weapon it gives a (%d+%%+) chance of casting (.+) at the opponent.+Lasts ([%a%s%d]+).', Return = Color.WHITE .. '+%s' .. Color.LIGHTGREY .. ATSW_TO_CAST .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Equip: Allows (%d+%%*) of your (%a+) regeneration to [%a]+ while ([%a%s]+).', Return = Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_REGEN_IF .. Color.WHITE .. '%s', Similar = 2},
	{Pattern = 'Equip: Allows ([%a%s%d]+).', Return = Color.WHITE .. '%s', Similar = 2},
	{Pattern = '.*Allows [%a%s%d]+ to ([%a%s%d]+).', Return = Color.WHITE .. '%s', Similar = 2},
	{Pattern = '.*Allows control of a mechanical target for a short time.', Return = Color.WHITE .. ATSW_CONTROL_MECHANICAL},
	{Pattern = 'Shoots a firework .+ that (.+).', Return = Color.LIGHTGREY .. '%s'},
	{Pattern = 'reducing its melee and spell damage by (%d+) and its movement rate by (%d+)%% for (%d+) (%a+).', Return = Color.WHITE .. '-%d' .. Color.LIGHTGREY .. ATSW_MELEE_SPELL_DAMAGE_AND .. Color.WHITE .. '-%d%%' .. Color.LIGHTGREY .. ATSW_MOVEMENT_FOR .. Color.WHITE .. '%d %s'},
	
	{Pattern = 'Use: shrinks .+ reducing [%a]+ ([%a%s]+) by (%d+)', Return = Color.WHITE .. '-%2$d' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_OF_TARGET},
	{Pattern = 'Causes all (%a+) .+ to run away for (%d+) (%a+).', Return = Color.LIGHTGREY .. ATSW_SCARES .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%d %s.'},
	{Pattern = '.*Attaches [%a%s]+ to a (.+) that .+ (%a+) by (%d+%%*)', Return = Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ' ' .. '%2$s' .. ATSW_FOR .. Color.WHITE .. ' %1$s', Similar = 3},
	{Pattern = 'Drops a target dummy .+ (%d+) seconds', Return = Color.LIGHTGREY .. ATSW_ATTRACTS_MONSTERS .. Color.WHITE .. '%d sec.', Similar = 3},
	{Pattern = 'Use: .+ weapon.+ swing (%d+)%%.* for (%d+) (%a+).', Return = StatWP .. ATSW_ATTACK_SPEED_FOR .. Color.WHITE .. '%d %s.'},
	{Pattern = 'Creates a battle chicken.', Return = Color.WHITE .. ATSW_WILL_FIGHT},
	{Pattern = ': Gives you a ([%a%s%d]+) that lets you ([%a%s%d]+).', Return = StatWS .. ATSW_TO_OTHER .. Color.WHITE .. '%s', Similar = 3},
	{Pattern = 'Use: Increases your (.+) by up to (%d+) and your (.+) by up to (%d+) for (.+).', Return = Color.WHITE .. '%2$d %1$s' .. Color.LIGHTGREY .. ATSW_AND .. Color.WHITE .. '%4$d %3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%5$s', Similar = 3},
	{Pattern = 'Use: Improves your chance to hit by (%d+)%% for (.+).', Return = StatWP .. ATSW_HIT_FOR .. Color.WHITE .. '%s.', Similar = 3},
	{Pattern = 'Use: Improves your chance to hit with spells by (%d+)%% for (.+).', Return = StatWP .. ATSW_SPELL_HIT_FOR .. Color.WHITE .. '%s.', Similar = 3},
	{Pattern = 'Equip: Improves your chance to get a critical strike with ([%a%s]+) by (%d+)%%.', Return = Color.WHITE .. '%2$d%%' .. Color.LIGHTGREY .. ' ' .. '%1$s' .. ATSW_CRIT, Similar = 3},
	{Pattern = 'Use: Improves your chance to get a critical strike by (%d+)%% for (.+).', Return = StatWP .. ATSW_CRIT_FOR .. Color.WHITE .. ' %s.', Similar = 3},
	{Pattern = 'Use: Improves your chance to get a critical strike with([%s%a]*) spells by (%d+)%% for (.+).', Return = Color.WHITE .. '%2$d%% %1$s' .. ATSW_SPELL_CRIT_FOR .. Color.WHITE .. '%3$s.', Similar = 3},
	{Pattern = 'Use: [%a]+s your [%a%d%s]+ to ([%a%s%d]+).', Return = Color.WHITE .. ATSW_WILL .. Color.WHITE .. '%s', Similar = 3},
	{Pattern = '.+: Reduces your (.+)[%a%s%d]* for (%d+)', Return = Color.WHITE .. '-' .. Color.LIGHTGREY .. '%s' .. ATSW_FOR .. Color.WHITE .. '%d sec.', Similar = 3},
	{Pattern = 'Chance on hit: Blasts up to (%d+) (%a+) for (%d+) to (%d+) (%a+) damage', Return = Color.LIGHTGREY .. ATSW_CHANCE_FOR .. Color.WHITE .. '%3$d-%4$d ' .. Color.LIGHTGREY .. '%5$s' .. ATSW_DAMAGE_TO .. ' %1$d %2$s', Similar = 4},
	{Pattern = 'Chance on hit: Blasts .+ (%d+) (%a+) damage', Return = Color.LIGHTGREY .. ATSW_CHANCE_FOR .. Color.WHITE .. '%d ' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE, Similar = 4},
	{Pattern = 'Chance on hit: Sends a .+ at the enemy.+ (%d+) to (%d+) (%a+) damage', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. ' %s' .. ATSW_DAMAGE, Similar = 4},
	{Pattern = 'Use: Blasts ([%a%s]+).', Return = StatWS .. '', Similar = 14},
	{Pattern = 'Use: Deals (%d+) (%a+) damage every (.+) to (.+) for (.+).', Return = StatWS .. Color.LIGHTGREY .. ' ' .. '%s' .. ATSW_DAMAGE_PER .. Color.WHITE .. '%s ' .. Color.LIGHTGREY .. ATSW_TO_OTHER .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Use: Does (%d+) (%a+) damage .+ yard .+ every (%d+) seconds for ([%a%s%d]+)', Return = Color.WHITE .. '%d' .. Color.LIGHTGREY .. ' ' .. '%s' .. ATSW_DAMAGE_PER .. Color.WHITE .. ' %d sec.' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s.'},
	{Pattern = '.(%d+) attack power in ([%a%s%,]+) forms only', Return = StatW .. ATSW_ATTACK_POWER_IN .. Color.WHITE .. '%s form', Similar = 9},
	{Pattern = '.(%d+) attack power', Return = StatW .. ATSW_ATTACK_POWER, Similar = 9},
	{Pattern = '.(%d+) ranged Attack Power', Return = StatW .. ATSW_RANGED_POWER},
	{Pattern = 'increases attack power by (%d+) against (%a+)', Return = StatW .. ATSW_ATTACK_POWER_AGAINST .. Color.WHITE .. '%s'},
	{Pattern = 'Your attacks ignore (%d+) of the target\'s armor', Return = StatW .. ATSW_ARMOR_IGNORE},
	{Pattern = '[+]+ (%d+) [-]+ (%d+) (%a+) damage', Return = Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. ' ' .. '%s' .. ATSW_DAMAGE},
	{Pattern = '(%d+%.?%d*) damage per second', Return = StatWS .. ATSW_DPS},
	{Pattern = 'Improves your chance to hit by (%d+)', Return = StatWP .. ATSW_HIT, Similar = 3},
	{Pattern = 'Improves your chance to hit with spells by (%d+)', Return = StatWP .. ATSW_SPELL_HIT, Similar = 3},
	{Pattern = 'Improves your chance to get a critical strike by (%d+)', Return = StatWP .. ATSW_CRIT, Similar = 3},
	{Pattern = 'Improves your chance to get a critical strike with([%s%a]*) spells by (%d+)', Return = Color.WHITE .. '%2$d%%' .. Color.LIGHTGREY .. '%1$s' .. ATSW_SPELL_CRIT, Similar = 3},
	{Pattern = 'Heals (%d+) damage over (.+)', Return = StatG .. ATSW_HEALTH_OVER .. Color.WHITE .. '%s'},
	{Pattern = 'Heals (%d+) health and (%d+) mana', Return = StatG .. ATSW_HEALTH .. Color.WHITE .. ', ' .. StatW .. ATSW_MANA},
	{Pattern = 'Dispels polymorph', Return = Color.LIGHTGREY .. ATSW_DISPEL .. ' ' .. Color.WHITE .. ATSW_POLYMORPH},
	{Pattern = 'Restores (%d+) ([^t][%a%s%d][%a%s%d][%a%s%d]*)(%.?%s?)', Return = StatG .. ' %s'},
	{Pattern = 'Restores (%d+) to (%d+) (.+).', Return = Color.GREEN .. '%d' .. Color.LIGHTGREY .. '-' .. Color.GREEN .. '%d' .. Color.LIGHTGREY .. ' ' .. '%s'},
	
	{Pattern = 'Reduces the cooldown of your (.+) ability by (.+)', Return = StatWS .. ATSW_CD_REDUCED_BY .. Color.WHITE .. '%s'},
	{Pattern = 'Reduces the mana cost of your (.+) by (.+)', Return = StatWS .. ATSW_COST_REDUCED_BY .. Color.WHITE .. '%s'},
	
	{Pattern = 'Drains (%d+) to (%d+) mana .+ Silences .+ (%d+)', Return = Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. ATSW_MANA_BURN_SILENCE .. Color.WHITE .. '%d sec.'},
	{Pattern = 'Equip: (%d+)%% chance.+ (%d+) to (%d+)([%a%s]*) damage on a successful melee attack', Return = Color.WHITE .. '%d%%' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE, Similar = 4},
	{Pattern = 'chance to strike your ranged target.* (%d+) to (%d+)([%a%s]*) damage', Return = Color.LIGHTGREY .. ATSW_CHANCE_FOR .. Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE, Similar = 4},
	{Pattern = 'damaging you for (%d+) to (%d+)([%s%a]*) damage', Return = Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE_TO_YOU},
	{Pattern = '(%d+) to (%d+)([%s%a]*) damage to you', Return = Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE_TO_YOU},
	{Pattern = '(%d+)%% chance to stun.*(%d+) sec.', Return = Color.LIGHTGREY .. ATSW_STUN .. Color.WHITE .. '%2$d sec,' .. Color.LIGHTGREY .. ATSW_CHANCE .. Color.WHITE .. '%1$d%%', Similar = 5},
	{Pattern = 'Chance on hit: stun.*(%d+)%s*sec', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF_STUN .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_SECONDS, Similar = 5},
	{Pattern = 'Use: Increase (%a+) by (%d+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' %1$s'},
	{Pattern = 'Use: Increase ([%a%s]+) damage by (%d+) for (.+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ATSW_DAMAGE_FOR .. ' ' .. Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = ': ([%a]+) Damage received is reduced by (%d+%%*).', Return = Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_DAMAGE_RECEIVED},
	{Pattern = 'When struck by a harmful spell, the caster of that spell has a (%d+)%% chance to.* ([%a]+)[d].* for (.+).', Return = StatWP .. ATSW_TO_OTHER .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_ATTACKER_OF_SPELL_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'When struck by a non%-periodic damage spell you have a (%d+)%% chance of getting a (.+) spell shield that absorbs (%d+) to (%d+) of that school of damage', Return = Color.WHITE .. '%1$d%%' .. Color.LIGHTGREY .. ATSW_IF_DAMAGED_BY_SPELL .. Color.WHITE .. '%3$d-%4$d' .. Color.LIGHTGREY .. ATSW_OF_SAME_SCHOOL_FOR .. Color.WHITE .. '%2$s', Similar = 4},
	{Pattern = '(%d+) to (%d+)([%a%s]*) damage', Return = Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE, Similar = 4},
	{Pattern = 'When struck.* has a (%d+)%% chance to heal you for (%d+) to (%d+).', Return = StatWP .. ATSW_TO_RESTORE .. Color.WHITE .. '%d-%d' .. Color.LIGHTGREY .. ATSW_HEALTH_IF_DAMAGED, Similar = 10},
	{Pattern = 'Heal ([%a%s]+) for (%d+) to (%d+).', Return = Color.GREEN .. '%2$d-%3$d' .. Color.LIGHTGREY .. ATSW_HEALTH_TO .. Color.WHITE .. '%1$s', Similar = 10},
	{Pattern = 'When struck.* has a (%d+)%% chance of stealing (%d+) life from the attacker over (.+).', Return = StatWP .. ATSW_CHANCE_OF .. ATSW_VAMPIRISM .. ': ' .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_OVER .. Color.WHITE .. '%s'},
	{Pattern = 'When struck.* has a (%d+)%% chance to reduce damage taken by (%a+) .+ by (%d+%%*) for ([%a%s%d]+)', Return = StatWP .. ATSW_CHANCE_TO_REDUCE .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_DAMAGE_TAKEN_BY .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'When struck by.* (%a+) attacker, that attacker has.* (%d+)%% chance of.+ to (%a+) for (%d+) (%a+).+ level (%d+) and below', Return = Color.WHITE .. '%2$d%%' .. Color.LIGHTGREY .. ATSW_CHANCE_TO .. Color.WHITE .. '%3$s ' .. Color.LIGHTGREY .. '%1$s' .. Color.LIGHTGREY .. ATSW_ATTACKER_OF_LEVEL .. Color.WHITE .. '%6$d' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%4$d %5$s.'},
	{Pattern = 'Adds [+](%d+) healing and damage from spells to an item worn on the ([%a%s%,]+).+ level (%d+) and above', Return = Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_SPELL_POWER_FOR .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_OF_LEVEL .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_AND_ABOVE},
	{Pattern = 'Adds (%d+) (%a+) damage to your [%a]+ attack', Return = StatW .. ATSW_OTHER_DAMAGE},
	{Pattern = 'Equip: Immune to Disarm', Return = Color.LIGHTGREY .. ATSW_IMMUNE_TO .. Color.WHITE .. ATSW_DISARM},
	{Pattern = 'Chance on hit: Disarm .* for (%d+) sec.', Return = Color.LIGHTGREY .. ATSW_CHANCE_TO .. Color.WHITE .. ATSW_DISARM .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%d sec.'},
	{Pattern = 'Chance on hit: protect[s]*.* with a (%a+) shield.', Return = Color.LIGHTGREY .. ATSW_CHANCE_FOR .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_SHIELD},
	{Pattern = 'Chance on hit: reduce[s]*.* threat [%a%s\']+.', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. ATSW_MINUS_THREAT},
	{Pattern = 'Chance on hit: reduce[s]*.* (%a+) by (%d+%%*) for (%d+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. ATSW_TARGETS_STAT .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%3$d %4$s.', Similar = 12},
	{Pattern = 'Chance on hit: reduce[s]*.* (%a+) by (%d+%%*).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '-%2$s' .. Color.LIGHTGREY .. ATSW_TARGETS_STAT, Similar = 12},
	{Pattern = '. Stacks up to (%d+) times.', Return = Color.LIGHTGREY .. ATSW_STACK .. Color.WHITE .. '%d'},
	{Pattern = 'Chance on hit: dispels[%a%s\']+.', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. ATSW_DISPEL},
	{Pattern = 'Chance on hit: .+ target for (%d+) (%a+) damage and an additional (%d+)([%s%a]*) damage over ([%d%.]+) (%a+)', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ' %s' .. ATSW_DAMAGE_AND .. Color.WHITE .. '%d%s' .. Color.LIGHTGREY .. ATSW_DAMAGE_OVER .. Color.WHITE .. '%s %s.', Similar = 11},
	{Pattern = 'Chance on hit: .+ (%d+)([%s%a]*) damage over ([%d%.]+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE_OVER .. Color.WHITE .. '%s %s.', Similar = 11},
	{Pattern = 'Chance on hit: Party .+ crit increased by (%d+%%+).+Lasts.* ([%d%.]+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '+%s' .. Color.LIGHTGREY .. ATSW_CRIT_FOR_PARTY .. Color.WHITE .. '%s %s.'},
	{Pattern = 'Give[s] (%d+).* (%a+) to.* party members.', Return = Color.WHITE .. '%d' .. Color.LIGHTGREY .. ' %s' .. ATSW_FOR_PARTY},
	{Pattern = 'Equip: Increase[s]*.* (%a+) of.* party members by (%d+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_FOR_PARTY},
	{Pattern = 'Chance on landing a damaging spell to deal (%d+)([%s%a]*) damage while sacrificing (%d+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. '%s' .. ATSW_DAMAGE_AND .. Color.WHITE .. '-%d' .. Color.LIGHTGREY .. ATSW_HEALTH_ON_SPELL_HIT},
	{Pattern = 'Chance on hit: Spell damage taken by target.* increased by (%d+%%*) for ([%d%.]+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '+%s' .. Color.LIGHTGREY .. ATSW_SPELL_DAMAGE_TAKEN_BY_TARGET},
	{Pattern = 'Chance on hit: Increase[s]*.* critical strike chance of.* next attack made within (%d+) (%a+) by (%d+)%%', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '+%3$d' .. Color.LIGHTGREY .. ATSW_CRIT_OF_NEXT_ATTACK .. Color.WHITE .. '%1$d %2$s'},
	{Pattern = 'and slowing (%a+) speed by (%d+)%% for (%d+) (%a+)', Return = Color.WHITE .. '-%2$d%%' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_FOR .. '%3$d %4$s.'},
	{Pattern = 'Chance on hit: .+ movement slow.* by (%d+)%% and increasing the time between attacks by (%d+)%% for (%d+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '-%d%%' .. Color.LIGHTGREY .. ATSW_MOVEMENT_AND .. Color.WHITE .. '-%d%% ' .. Color.LIGHTGREY .. ATSW_ATTACK_SPEED_OF_TARGET .. Color.WHITE .. '%d %s'},
	{Pattern = 'Chance on hit: Heal self for (%d+) to (%d+) and increases ([%a%s]+) by (%d+) for ([%d%.]+) (%a+).', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%1$d-%2$d' .. Color.LIGHTGREY .. ATSW_HEALTH_AND .. Color.WHITE .. '%4$d' .. Color.LIGHTGREY .. '%3$s' .. ATSW_FOR .. Color.WHITE .. '%5$s %6$s'},
	{Pattern = 'On successful melee or ranged attack.+ (%d+) (%a+) and.+ drain (%d+) (%a+)', Return = Color.LIGHTGREY .. ATSW_CHANCE_OF .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. '%s' .. ATSW_AND_DRAIN .. Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_MANA_ON_HIT},
	{Pattern = 'Protects the wearer from .+ Shadow Flame', Return = Color.LIGHTGREY .. ATSW_PROTECTION_FROM .. Color.WHITE .. 'Onyxia\'s Shadow Flame'},
	{Pattern = '(%d+) yard[s]*', Return = Color.LIGHTGREY .. ATSW_RADIUS .. Color.WHITE .. ' %d'},
	{Pattern = 'stuns [%a%s%d]+ for (%d+) (%a+)', Return = Color.LIGHTGREY .. ATSW_STUN .. Color.WHITE .. '%d %s', Similar = 5},
	
	{Pattern = 'companion', Return = ATSW_COMPANION},
	{Pattern = 'Adds a toy', Return = ATSW_TOY},
	{Pattern = 'Goblin Jumper Cables XL', Return = Color.WHITE .. '50%%' .. Color.LIGHTGREY .. ATSW_CHANCE_TO_RESURRECT, Similar = 'cables'},
	{Pattern = 'Goblin Jumper Cables', Return = Color.WHITE .. '33%%' .. Color.LIGHTGREY .. ATSW_CHANCE_TO_RESURRECT, Similar = 'cables'},
	{Pattern = 'Portable Wormhole Generator: ([%a%s%d%-]+)', Return = Color.LIGHTGREY .. ATSW_PORTAL_TO .. Color.WHITE .. '%s'},
	{Pattern = 'Use: .+ transport[s]* .+ to ([%a%s]+)', Return = Color.LIGHTGREY .. ATSW_TELEPORT_TO .. Color.WHITE .. '%s'},
	{Pattern = 'control.* mind .+ for (%d+) (%a+)', Return = Color.LIGHTGREY .. ATSW_MIND_CONTROL_FOR .. Color.WHITE .. '%d %s'},
	{Pattern = 'detects.* stealth.* invisible', Return = Color.WHITE .. ATSW_STEALTH_INVISIBILITY_DETECTION},
	{Pattern = 'World Enlarger', Return = Color.LIGHTGREY .. ATSW_REDUCE_YOUR .. Color.WHITE .. ATSW_SIZE},
	{Pattern = 'Charge an enemy, knocking it silly for (%d+) seconds.', Return = Color.LIGHTGREY .. ATSW_INCAPACITATE .. Color.WHITE .. '%d sec.'},
	{Pattern = 'Use: .+ protect.* (%d+) damage.* over.* (%d+) (%a+).', Return = Color.WHITE .. '%d' .. Color.LIGHTGREY .. ATSW_DAMAGE_ABSORB_FOR .. Color.WHITE .. '%d %s.'},
	{Pattern = 'Gordok Ogre Suit', Return = Color.LIGHTGREY .. ATSW_DISGUISE .. Color.WHITE .. ATSW_GORDOK_OGRE},
	{Pattern = 'Savory Deviate Delight', Return = Color.LIGHTGREY .. ATSW_DISGUISE .. Color.WHITE .. ATSW_PIRATE_OR_NINJA},
	{Pattern = 'Flask of Petrification', Return = Color.WHITE .. ATSW_FLASK_OF_PETRIFICATION},
	{Pattern = 'Grants (%d+)%% spell critical and (%d+) ([%a%s]+) for (.+).', Return = Color.WHITE .. '%d%%' .. Color.LIGHTGREY .. ATSW_CRIT .. ATSW_AND .. Color.WHITE .. '%d %s' .. Color.LIGHTGREY .. ATSW_FOR .. '%s'},
	
	{Pattern = 'Increase[s]*.+ damage of a ([%a%s-]+) by (%d+) for (.+).', Return = Color.WHITE .. '%2$d' .. Color.LIGHTGREY .. ATSW_DAMAGE_FOR .. ' ' .. Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = 'Attach.* .+ to your ([%a%s-]+) that increase[s]* your ([%a%s]+) by (%d+).', Return = Color.WHITE .. '%3$d' .. Color.LIGHTGREY .. ' %2$s' .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
	{Pattern = 'Attach.* .+ to your ([%a%s-]+) that deal[s]* damage every time you block with it.', Return = Color.LIGHTGREY .. ATSW_DAMAGE_ON_BLOCK_FOR .. Color.WHITE .. '%1$s', Similar = 3},
	{Pattern = 'Attach.* .+ to your ([%a%s-]+), making it impossible to ([%a%s]+).', Return = Color.LIGHTGREY .. ATSW_IMMUNITY_TO .. Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = 'Removes existing [%a%s]+ and makes you immune to ([%a%s]+) for (.+).', Return = Color.LIGHTGREY .. ATSW_IMMUNITY_TO .. Color.WHITE .. '%s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%s'},
	{Pattern = 'Attach.* [%a]+ to your ([%a%s]+) that increase[s]* your ([%a%s]+) slightly.', Return = Color.WHITE .. '+%2$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s', Similar = 3},
	{Pattern = 'Attach.* a counterweight to a (.+) making it (%d+)%% faster', Return = Color.WHITE .. '+%2$d%%' .. Color.LIGHTGREY .. ATSW_ATTACK_SPEED_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = 'Use: .*increase the (%a+) .+ worn on the ([%a%s%,]+) by (%d+).+ level (%d+) and above.', Return = Color.WHITE .. '%3$d' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_FOR .. Color.WHITE .. '%2$s' .. Color.LIGHTGREY .. ATSW_OF_LEVEL .. Color.WHITE .. '%4$d' .. Color.LIGHTGREY .. ATSW_AND_ABOVE, Similar = 15},
	{Pattern = 'Use: .*increase the (%a+) .+ worn on the ([%a%s%,]+) by (%d+) and (%a+) by (%d+).', Return = Color.WHITE .. '%3$d' .. Color.LIGHTGREY .. ' %1$s' .. ATSW_AND .. Color.WHITE .. '%5$d' .. Color.LIGHTGREY .. ' %4$s' .. ATSW_FOR .. Color.WHITE .. '%2$s', Similar = 15},
	{Pattern = 'Use: Increase critical chance on [a%s]*([%a%s]+) by (%d+)%% for (.+).', Return = Color.WHITE .. '%2$d%%' .. Color.LIGHTGREY .. ATSW_CRIT_FOR .. ' ' .. Color.WHITE .. '%3$s' .. Color.LIGHTGREY .. ATSW_FOR .. Color.WHITE .. '%1$s'},
	{Pattern = ': [%a]+s [%a%s%d]+ that [%a]*[%s]*([%a%s%d]+).', Return = StatWS, LastResort = true},
	{Pattern = 'Use: Increases ([%a%s%d]+) by (%d+)%.', Return = Color.WHITE .. '+%2$d ' .. Color.LIGHTGREY .. '%1$s.', LastResort = true},
}

for _, Item in pairs(EnchantPatterns) do
	Item.Pattern = string.lower(Item.Pattern)
end

for _, Item in pairs(PoisonPatterns) do
	Item.Pattern = string.lower(Item.Pattern)
end

for _, Item in pairs(AttributePatterns) do
	Item.Pattern = string.lower(Item.Pattern)
end

local function ReplaceWords(w)
	local r = ''
	
	if w == 'one' then
		r = 1
	elseif w == 'two' then
		r = 2
	elseif w == 'three' then
		r = 3
	elseif w == 'four' then
		r = 4
	elseif w == 'five' then
		r = 5
	elseif w == 'six' then
		r = 6
	elseif w == 'seven' then
		r = 7
	elseif w == 'eight' then
		r = 8
	elseif w == 'nine' then
		r = 9
	end
	
	return r
end

local function GetAttributes(Recipe)
	if Recipe.Type == 'header' then
		return ''
	end
	
	if Recipe.Attributes then
		return Recipe.Attributes
	end
	
	ATSWRecipeItemTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT')
	ATSW_TooltipSetSkill(ATSWRecipeItemTooltip, GetPositionFromGame(Recipe.Name))
	
	local I, Text, TextRight = 0
	local Return = ''
	local IsCloth
	local IsPoison
	
	repeat
		I = I + 1
		Text = _G['ATSWRecipeItemTooltipTextLeft' .. I]
		TextRight = _G['ATSWRecipeItemTooltipTextRight' .. I]
		Text = Text and Text:GetText()
		TextRight = TextRight and TextRight:GetText()
		
		local Similar = false
		
		if TextRight == 'Cloth' then
			IsCloth = true
		end
		
		if Text then
			Text = string.lower(Text)
			
			if I == 1 and string.find(Text, 'poison') then
				IsPoison = true
			end
		end
		
		local cR, cG, cB = _G['ATSWRecipeItemTooltipTextLeft' .. I]:GetTextColor()
		
		cR = math.floor(cR + 0.5)
		cG = math.floor(cG + 0.5)
		cB = math.floor(cB + 0.5)
		
		if Text 
		and string.sub(Text, 1, 1) ~= '\"'
		and not string.find(Text, '%(%d+%) ') then
			local Patterns, PatternFound
			
			if string.find(string.sub(Text, 1, 26), 'enchant[s]* ') then
				Patterns = EnchantPatterns
			elseif IsPoison then
				Patterns = PoisonPatterns
			else
				Patterns = AttributePatterns
			end
			
			for _, Item in pairs(Patterns) do
				if Item.Similar ~= Similar
				and not (Item.LastResort and PatternFound) then
					local PStart, PEnd, A, B, C, D, E, F = string.find(Text, Item.Pattern)
					
					if PStart and not (Item.Pattern == '(%d+) armor' and IsCloth) then
						PatternFound = true
						
						if Return ~= '' then
							Return = Return .. Color.WHITE .. ',|r '
						end

						if Item.Return then
							local Minus = ''
							
							if Item.ReplaceWords == 1then
								A = ReplaceWords(A)
							end
							
							if string.sub(Text, 1, 1) == '-' then
								Minus = Color.WHITE .. '-|r'
							end
							
							Return = Return .. Minus .. string.format(Item.Return, A, B, C, D, E, F) .. '|r'
						else
							Return = Return .. Color.LIGHTGREY .. Text .. '|r'
						end
						
						if Item.Similar then
							Similar = Item.Similar
						end
						
						if string.find(Return, 'str')
						and string.find(Return, 'agi')
						and string.find(Return, 'sta')
						and string.find(Return, 'int')
						and string.find(Return, 'spi') then
							local _, _, str = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' str')
							local _, _, agi = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' agi')
							local _, _, sta = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' sta')
							local _, _, int = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' int')
							local _, _, spi = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' spi')
							
							if str == agi and str == sta and str == int and str == spi then
								local Start = string.find(Return, '%d+' .. Color.LIGHTGREY .. ' str')
								local _, End, Amount = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' spi.')
								
								local StrLeft = string.sub(Return, 1, Start-1)
								local StrRight = string.sub(Return, End+1, string.len(Return))
								
								Return = StrLeft .. Amount .. Color.LIGHTGREY .. ' all attributes|r' .. StrRight
							end
						end
						
						if string.find(Return, 'arcane resist')
						and string.find(Return, 'fire resist')
						and string.find(Return, 'nature resist')
						and string.find(Return, 'frost resist')
						and string.find(Return, 'shadow resist') then
							local Start = string.find(Return, '%d+' .. Color.LIGHTGREY .. ' arcane')
							local _, End, Amount = string.find(Return, '(%d+)' .. Color.LIGHTGREY .. ' shadow resist')
							
							local StrLeft = string.sub(Return, 1, Start-1)
							local StrRight = string.sub(Return, End+1, string.len(Return))
							
							Return = StrLeft .. Amount .. Color.LIGHTGREY .. ' all resist' .. StrRight
						end
						
						if string.find(string.sub(Text, 1, 26), 'enchant[s]* ') then
							break
						end
						
						if (cR == 1 and cG == 1 and cB == 1)
						or	string.len(Text) - (PEnd-PStart+1) < 11 then -- Optimization: detection of full pattern match
							break
						end
						
						if PStart == 1 and PEnd == string.len(Text) then
							break
						end
					end
				end
			end

			if Return == ''
			and I == ATSWRecipeItemTooltip:NumLines()
			and I > 1
			and not string.find(Text, 'races: ')
			and not string.find(Text, 'classes: ') 
			and not string.find(Text, 'tools: ') 
			and not string.find(Text, 'reagents: ') then
				if not (cR == 1 and cG == 1 and cB == 1) then
					local Pos = string.find(Text, ': ')
					
					if not Pos then
						Pos = 0
					else
						Pos = Pos + 2
					end
					
					Text = string.sub(Text, Pos, string.len(Text))

					if string.len(Text) > 47 then
						Text = string.sub(Text, 1, 47) .. '...'
					end
					
					Return = Color.LIGHTGREY .. Text .. '|r'
				end
			end
		end
	until not Text
	
	ATSWRecipeItemTooltip:SetOwner(this, '')
	
	Recipe.Attributes = Return
	
	return Return
end

local function RemoveColorTags(Text)
    local Result = Text
	
    while string.find(Result, '|c%x%x%x%x%x%x%x%x') do
        Result = string.gsub(Result, '|c%x%x%x%x%x%x%x%x', '')
    end
	
    Result = string.gsub(Result, '|r', '')
	
    return Result
end

function ATSW_UpdateRecipes()
	local ScrollOffset 				= ScrollOffset() / ATSW_TRADESKILL_HEIGHT
	local TextureWidth				= ATSWRecipe1Texture:GetWidth()
	local _, _, _, TextureLeft	= ATSWRecipe1Texture:GetPoint(1)
	local FrameWidth				= ATSWListScrollFrame:GetWidth()
	
	for I = 1, ATSW_RECIPES_DISPLAYED do
		local Button 					= _G['ATSWRecipe' .. I]
		
		local Index 					= I + ScrollOffset
		local Exist 						= Index <= RecipesSortedSize()
		local R, Possible
		local Text, SubText = ''
		
		SetVisible(Button, false) -- Needed for tooltip update if scrolled
		SetVisible(Button, Exist)
		
		if Exist then
			R = RecipeSorted(Index)
			
			if R.Type == 'header' then
				R.Texture 				= GetCategoryTexture(IsExpanded(R.Name))
			else
				if not (R.Name and R.Texture and (R.Link or IsBeastTraining())) then
					RecipesDataIsComplete 	= RecipesDataIsComplete + 2
					RecipesDataTries 			= RecipesDataIsComplete
				end
			end
			
			local ButtonText		= _G['ATSWRecipe' .. I .. 'Text']
			local ButtonSubText	= _G['ATSWRecipe' .. I .. 'SubText']
			local ButtonTexture 	= _G['ATSWRecipe' .. I .. 'Texture']
			local QualityTexture 	= _G['ATSWRecipe' .. I .. 'QualityTexture']
			local ButtonHighlight 	= _G['ATSWRecipe' .. I .. 'Highlight']
			
			local point, relativeTo, relativePoint, _, yOfs = Button:GetPoint(2) -- LEFT, ATSWFrame, LEFT
			local BorderSize 			= 0.071
			local cR, cG, cB 			= GetLinkColorRGB(R.Link)
			local PossibleAmount	= 0
			local PossibleTotal		= 0
			local TypeColor 			= ATSWTypeColor[R.Type]
			local XOffset				= 0
			local HighlightSize 		= 0.2
			local TP = R.TrainingCost
			
			if R.Type == 'header' then
				HighlightSize 			= 0
				BorderSize 				= 0
			else
				XOffset 					= 20
				
				if not IsBeastTraining() then
					PossibleAmount 		= ATSW_HowManyItemsArePossibleToCreate(R.Name,
						ATSW_Options.ConsiderBank 			and ATSW_POSSIBLE_BANK,
						ATSW_Options.ConsiderAlts 			and ATSW_POSSIBLE_ALTS,
						ATSW_Options.ConsiderMerchants 	and ATSW_POSSIBLE_MERCHANT)
					PossibleTotal 			= ATSW_HowManyItemsArePossibleToCreateWithConsidering	(R.Name)
					
					if ATSW_Options.Unified then
						Possible 			= PossibleAmount > 0 and PossibleAmount
					elseif PossibleTotal > 0 then
						Possible				= PossibleAmount .. '/' .. PossibleTotal
					end
					
					if Possible then
						Possible				= ' |cffB0B0B0[' .. Possible .. ']|r'
					end
				end
			end
			
			if ATSW_ShowAttributes() and R.Type ~= 'header' then
				Text = GetAttributes(R)
				Button:SetFont('Fonts\\FRIZQT__.ttf', 10)
			else
				Text = R.Name .. SubNameToString(R.SubName)
				Button:SetFont('Fonts\\FRIZQT__.ttf', 12)
			end
			
			Text = Text .. (Possible or '')
			
			if TP and TP > 0 then
				SubText = format(TRAINER_LIST_TP, TP)
				
				if R.Type == 'used' then
					SubText = Color.GREY .. SubText .. '|r'
				end
			else
				SubText = ConvertCooldown(R.Cooldown) or ''
			end
			
			Button:SetText(RemoveColorTags(Text))
			
			local TextWidth = Button:GetTextWidth()

			Button:				SetText				(Text)
			ButtonSubText:	SetText				(SubText)
			Button:				SetTextColor		(TypeColor.R, TypeColor.G, TypeColor.B)
			Button:				SetPoint			(point, relativeTo:GetName(), relativePoint, Button.XOffset + XOffset, yOfs)
			Button:				SetWidth			(math.min(TextureLeft + TextureWidth + TextWidth, FrameWidth - XOffset) + 4)
			
			if TextWidth > FrameWidth - 40 then
				TextWidth = FrameWidth - 40
			else
				TextWidth = 0
			end
			
			ButtonText:		SetWidth			(TextWidth)
			ButtonTexture:	SetTexture		(R.Texture)
			ButtonTexture:	SetTexCoord		(0+BorderSize, 1-BorderSize, 0+BorderSize, 1-BorderSize)
			ButtonHighlight:	SetTexCoord		(0+HighlightSize, 1-HighlightSize, 0+HighlightSize, 1-HighlightSize)
			ButtonHighlight:	SetDesaturated	(R.Type ~= 'header')
			QualityTexture:	SetVertexColor	(cR, cG, cB)
			
			SetVisible(QualityTexture, cR and cG and cB and not (cR == 1 and cG == 1 and cB == 1))
			
			if R.Type == 'header' then
				Button:RegisterForClicks('LeftButtonUp')
			else
				Button:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
			end
		end
		
		Button.Name 			= R and (R.Name .. (R.SubName and R.SubName ~= '' and ('   (' .. R.SubName .. ')') or ''))
		Button.SubName	= R and R.SubName
		Button.Type 			= R and R.Type
		Button.Link			= R and R.Link
		Button.Position		= R and R.Position
		Button.Possible 		= Possible
		Button.Text			= Text
	end
	
	ATSW_SetHighlight(RecipeSelected())
	ATSW_UpdateListScroll()
end

function ATSW_HideRecipes()
	for I = 1, ATSW_RECIPES_DISPLAYED do
		_G['ATSWRecipe' .. I]:Hide()
	end
end

function ATSW_UpdateTasks()
    local Offset 				= FauxScrollFrame_GetOffset(ATSWTaskScrollFrame)
	
	for I = 1, ATSW_TASKS_DISPLAYED do
		local Button 			= _G['ATSWTask' .. I]
		local DeleteButton 	= _G['ATSWTask' .. I .. 'DeleteButton']
		
		local Name, Type, Amount, Texture, Link, Cooldown, Pos, Text, TypeColor, Possible
		local Index 			= I + Offset
		local Exist 				= Task(Index)
		local tR, tG, tB 		= 1, 1, 1
		
		SetVisible(Button, false) -- It is needed for tooltip update if button text is changed
		SetVisible(Button, Exist)
		SetVisible(DeleteButton, Exist)
		
		if Exist then
			Name				= Exist.Name
			Amount				= Exist.Amount
			Texture				= Exist.Texture
			Time					= GetCraftingTime(Name, Amount)
			
			Pos = GetRecipePosition(Name)
			
			if Pos then
				Type 			= Recipe(Pos).Type or 'trivial'
				Link				= Recipe(Pos).Link
				Cooldown 		= Recipe(Pos).Cooldown
				TypeColor 		= ATSWTypeColor[Type]
				tR, tG, tB 		= TypeColor.R, TypeColor.G, TypeColor.B
			end
			
			local ItemTexture 			= _G['ATSWTask' .. I .. 'Texture']
			local QualityTexture 		= _G['ATSWTask' .. I .. 'QualityTexture']
			local TimeCost		 		= _G['ATSWTask' .. I .. 'TimeCost']
			local R, G, B 					= GetLinkColorRGB(Link)
			local t_Width 				= ItemTexture:GetWidth()
			local _, _, _, t_xOfs, _ 	= ItemTexture:GetPoint(0)
			local NameIsProcessing 	= Processing.Active and (Name == Processing.Recipe)
			local PossibleAmount		= ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
			
			if PossibleAmount > 0 then
				PossibleAmount 			= '|cff10C010' .. PossibleAmount .. '|r'
			end
			
			Text = Name .. ' |cffB0B0B0[' .. Amount .. '/' .. PossibleAmount .. '|cffB0B0B0]|r'
			
			Button.R 						= tR
			Button.G 						= tG
			Button.B 						= tB
			Button.TaskIndex 			= Index
			DeleteButton.TaskIndex 	= Index
			
			Button:				SetText			(Text .. (ConvertCooldown(Cooldown) or ''))
			Button:				SetTextColor	(tR, tG, tB)
			ItemTexture:		SetTexture	(Texture)
			Button:				SetWidth		(Button:GetTextWidth() + t_xOfs + t_Width + 4)
			QualityTexture:	SetVertexColor(R, G, B)
			TimeCost:			SetText			(ShortFormatCooldown(Time, true))
			
			SetVisible(DeleteButton, 	not NameIsProcessing)
			SetVisible(TimeCost, 		not NameIsProcessing)
			SetVisible(QualityTexture, R and G and B and not (R == 1 and G == 1 and B == 1))
			
			Button:SetAlpha(1)
		end
		
		Button.Name 			= Name
		Button.Text			= Text
		Button.Position		=	Pos
		Button.TaskIndex	= Exist and Index
	end
	
	SetEnabled	(ATSWReagentsButton, 	NecessaryReagentsSize() ~= 0)
	SetVisible		(ATSWWeb, 					TasksSize() == 0)
	
	ATSW_UpdateCreateButton()
	ATSW_UpdateTaskListScroll()
end

function ATSW_HideTasks()
	for I = 1, ATSW_TASKS_DISPLAYED do
		_G['ATSWTask' .. I]:Hide()
	end
end

function ATSW_ShowSort()
	SetSortCheckboxes(SortBy())
end

function ATSW_ShowSearch()
	ATSW_BlockSearchTextChanged = true
	ATSWSearchBox:SetText(SearchString())
	
	SetVisible(ATSWSearchLabel, SearchString() == '')
	SetVisible(ATSWSearchIcon,  SearchString() == '')
	
	if SearchString() == '' then
		ATSWSearchBox:ClearFocus()
	end
	
	ATSW_BlockSearchTextChanged = false
end

function ATSW_ShowDropDown()
	UIDropDownMenu_Initialize(ATSWSubClassDropDown, 	ATSWSubClassDropDown_Initialize)
	UIDropDownMenu_Initialize(ATSWInvSlotDropDown, 	ATSWInvSlotDropDown_Initialize)
end

function ATSW_ShowSelection()
	local function FirstCraft()
		local Name, SubName = GetCraftNameType(GetFirstCraft())
		
		if SubName and SubName ~= '' then
			Name = Name .. '   (' .. SubName .. ')'
		end
		
		return Name
	end

	ATSW_SelectRecipe(RecipeSelected() or FirstCraft())
end

function ATSW_ShowAmount()
	local Number = ATSW_Amount[realm][player][Profession()]
	
	if Number == 0 then
		ATSWAmountBox:SetText(ATSW_ALL)
	else
		ATSWAmountBox:SetNumber(Number)
	end
end

function ATSW_ShowTrainingPoints()
	if IsBeastTraining() then
		local Total, Spent = GetPetTrainingPoints()
		
		ATSWTrainingPointsText:SetText(math.max(Total - Spent, 0))
		ATSWTrainingPointsFrame:SetWidth(ATSWTrainingPointsLabel:GetWidth()+ATSWTrainingPointsText:GetWidth()+20)
	end
end

function ATSW_ShowAmountMenu			(Visible)
	SetVisible(ATSWAmountText, 			Visible)
	SetVisible(ATSWDecrementButton, 	Visible)
	SetVisible(ATSWAmountBox, 			Visible)
	SetVisible(ATSWIncrementButton, 	Visible)
end

function ATSW_ShowDropDownMenu		(Visible)
	ATSWSubClassDropDown:				Hide() -- Needed for Dropdown list disappearance if changing professions
	ATSWInvSlotDropDown:					Hide()
	
	SetVisible(ATSWSubClassDropDown, 	Visible)
	SetVisible(ATSWInvSlotDropDown, 	Visible)
end

function ATSW_ShowReagentsButton		(Visible)
	SetVisible(ATSWReagentsButton, 		Visible)
	
	if not Visible then
		ATSWReagentsFrame:Hide()
	end
end

function ATSW_ShowTaskButton			(Visible)
	SetVisible(ATSWTaskButton, 			Visible)
end

function ATSW_ShowTrainingPointsMenu	(Visible)
	SetVisible(ATSWTrainingPointsFrame, Visible)
end

function ATSW_SelectRecipe(Name, Type)
	if Name then
		if Type == 'header' then
			ATSW_SwitchCategory(Name)
		else
			-- Store selected recipe name
			ATSW_SelectedRecipe[realm][player][Profession()] = Name
			ATSW_ShowRecipe(Name)
		end
	else
		ATSW_SelectedRecipe[realm][player][Profession()] = nil
		ATSW_HideRecipe()
	end
	
	ATSW_UpdateCreateButton()
end

function ATSW_SwitchCategory(Name)
	if ATSW_IsContracted(Name) then
		table.remove(Contracted(), ATSW_GetContractedPos(Name))
	else
		table.insert(Contracted(), Name)
	end
	
	ATSW_GetRecipesSorted(true)
end

function ATSW_ShowRecipe(Name)
	local GamePosition = GetPositionFromGame(Name)
	
	SelectCraftItem(GamePosition)
	
	ATSWRecipeName:Show()
	ATSWRecipeIcon:Show()
	
	local Recipe = Recipe(GetRecipePosition(Name))
	
	-- Name
	ATSWRecipeName:SetText(Recipe.Name)
	
	-- Icon
	local Quality = LinkToQuality(Recipe.Link)
	
	SetVisible(ATSWRecipeIconQualityTexture, Quality > 2)
	
	if Recipe.Texture then
		ATSWRecipeIcon:SetNormalTexture(Recipe.Texture)
		ATSWRecipeIcon.Link = Recipe.Link
	else
		ATSWRecipeIcon:Hide()
	end
	
	-- Quality border
	if Quality > 2 then
		local RColor = QualityColor[Quality]
		
		ATSWRecipeIconQualityTexture:SetVertexColor(RColor.R, RColor.G, RColor.B)
	else
		ATSWRecipeIconQualityTexture:SetVertexColor(1, 1, 1)
	end
	
	-- Amount of production
	local Min	= Recipe.ProductMin
	local Max	= Recipe.ProductMax
	
	if Max > 1 then
		if Min == Max then
			ATSWRecipeIconAmount:SetText(Min)
		else
			ATSWRecipeIconAmount:SetText(Min .. '-' .. Max)
		end
	else
		ATSWRecipeIconAmount:SetText('')
	end
	
	-- Cooldown
	local Cooldown = ConvertCooldown(Recipe.Cooldown, true)
	
	SetVisible(ATSWRecipeCooldown, Cooldown)
	ATSWRecipeCooldown.Cooldown = Recipe.Cooldown
	ATSWRecipeCooldown:SetText((Cooldown and COOLDOWN_REMAINING .. ' ' .. Cooldown) or '')
	
	local function ToolStringToTable(...)
		local Table = {}
		
		for I = 1, arg.n, 2 do
			table.insert(Table, {	Name 		= arg[I],
											Available	= arg[I+1]	})
		end
		
		return Table
	end
	
	local Tools, Required
	local BeastTraining = IsBeastTraining()
	
	if BeastTraining then
		-- Requirements
		local Button 					= _G['ATSWTool' .. 1]
		local ButtonText 			= _G['ATSWTool' .. 1 .. 'Text']
		local ButtonTexture 		= _G['ATSWTool' .. 1 .. 'Texture']
		local ReqLevel				= Recipe.RequiredLevel
		
		Required 						= BuildColoredListString(GetCraftRequirements(GamePosition))
		
		SetVisible(ATSWToolsLabel, 	Required or ReqLevel and ReqLevel > 0)
		SetVisible(Button, 				Required or ReqLevel and ReqLevel > 0)
		ATSWToolsLabel:SetText(REQUIRES_LABEL .. ' ')
		
		if Required then
			Button:						SetText(Required)
		else
			if ReqLevel and ReqLevel > 0 then
				if UnitLevel('pet') >= ReqLevel then
					Button:SetText(format(RemoveEscapeCharacters(TRAINER_PET_LEVEL), ReqLevel))
				else
					Button:SetText(format(TRAINER_PET_LEVEL_RED, ReqLevel))
				end
			else
				Button:SetText('')
			end
		end
		
		ButtonTexture:				SetWidth(Texture and 16 or -1)
		Button:							SetWidth(Button:GetTextWidth() + ButtonTexture:GetWidth())
		ButtonText:					SetTextColor(0, 0, 0)
		SetEnabled(Button, false)
	else
		-- Tools
		Tools = ToolStringToTable(GetCraftRequirements(GamePosition))
		
		SetVisible(ATSWToolsLabel, table.getn(Tools) > 0)
		ATSWToolsLabel:SetText(ATSW_TOOLS)
		
		for I = 1, ATSW_TOOLS_DISPLAYED do
			local Button 				= _G['ATSWTool' .. I]
			local ButtonText 		= _G['ATSWTool' .. I .. 'Text']
			local ButtonTexture 	= _G['ATSWTool' .. I .. 'Texture']
			local Exist 					= table.getn(Tools) >= I
			local R 						= 0
			local Texture, Name, Available
			local Position, Link
			
			SetVisible(Button, Exist)
			
			if Exist then
				Name					= Tools[I].Name
				Available				= Tools[I].Available
				
				local ID 				= ToolID[Name]
				
				if ID then
					Texture = GetItemTexture(ID)
				end
				
				R 							= (Available or not Texture) and 0 or 1
				Position 				= GetRecipePosition(Name)
				Link						= Position and GetCraftLink(Position)
				
				SetEnabled(Button, Position)
				ButtonTexture:		SetWidth(Texture and 16 or -1)
				ButtonTexture:		SetTexture(Texture)
				Button:					SetText(Name .. (I < table.getn(Tools) and ',' or ''))
				ButtonText:			SetTextColor(R, 0, 0)
				Button:					SetWidth(Button:GetTextWidth() + ButtonTexture:GetWidth())
			end
			
			Button.R					= R
			Button.Name				= Name
			Button.Link				= Link
			Button.Position 			= Position
		end
	end
	
	SetVisible(ATSWCostText, 			BeastTraining)
	SetVisible(ATSWCraftDescription, 	BeastTraining)
	
	if BeastTraining then
		-- Training cost
		if Recipe.TrainingCost > 0 then
			local Total, Spent 	= GetPetTrainingPoints()
			local Usable		 	= math.max(Total - Spent, 0)
		
			if Usable >= Recipe.TrainingCost then
				ATSWCostText:SetText(Recipe.TrainingCost .. ' ' .. TRAINING_POINTS_LABEL)
			else
				ATSWCostText:SetText(RED_FONT_COLOR_CODE .. Recipe.TrainingCost .. FONT_COLOR_CODE_CLOSE .. ' ' .. TRAINING_POINTS_LABEL)
			end
		end
		
		SetVisible(ATSWReagentsLabel, 	Recipe.TrainingCost > 0)
		SetVisible(ATSWCostText, 			Recipe.TrainingCost > 0)
		ATSWReagentsLabel:SetText(COSTS_LABEL .. ' ')
		
		-- Description
		local Description = GetCraftDescription(GamePosition)
		
		SetVisible(ATSWCraftDescription, Description)
		
		if Description then
			ATSWCraftDescription:SetText(Description)
		end
	else
		-- Reagents
		local NumReagents 		= Recipe.ReagentsSize
		
		SetVisible(ATSWReagentsLabel, NumReagents > 0)
		ATSWReagentsLabel:SetText(SPELL_REAGENTS)
		
		for I = 1, MAX_TRADE_SKILL_REAGENTS do
			local Button 				= _G['ATSWReagent' .. I]
			local ButtonQuality 	= _G['ATSWReagent' .. I .. 'QualityTexture']
			local Exists 				= I <= NumReagents
			local RName, RTexture, RAmount, RPlayerAmount, RLink, RTotalAmount, Quality, RColor, R, G, B, A, Craftable, Position
			
			SetVisible(Button, false) -- It is needed for tooltip update if schematic is changed
			SetVisible(Button, Exists)

			if Exists then
				local ButtonTexture 	= _G['ATSWReagent' .. I .. 'Texture']
				local ButtonAmount 	= _G['ATSWReagent' .. I .. 'Amount']
				local ButtonTitle 		= _G['ATSWReagent' .. I .. 'Title']
				local Pos 					= Recipe.Position
				
				RName, RTexture, RAmount, RPlayerAmount, RLink = GetReagentData(GamePosition, I)
				
				if not (RName and RTexture and RLink) then
					ReagentsDataIsComplete = false
				end
				
				if RLink then
					Quality 				= LinkToQuality(RLink)
					
					if Quality > 2 then
						RColor			= QualityColor[Quality]
						R, G, B			= RColor.R, RColor.G, RColor.B
					else
						R, G, B 			= 1, 1, 1
					end
					
					SetVisible(ButtonQuality, Quality > 2)
					
					if RPlayerAmount and RAmount then
						A 						= 0.5 + (RPlayerAmount >= RAmount and 0.45 or 0)
						RTotalAmount 	= RPlayerAmount .. ' /' .. RAmount
					else
						A 						= 0.5
						RTotalAmount 	= ''
					end
					
					-- ButtonTitle:SetTextColor(R, G, B, A) -- Colored title
					ButtonTitle:SetTextColor(0, 0, 0, 1) -- Black title
				end
				
				Position 				= GetRecipePosition(RName)
				
				ButtonTexture:		SetTexture		(RTexture)
				ButtonTexture:		SetVertexColor	(A, A, A, A)
				ButtonAmount:		SetText				(RTotalAmount)
				ButtonTitle:			SetText				(RName or '')
				ButtonQuality:		SetVertexColor	(R, G, B, 0.5)
			end
			
			Button.Name 				= RName
			Button.Link				= RLink
			Button.R 					= R 
			Button.G 					= G
			Button.B 					= B
			Button.Position 			= Position
			Button.RecipeIndex 	= Recipe.Position
			Button.ReagentIndex 	= I
		end
	end
	
	ATSW_SetHighlight(Name)
	
	-- Remove previous recipe if it is selected
	
	for I, V in pairs(PreviousRecipes()) do
		if V == Recipe.Name then
			table.remove(PreviousRecipes(), I)
			
			break
		end
	end
	
	-- Previous recipes button
	SetVisible(ATSWPreviousItemButton, PreviousRecipesSize() > 0)
	
	-- Task button
	ATSWTaskButton:Enable()
	
	-- Amount control
	ATSWIncrementButton:Enable()
	ATSWDecrementButton:Enable()
end

function ATSW_HideRecipe()
	local Visible = false
	
	ATSW_SetHighlight(nil)
	
	SetVisible(ATSWRecipeName, 		Visible)
	SetVisible(ATSWRecipeIcon, 		Visible)
	SetVisible(ATSWRecipeCooldown,	Visible)
	SetVisible(ATSWToolsLabel, 			Visible)
	SetVisible(ATSWReagentsLabel,	Visible)
	SetVisible(ATSWCraftDescription,	Visible)
	
	for I = 1, ATSW_RECIPES_DISPLAYED do
		_G['ATSWRecipe' .. I]:UnlockHighlight()
	end
	
	for I = 1, ATSW_TOOLS_DISPLAYED do
		SetVisible(_G['ATSWTool' .. I], 		Visible)
	end
	
	for I = 1, MAX_TRADE_SKILL_REAGENTS do
		SetVisible(_G['ATSWReagent' .. I], 	Visible)
	end
	
	-- Task button
	ATSWTaskButton:Disable()
	
	-- Amount control
	ATSWIncrementButton:Disable()
	ATSWDecrementButton:Disable()
end

function ATSW_SetHighlight(Name)
	if HighlightButton then
		HighlightButton:UnlockHighlight()
		HighlightButton = nil
	end
	
	if Name then
		for I = 1, ATSW_RECIPES_DISPLAYED do
			local Button = _G['ATSWRecipe' .. I]
			
			if Button.Name == Name then
				local R, G, B = Button:GetTextColor()
				
				ATSWHighlight:SetPoint('TOP', Button)
				ATSWHighlightTexture:SetVertexColor(R, G, B, 0.8)
				
				HighlightButton = Button
			end
		end
	end
	
	if HighlightButton then
		HighlightButton:LockHighlight()
	end
	
	SetVisible(ATSWHighlight, HighlightButton)
end

function ATSW_UpdateCreateButton()
	local Amount = ATSWAmountBox:GetNumber()
	local TaskPossible, Possible = 0
	local IncludeTasks = true
	
	local Position 	= GetPositionFromGame(RecipeSelected())
	
	if RecipesSize() > 0 then
		Possible = not Processing.Active
		
		if not Processing.Active then
			local Type
			
			if Position then
				_, _, Type		= GetCraftNameType(Position)
			end
			
			if IsBeastTraining() then
				if UnitName('pet') then
					local Total, Spent = GetPetTrainingPoints()
					local _, _, _, _, _, TrainingCost, ReqLevel = GetCraftInformation(Position)

					Possible = Type ~= 'used' and (math.max(Total - Spent, 0) >= TrainingCost or TrainingCost == 0)
					
					if ReqLevel and ReqLevel > 0 then
						if UnitLevel('pet') < ReqLevel then
							Possible = false
						end
					end
				else
					Possible = false
				end
			else
				if not Amount or Amount == 0 then
					Amount = 1
				end
				
				Possible = (Position and not GetCraftCooldown(Position)) and (Type ~= 'used') and ATSW_HowManyItemsArePossibleToCreate(RecipeSelected()) >= Amount
				
				for I = 1, TasksSize() do
					Pos = GetPositionFromGame(Task(I).Name)
					
					if Pos and not GetCraftCooldown(Pos) then
						if ATSW_HowManyItemsArePossibleToCreate(Task(I).Name, ATSW_POSSIBLE_NOTASK) > 0 then
							Possible = not (Processing.Active and Processing.Recipe == Task(I).Name)
							
							break
						end
					end
				end
			end
		end
	end
	
	if not Processing.Active then
		SetEnabled(ATSWCreateButton, Possible)
	end
	
	local Name = _G[GetCraftButtonToken()]
	local Text
	
	if Name == 'Enchant' then
		if Position and IsEnchant(Position) then
			Text = ATSW_ENCHANT
		else
			Text = CREATE
		end
	elseif Name == 'Create' or Name == 'Use' then
		Text = CREATE
	else
		Text = Name
	end
	
	ATSWCreateButton:SetText(Text or Name or '')
	ATSWCreateButton:SetWidth(math.max(ATSWCreateButton:GetTextWidth() + 25, 82))
end

function ATSW_Craft(Name, Amount)
	local Possible
	local Index = GetPositionFromGame(Name)
	
	if TradeSkill then
		Possible 				= ATSW_HowManyItemsArePossibleToCreate(Name, ATSW_POSSIBLE_NOTASK)
	else
		Possible 				= 1
	end
	
	Processing.Profession	= Profession()
	Processing.Recipe 		= Name
	Processing.Texture		= GetCraftTexture(Index)
	Processing.Amount 		= math.min(Amount, Possible)
	Processing.Delay			= GetTime()
	
	--Compatibility with otravi Cast Bar
	oCBIcon = Processing.Texture
	oCBName = Name
	
	ATSWFrame:RegisterEvent('SPELLCAST_START')
	
	ATSW_PushCreateButton()
	Delay(function ()
				ATSW_PushCreateButton(Processing.Active)
			end, GetLatency()*4)
	
	Craft(Index, Amount)
end

local function GetReagents(Name, Amount, Link, Texture, Table)
	local Table = Table or {}
	local Amount = Amount or 1
	
	local Pos = GetPositionFromGame(Name)
	
	if not Pos then
		for I = 1, table.getn(Table) do
			if Table[I].Name == Name then
				Table[I].Amount = Table[I].Amount + Amount
				
				return Table
			end
		end
		
		table.insert(Table,	{	Name 	= Name,
										Amount = Amount,
										Link 		= Link,
										Texture	= Texture	})
		
		return Table
	end
	
	for I = 1, GetReagentCount(Pos) do
		local RName, RTexture, RAmount, _, RLink = GetReagentData(Pos, I)
		local Min = GetCraftMinMax(GetPositionFromGame(Name))
		local Amount = math.ceil(Amount / Min)
		
		Table = GetReagents(RName, (RAmount * Amount), RLink, RTexture, Table)
	end
	
	return Table
end

local function GetSayTooltipString()
	if ChatFrameEditBox:IsVisible() or WIM_EditBoxInFocus then
		local ChatType, ChatNumber
		local SayTarget = ''
		
		if WIM_EditBoxInFocus ~= nil then
			ChatType 		= 'WHISPER'
			ChatNumber 	= WIM_EditBoxInFocus:GetParent().theUser
			
			SayTarget 		= ATSW_TOOLTIP_TO .. WIM_UserWithClassColor(ChatNumber)
		else
			ChatType, ChatNumber = ChatFrameEditBox.chatType

			if ChatType == 'WHISPER' then
					ChatNumber = ChatFrameEditBox.tellTarget
			elseif ChatType == 'CHANNEL' then
					ChatNumber = ChatFrameEditBox.channelTarget
					
					local ChatID, ChatName = GetChannelName(ChatNumber)
				
					SayTarget = ATSW_TOOLTIP_TO .. '[' .. ChatID .. '. ' .. ChatName ..']'
			elseif ChatType == 'YELL' then
					SayTarget = ATSW_TOOLTIP_TO .. ATSW_TOOLTIP_YELL
			elseif ChatType == 'PARTY' then
					SayTarget = ATSW_TOOLTIP_TO .. ATSW_TOOLTIP_PARTY
			elseif ChatType == 'GUILD' then
					SayTarget = ATSW_TOOLTIP_TO .. ATSW_TOOLTIP_GUILD
			elseif ChatType == 'RAID' then
					SayTarget = ATSW_TOOLTIP_TO .. ATSW_TOOLTIP_RAID
			end
		end

		return ATSW_TOOLTIP_SAYREAGENTS .. SayTarget, ChatType, ChatNumber
	else
		return ''
	end
end

local Lines = {}
local Message = ''
local TooltipString, ChatType, ChatNumber

StaticPopupDialogs['SAYREAGENTS'] = {
	text = '',
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		SendChatMessage(Message, ChatType, nil, ChatNumber)
		
		for L = 1, table.getn(Lines) do
			SendChatMessage(Lines[L], ChatType, nil, ChatNumber)
		end
	end,
	timeout = 0,
	preferredIndex = 2,
	showAlert = 1,
	hideOnEscape = 1
}

function ATSW_SayReagents(Position)
    TooltipString, ChatType, ChatNumber = GetSayTooltipString()
	
    local LineStart
	local R = Recipe(Position)
	
	if R.Link then
		if IsEnchant(Position) then
			LineStart = ''
		else
			LineStart = ATSW_REAGENTLIST1 .. ' '
		end
		
		local Reagents = GetReagents(R.Name)
		
		local S = string.format(TooltipString, '^.*|cffffffff?(%s*)') .. '|r?\n\n' .. LineStart .. R.Link .. ' ' .. ATSW_REAGENTLIST2
		
		Lines = {}
		
		for L = 1, table.getn(Reagents) do
			local Line = Reagents[L].Name
			
			if Reagents[L].Amount > 1 then
				Line = Line .. ' (' .. Reagents[L].Amount .. ')'
			end
			
			S = S .. '\n' .. Line
			
			table.insert(Lines, Line)
		end
		
		StaticPopupDialogs['SAYREAGENTS'].text = S .. '\n'
		Message = LineStart .. R.Link .. ' ' .. ATSW_REAGENTLIST2
		
		StaticPopup_Show('SAYREAGENTS')
	end
end

function ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
	return ATSW_HowManyItemsArePossibleToCreate(
				Name,
				ATSW_Options.ConsiderBank 			and ATSW_POSSIBLE_BANK,
				ATSW_Options.ConsiderAlts 			and ATSW_POSSIBLE_ALTS,
				ATSW_Options.ConsiderMerchants 	and ATSW_POSSIBLE_MERCHANT,
				ATSW_POSSIBLE_NOTASK	)
end

function ATSW_HowManyItemsArePossibleToCreate(Name, ...)
	local Pos 					= GetPositionFromGame(Name)
	
	if Pos then
		local I = 0
		local Possible, PossibleAmountTotal
		local MaxReagents 		= GetReagentCount(Pos)
		
		if MaxReagents > 0 then
			local function Param(P)
				for I = 1, arg.n do
					if arg[I] == P then
						return I
					end
				end
				
				return false
			end
			
			local function SetMinPossible(Amount)
				Amount 				= math.floor(Amount)
				
				if not PossibleAmountTotal or Amount < PossibleAmountTotal then
					PossibleAmountTotal = Amount
				end
				
				if PossibleAmountTotal < 0 then
					PossibleAmountTotal = 0
				end
			end
			
			repeat
				I = I + 1
				
				local RName, _, RAmount, RPlayerAmount = GetReagentData(Pos, I)
				local TotalAmount 	= RPlayerAmount
				
				if Param(ATSW_POSSIBLE_BANK) then
					TotalAmount 		= TotalAmount + ATSW_GetBankAmount(RName)
				end
				
				if Param(ATSW_POSSIBLE_ALTS) then
					TotalAmount 		= TotalAmount + ATSW_GetAltsAmount(RName)
				end
				
				if Param(ATSW_POSSIBLE_MERCHANT) then
					if ATSW_IsInMerchant(RName) and TotalAmount < RAmount then
						TotalAmount 	= math.max(PossibleAmountTotal and PossibleAmountTotal * RAmount or 0, RAmount)
					end
				end
				
				SetMinPossible(TotalAmount / RAmount)
				
				Possible = PossibleAmountTotal > 0
			until I == MaxReagents or not Possible
			
			if Possible and not Param(ATSW_POSSIBLE_NOTASK) then
				local TaskExist = DoTaskExist(Name)
				
				if TaskExist then
					SetMinPossible(PossibleAmountTotal - Task(TaskExist).Amount)
				end
			end
			
			return PossibleAmountTotal
		end
	end
	
	return 0
end

function ATSW_SetNecessary(Name, Amount, Link, Texture, NecessaryReagentMode)
	if  Name and Amount and Amount > 0 then
		local NPos
		
		for I = 1, NecessaryReagentsSize() do
			if NecessaryReagent(I).Name == Name then
				NPos = I
			end
		end
		
		if NPos then
			if NecessaryReagentMode == ATSW_NECESSARY_REAGENT_DELETE then
				if NecessaryReagent(NPos).Amount > Amount then
					NecessaryReagent(NPos).Amount = NecessaryReagent(NPos).Amount - Amount
				else
					table.remove(NecessaryReagents(), NPos)
				end
			elseif (NecessaryReagentMode == ATSW_NECESSARY_REAGENT_ADD) or not NecessaryReagentMode then
				NecessaryReagent(NPos).Amount = NecessaryReagent(NPos).Amount + Amount
			end
		elseif (NecessaryReagentMode == ATSW_NECESSARY_REAGENT_ADD) or not NecessaryReagentMode then
			table.insert(NecessaryReagents(),	{	Name 	= Name,
																	Texture = Texture,
																	Amount = Amount,
																	Link 		= Link		})
		end
		
		if ATSWReagentsFrame:IsVisible() then
			ATSW_UpdateNecessaryReagents()
		end
		
		if MerchantFrame:IsVisible() then
			ATSW_SetBuyFrameVisible()
		end
		
		if NecessaryReagentsSize() > 0 then
			if ATSWShoppingListFrame:IsVisible() then
				ATSW_UpdateAuctionList()
			else
				ATSW_ShowAuctionShoppingList()
			end
		else
			ATSWShoppingListFrame:Hide()
		end
	end
end

-- Task functions

local function AmountInTasksIndirect(Name, Prof)
	local Amount = 0
	
	for I = 1, TasksSize(Prof) do
		local Pos = GetRecipePosition(Task(I, Prof).Name, Prof)
		local TaskAmount = Task(I, Prof).Amount
		
		for J = 1, Recipe(Pos, Prof).ReagentsSize do
			local R = Recipe(Pos, Prof).Reagents[J]
			
			if R.Name == Name then
				Amount = Amount + R.Amount * TaskAmount
				
				break
			end
		end
	end
	
	return Amount
end

local function AmountInTasksDirect(Name, Prof)
	local Pos = DoTaskExist(Name, Prof)
	
	if Pos then 
		return Task(Pos, Prof).Amount
	else
		return 0
	end
end

local function AmountInTasks(Name, Prof)
	return AmountInTasksIndirect(Name, Prof) - AmountInTasksDirect(Name, Prof)
end

function ATSW_AddTask(Name, Amount, Link, Texture, Recursive, NecessaryReagentMode, Insert, Prof)
	if Name then
		if Prof == nil then
			Prof = Profession()
		end
		
		local Pos = GetRecipePosition(Name, Prof)
		
		local function Possession(Name)
			local Bags, Bank, OtherCharacters
			
			Bags 					= ATSW_GetBagsAmount(Name)
			Bank 				= ATSW_Options.ConsiderBank 	and ATSW_GetBankAmount(Name) 	or 0
			OtherCharacters	= ATSW_Options.ConsiderAlts	 	and ATSW_GetAltsAmount(Name) 	or 0
			
			return Bags + Bank + OtherCharacters
		end
		
		if Pos then
			if Amount and Amount > 0 then
				if not NecessaryReagentMode then
					local TPos = DoTaskExist(Name)
						
					if TPos then
						Task(TPos).Amount = Task(TPos).Amount + Amount
					else
						local InsertPos = Insert and DoTaskExist(Insert) or TasksSize() + 1
						
						table.insert(Tasks(), InsertPos, {	Name 	= Name,
																		Amount = Amount,
																		Texture = GetCraftTexture(Pos)	})
					end
				end
				
				for I = 1, Recipe(Pos, Prof).ReagentsSize do
					local R = Recipe(Pos, Prof).Reagents[I]
					local Merchant, Required, InsertBefore = 1, 0
					
					Merchant = ATSW_Options.ConsiderMerchants and ATSW_Merchant[R.Name] and 0 or 1
					
					if GetRecipePosition(R.Name, Prof) then
						local Min = GetCraftMinMax(GetRecipePosition(R.Name, Prof))
						
						Required = math.ceil(((AmountInTasksIndirect(R.Name, Prof) - (AmountInTasksDirect(R.Name, Prof) * Min) - math.ceil(Possession(R.Name) / Min))) / Min) * Merchant
						
						if AmountInTasksDirect(Name, Prof) > 0 and AmountInTasksDirect(R.Name, Prof) == 0 then
							InsertBefore = Name
						end
					else
						Required = R.Amount * Amount
					end
					
					if Required < 0 then
						NecessaryReagentMode = ATSW_NECESSARY_REAGENT_ADD
						Required = Amount
					end
					
					ATSW_AddTask(R.Name, Required, R.Link, R.Texture, true, NecessaryReagentMode, InsertBefore or Insert , Prof)
				end
				
				if not Recursive then
					ATSW_UpdateRecipes()
					ATSW_UpdateTasks()
				end
			end
		else
			ATSW_SetNecessary(Name, Amount, Link, Texture, NecessaryReagentMode)
		end
	end
end

function ATSW_DeleteTask(Name, Amount, Prof)
	for I = 1, TasksSize(Prof) do
		T = Task(I, Prof)
		
		if T.Name == Name then
			-- Get removing amount
			local Removed = Amount or T.Amount
			
			-- Remove task
			if not Amount or T.Amount <= Amount then
				table.remove(Tasks(Prof), I)
			else
				T.Amount = T.Amount - Amount
			end
			
			-- Remove necessary item
			ATSW_AddTask(Name, Removed, nil, nil, nil, ATSW_NECESSARY_REAGENT_DELETE, nil, Prof)
			
			if NoTasks() then
				ResetNecessaries()
			end
			
			-- Update lists
			if not (Prof and Prof ~= Profession()) then
				ATSW_UpdateRecipes()
				ATSW_UpdateTasks()
			end
			
			break
		end
	end
end

-- Progress bar functions

function ATSW_InitializeProgressBar(StartTime, EndTime)
	ATSWProgressBar:SetMinMaxValues(StartTime, EndTime)
	ATSWProgressBar:		SetAlpha(1)
	ATSWProgressBarGlow:SetAlpha(0)
	
	ATSWProgressBar.StartTime = StartTime
	ATSWProgressBar.EndTime 	= EndTime
	ATSWProgressBar.Mode		= ATSW_CAST
	ATSWProgressBar.Working 	= true
end

ATSW_Time = 0

function ATSW_StartProcessing()
	ATSWFrame:RegisterEvent('SPELLCAST_INTERRUPTED')
	
	Processing.Complete			= 0
	Processing.Stop					= false
	Processing.Active				= true
	
	ATSW_UpdateTasks()
end

function ATSW_PushCreateButton(State)
	if State or (State == nil) then
		ATSWCreateButton:SetButtonState('PUSHED', true)
		ATSWCreateButton:SetHighlightTexture('')
		ATSWCreateButton:SetTextColor(0.5, 0.5, 0.5)
		ATSWCreateButton:SetHighlightTextColor(0.5, 0.5, 0.5)
	elseif State == false then
		ATSWCreateButton:SetButtonState('NORMAL', false)
		ATSWCreateButton:SetHighlightTexture('Interface\\Buttons\\UI-Panel-Button-Highlight')
		ATSWCreateButton:SetTextColor(1, 0.82, 0)
		ATSWCreateButton:SetHighlightTextColor(1, 0.82, 0)
	end
end

function ATSW_StopProcessing()
	ATSWFrame:UnregisterEvent('SPELLCAST_START')
	ATSWFrame:UnregisterEvent('SPELLCAST_INTERRUPTED')
	
	Processing.Active				= false
	Processing.Stop					= false
	ATSWProgressBar.Working 	= false
	ATSWProgressBar.TaskItem 	= nil
	ATSWProgressBar:Hide()
	
	ATSW_PushCreateButton(false)
	ATSW_UpdateTasks()
end

function ATSW_CompleteTask()
	ATSW_DeleteTask(Processing.Recipe, 1, Processing.Profession)
	Processing.Amount 			= Processing.Amount - 1
	Processing.Complete 		= Processing.Complete + 1
	
	if (Processing.Profession == Profession()) and ATSWFrame:IsVisible() then
		local Cooldown 			= GetCraftCooldown(GetPositionFromGame(Processing.Recipe))
		
		if Cooldown then
			ATSW_UpdateFrame()
		end
	end
	
	if Processing.Amount == 0 or Processing.Stop then
		ATSW_StopProcessing()
	end
end

-- Auction/Necessaries functions

function ATSW_ShowAuctionShoppingList()
    if (AuctionFrame and AuctionFrame:IsVisible() or aux_frame and aux_frame:IsVisible()) and 
	NecessaryReagentsSize() > 0 and 
	ATSW_Options.DisplayShoppingList then
		for A = 1, ATSW_AUCTION_ITEMS_DISPLAYED do -- Create auction shopping frame buttons
			if not _G['ATSWSLFReagent' .. A] then
				local F = CreateFrame('Frame', 'ATSWSLFReagent' .. A, ATSWShoppingListFrame, 'ATSWSLFReagentTemplate')
				
				if A == 1 then
					F:SetPoint('TOPLEFT', 10, -44)
				else
					F:SetPoint('TOPLEFT', 'ATSWSLFReagent' .. A - 1, 'BOTTOMLEFT')
				end
			end
		end
		
		-- Attach (Compatible with aux)
        if not aux_frame and AuctionFrame then
            ATSWShoppingListFrame:SetPoint('TOPLEFT', 'AuctionFrame', 'TOPLEFT', 348, -435.5)
        else
            ATSWShoppingListFrame:ClearAllPoints()
            ATSWShoppingListFrame:SetPoint('TOPRIGHT', 'aux_frame', 'BOTTOMRIGHT', 30, 0)
        end
		
        ATSWShoppingListFrame:Show()
		
		ATSW_UpdateAuctionList() -- Update
    end
end

function ATSWAuction_SearchForRecipe()
    InsertIntoAuction(this:GetParent().Link)
end

local function UpdateReagentList(ButtonName, ButtonsMax, Offset)
	for I = 1, ButtonsMax do
		local Button				= _G[ButtonName .. I					]
        local Item 					= _G[ButtonName .. I .. 'Item'		]
        local Bags 					= _G[ButtonName .. I .. 'Bags'		]
        local Bank 					= _G[ButtonName .. I .. 'Bank'		]
		local Alts 					= _G[ButtonName .. I .. 'Alt'			]
        local Merchant 			= _G[ButtonName .. I .. 'Merchant'	]
		
		local R 						= NecessaryReagent(I + Offset)
		
		SetVisible(Button, false) -- It is needed for tooltip update if button text is changed
		SetVisible(Button, R)
		
        if R and Button then
			local C				= LinkToColor(R.Link) or 'ffffff'
            local AmountBags 	= ATSW_GetBagsAmount	(R.Name)
            local AmountBank 	= ATSW_GetBankAmount	(R.Name)
            local AmountAlts 	= ATSW_GetAltsAmount		(R.Name)
            local IsInMerchant	= ATSW_IsInMerchant		(R.Name)
			
			Button.Link			= R.Link
			Button.Name 			= R.Name
			
			SetEnabled(Bags, 		false)
			SetEnabled(Bank, 		false)
			SetEnabled(Merchant,	false)
			
			if AmountBags 	==	0 	then AmountBags 	=	Color.GREY 	..	AmountBags 	.. 	'|r' end
			if AmountBank 	==	0 	then AmountBank 	=	Color.GREY 	.. 	AmountBank 	..	'|r' end
			if AmountAlts		==   0 	then AmountAlts 	=	Color.GREY 	..	AmountAlts 	.. 	'|r' end
			
			Item:	SetNormalTexture	(R.Texture)
            Item:	SetText					('|cff' .. C .. '[' .. R.Name .. ']|r ' .. Color.GREY .. '[' .. R.Amount .. ']|r')
            Bags:		SetText					(AmountBags)
			Bank:	SetText					(AmountBank)
			Alts:		SetText					(AmountAlts)
						SetVisible				(Merchant, IsInMerchant)
        end
    end
end

function ATSW_UpdateAuctionList()
	local ButtonsMax	= ATSW_AUCTION_ITEMS_DISPLAYED
    local Offset			= FauxScrollFrame_GetOffset(ATSWSLScrollFrame)
	
	UpdateReagentList	('ATSWSLFReagent', ButtonsMax, Offset)
	
    FauxScrollFrame_Update(ATSWSLScrollFrame, NecessaryReagentsSize(), ButtonsMax, ATSW_TRADESKILL_HEIGHT)
end

function ATSW_UpdateNecessaryReagents()
	if NoTasks() then
		ResetNecessaries()
	end
	
	if NecessaryReagentsSize() == 0 then
		ATSWReagentsFrame:Hide()
	else
		UpdateReagentList('ATSWRFReagent', ATSW_NECESSARIES_DISPLAYED, 0)
		SetVisible(ATSWReagentsFrameAndMore, 	NecessaryReagentsSize() > ATSW_NECESSARIES_DISPLAYED)
	end
end

-- Search functions

function ATSWSearchBox_OnTextChanged(Text)
	if not ATSW_BlockSearchTextChanged then
		SetSearchString(Text)
		
		if RecipesSize() > 0 then
			ATSW_GetRecipesSorted(true)
		end
	end
end

local function ReplaceMagicCharacters(String)
	local S = String
	-- Magic characters are ^$()%.[]*? and maybe + and -
	
	S = string.gsub(S, '%%', '%%%%')
	S = string.gsub(S, '%[', '%%[')
	S = string.gsub(S, '%^', '%%^')
	S = string.gsub(S, '%$', '%%$')
	S = string.gsub(S, '%(', '%%(')
	S = string.gsub(S, '%)', '%%)')
	S = string.gsub(S, '%.', '%%.')
	S = string.gsub(S, '%[', '%%[')
	S = string.gsub(S, '%]', '%%]')
	S = string.gsub(S, '%*', '%%*')
	S = string.gsub(S, '%?', '%%?')
	
	return S
end

local function RemoveSideSpaces(S)
	if S then
		_, _, S = string.find(S, '^%s*(.-)%s*$')
	end
	
	return S
end

local Parameters = {}

function ATSW_Filter(R, Type)
	local Name = R.Name
	
	if not Name then
		return false
	elseif Name == '' then
		return true
	end
	
	ParameterString = string.lower(ReplaceMagicCharacters(SearchString()))
	
	for I in pairs(Parameters) do
		Parameters[I] = nil
	end
	
	local _, _, Search = string.find(ParameterString, '^([^:]*)')
	
	if Search then
		Parameters['name'] = RemoveSideSpaces(Search)
	end
	
	for w in string.gfind(ParameterString, ':[^:]+') do
		local _, _, Param_Name, Param_Value = string.find(w, ':(%a+)%s([^:]+)')
		
		RemoveSideSpaces(Param_Value)
		
		if Param_Name then
			Parameters[Param_Name] = Param_Value
		end
	end
	
	for PName, PValue in pairs(Parameters) do
		if ATSW_ShowAttributes() then
			Name = GetAttributes(R)
		end
		
		if PName == 'name' then
			if not string.find(string.lower(Name), PValue) then
				return false
			end
		end
		
		if PName == 'reagent' or PName == 'r' then
			local Index = GetRecipePosition(Name)
			
			if Index then
				local Found = false
				
				for J = 1, Recipe(Index).ReagentsSize do
					if string.find(string.lower(GetReagentData(Index, J) or ''), PValue) then
						Found = true
					end
				end
				
				if not Found then
					return false
				end
			else
				return false
			end
		end
		
		if	PName == 'level'
		or	PName == 'rarity'
		or	PName == 'quality'
		or PName == 'q'
		or	PName == 'possible' 
		or	PName == 'possibletotal' then
			local PMin, PDirection, PMax
			
			if PName == 'rarity' or PName == 'quality' or PName == 'q' then
				_, _, PMin, PDirection, PMax = string.find(PValue, '^(%a+)%s*([%+%-]?)%s*(%a-)$')
				
				local QualityNames = {
					['grey'		] 			= 1,
					['white'		] 			= 2,
					['green'		] 			= 3,
					['blue'		] 			= 4,
					['purple'		]			= 5,
					['orange'	]	 		= 6,
					['gold'		] 			= 7,
					['cyan'		] 			= 8,

					['poor'		] 			= 1,
					['common'	] 			= 2,
					['uncommon'] 		= 3,
					['rare'		] 			= 4,
					['epic'		]			= 5,
					['legendary'] 			= 6,
					['artifact'	] 			= 7,
					['heirloom'	] 			= 8
				}
				
				PMin	=	QualityNames[PMin]
				PMax	=	QualityNames[PMax]
			else
				_, _, PMin, PDirection, PMax = string.find(PValue, '^(%d+)%s*([%+%-]?)%s*(%d-)$')
				
				PMin =	tonumber(PMin)
				PMax =	tonumber(PMax)
			end
			
			local Param
			
			if 			PName == 'level' 				then
						Param = GetItemMinLevel(Recipe(GetRecipePosition(Name)).Position) or 0
						
			elseif 	PName == 'rarity' or PName == 'quality' or PName == 'q' then
						Param = LinkToQuality(Recipe(GetRecipePosition(Name)).Link)
						
			elseif 	PName == 'possible' 			then
						Param = ATSW_HowManyItemsArePossibleToCreate(Name)
						
			elseif 	PName == 'possibletotal' 	then
						Param = ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
			end
			
			if PMin and not PMax then
				if PDirection ~= '' then
					if PDirection == '+' then
						return Param >= PMin
					elseif PDirection == '-' then
						return Param <= PMin
					end
				else
					return Param == PMin
				end
			elseif PDirection == '-' then
				return Param > PMin and Param < PMax
			elseif PDirection == '+' then
				return Param == PMin + PMax
			end
		end
	end
	
	return true
end

-- Tooltip functions

function ATSWItemButton_OnEnter()
	local Link = this:GetParent().Link
	
	Link = string.gsub(Link, '|c(%x+)|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r', '%2')
	
    if Link then
        GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT')
        GameTooltip:SetPoint('BOTTOMLEFT', this:GetName(), 'TOPLEFT')
        GameTooltip:SetHyperlink(Link)
        GameTooltip:Show()
    end
end

function ATSWItemButton_OnLeave()
    GameTooltip:Hide()
end

function CreateDynamicTooltip(TooltipName)
	local Name = TooltipName
    local Tooltip = CreateFrame('GameTooltip', Name, UIParent, 'GameTooltipTemplate')

    Tooltip:SetBackdrop({
        bgFile = 'Interface\\Tooltips\\UI-Tooltip-Background',
        edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
	Tooltip:SetBackdropColor(0.09, 0.09, 0.18, 1)

    Tooltip.NumLines = 0
	Tooltip.MaxLineWidth = 0

    Tooltip:SetScale(GetCVar('uiscale'))
	Tooltip:SetFrameStrata('TOOLTIP')

    function ClearFrameObject(Object, IsTexture)
        if Object then
            Object:ClearAllPoints()

            if IsTexture then
                Object:SetTexture(nil)
            else
                Object:SetText('')
            end

            Object:Hide()
        end
    end

    function IncrementLineCount()
        Tooltip.NumLines = Tooltip.NumLines + 1

        return Tooltip.NumLines
    end

    function SetPointToPrevious(Object, LineIndex, PrevText)
		Object:ClearAllPoints()
		
        if LineIndex == 1 then
            Object:SetPoint('TOPLEFT', Tooltip, 'TOPLEFT', 10, -10)
        else
			Object:SetPoint('TOP', PrevText, 'BOTTOM', 0, -4)
			Object:SetPoint('LEFT', Tooltip, 'LEFT', 10, 0)
        end
    end

    function CreateTooltipLine(IconPath, LeftText, RightText, R, G, B)
        local LineIndex = IncrementLineCount()
		local Width = 0
		local IsHeader = LineIndex == 1

        if LineIndex == 1 then
            Tooltip:AddLine(' ')
        end

        local Texture = _G[Name .. 'TextureLeft' .. LineIndex]
        local LeftFontString = _G[Name .. 'TextLeft' .. LineIndex]
        local RightFontString = _G[Name .. 'TextRight' .. LineIndex]

        if IconPath then
            if not Texture then
                Texture = Tooltip:CreateTexture(Name .. 'TextureLeft' .. LineIndex)
				Texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            end

            if IsHeader then
                SetSize(Texture, 20, 20)
            else
                SetSize(Texture, 16, 16)
            end
			
            SetPointToPrevious(Texture, LineIndex, _G[Name .. 'TextLeft' .. (LineIndex - 1)])

            Texture:SetTexture(IconPath)
            Texture:Show()
        else
            if Texture then
                ClearFrameObject(Texture, true)
            end
        end

        if not LeftFontString then
            LeftFontString = Tooltip:CreateFontString(Name .. 'TextLeft' .. LineIndex, 'ARTWORK', IsHeader and 'GameTooltipHeaderText' or 'GameFontNormal')
        end
		
		if not (R and G and B) then
			R, G, B = 1, 0.82, 0
        end
		
		LeftFontString:SetTextColor(R, G, B)
		
        if IconPath then
			LeftFontString:ClearAllPoints()
            LeftFontString:SetPoint('LEFT', Texture, 'RIGHT', 2, 0)
        else
            SetPointToPrevious(LeftFontString, LineIndex, _G[Name .. 'TextLeft' .. (LineIndex - 1)])
        end

		if R and R > 1 then -- Set font
			LeftFontString:SetFont('Fonts\\FRIZQT__.ttf', R)
		elseif not IsHeader then
			LeftFontString:SetFont('Fonts\\FRIZQT__.ttf', 12)
		end
		
        LeftFontString:SetText(LeftText)
        LeftFontString:Show()
		
		if LeftText then
			Width = Width + string.len(LeftText) * 3.7
		end

        if RightText then
            if not RightFontString then
                RightFontString = Tooltip:CreateFontString(Name .. 'TextRight' .. LineIndex, 'ARTWORK', IsHeader and 'GameTooltipHeaderText' or 'GameTooltipText')
            end
			
			RightFontString:SetTextColor(1, 0.82, 0)
			RightFontString:ClearAllPoints()
            RightFontString:SetPoint('TOP', LeftFontString, 'TOP')
            RightFontString:SetPoint('RIGHT', Tooltip, 'RIGHT', -10, 0)
            RightFontString:SetText(RightText)
            RightFontString:Show()
			
			Width = Width + string.len(RightText) * 3.5
        else
            if RightFontString then
                ClearFrameObject(RightFontString, false)
            end
        end
		
		Tooltip.MaxLineWidth = math.max(math.max(Width, Tooltip.MaxLineWidth), 350)
    end

    function Tooltip:AddIconLine(IconPath, Text, R, G, B)
        CreateTooltipLine(IconPath, Text, nil, R, G, B)
    end

    function Tooltip:AddTextLine(Text, R, G, B)
        CreateTooltipLine(nil, Text, nil, R, G, B)
    end

    function Tooltip:AddDoubleLine(IconPath, LeftText, RightText, R, G, B)
        CreateTooltipLine(IconPath, LeftText, RightText, R, G, B)
    end

    function Tooltip:ClearLines()
        for I = Tooltip.NumLines, 1, -1 do
            ClearFrameObject(_G[Name .. 'TextureLeft' .. I], true)
            ClearFrameObject(_G[Name .. 'TextLeft' .. I], false)
            ClearFrameObject(_G[Name .. 'TextRight' .. I], false)
        end

        Tooltip.NumLines = 0
		Tooltip.MaxLineWidth = 0
    end

    return Tooltip
end

ATSWRecipeTooltip = CreateDynamicTooltip('ATSWRecipeTooltip')

local function CreateGameTooltip(TooltipName)
    local Tooltip = CreateFrame('GameTooltip', TooltipName, UIParent, 'GameTooltipTemplate')

    Tooltip:SetBackdrop(nil)
    Tooltip:SetScale(GetCVar('uiscale'))
    Tooltip:Hide()

    return Tooltip
end

ATSWRecipeItemTooltip = CreateGameTooltip('ATSWRecipeItemTooltip')

local function AddSpace(S)
	if string.len(S) 	== 0 then
		S = S .. '    '
	elseif string.len(S) 	== 1 then
		S = S .. '  '
	end
	
	return S
end

local function AddColor(S, Amount)
	if Amount == 0 then
		S = Color.GREY .. S	.. '|r'
	else
		S = '|cffffffff' .. S .. '|r'
	end
	
	return S
end

local function WordWrap(Text, Max)
	if not Text then
		return ''
	end

	local Length = string.len(Text)
	
	if Length <= Max then
		return Text
	end

	local Result = ''
	local I = 1

	while I <= Length do
		Result = Result .. string.sub(Text, I, I + Max - 1)
		I = I + Max
		
		if I <= Length then
			Result = Result .. '\n'
		end
	end

	return Result
end

function ATSW_ShowRecipeTooltip()
    if not ATSW_Options.RecipeTooltip then
		return
	end
	
	local R = Recipe(GetRecipeSortedPosition(this.Name))
	
	if IsBeastTraining() then
		if R then
			GameTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT')
			GameTooltip:SetCraftSpell(R.Position)
		end
		
		return
	end
	
	local Tooltip = ATSWRecipeTooltip
	
	Tooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT', -4, 5)
	
	if this.Type == 'header' then
		return
	end
	
	local LINE_HEIGHT = 18
	
	Tooltip:ClearLines()
	
	-- Header
	
	local cR, cG, cB = 1, 1, 1
	
	if R.Link then
		cR, cG, cB = GetLinkColorRGB(R.Link)
	end

	Tooltip:AddIconLine(R.Texture, R.Name, cR, cG, cB)
	
	-- Game tooltip information
	
	ATSWRecipeItemTooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT')
	
	ATSW_TooltipSetSkill(ATSWRecipeItemTooltip, this.Position)
	
	ATSWRecipeItemTooltipTextLeft1:SetText(' ')
	ATSWRecipeItemTooltip:Show()
	
	local Height = ATSWRecipeItemTooltip:GetHeight()
	
	if Height > LINE_HEIGHT * 2 then
		for I = 1, Height/LINE_HEIGHT do
			Tooltip:AddTextLine(' ')
		end
	end

	-- Skill ups
	
	local AtlasLoot, SU2, SU3, SU4 = ATSW_SkillUps(R.Name)
	
	if AtlasLoot then
		Tooltip:AddTextLine(ATSW_TOOLTIP_SKILLUPS .. Color.ORANGE .. (AtlasLoot or '?') ..' ' .. Color.YELLOW .. (SU2 or '?') ..' ' .. Color.GREEN .. (SU3 or '?') ..' ' .. Color.GREY .. (SU4 or '?'), 11)
	end
	
	-- Required reagents
	
	Tooltip:AddTextLine(' ')
	Tooltip:AddDoubleLine(nil, ATSW_TOOLTIP_NECESSARY,
		ATSW_TOOLTIP_INBAGS 	.. '   ' .. ATSW_TOOLTIP_INBANK .. '   ' .. ATSW_TOOLTIP_ONALTS)
	
	-- Reagents
	
	local Reagents = GetReagents(R.Name, 1)
	
	for I = 1, 19 do
		if I <= table.getn(Reagents) then
			local R = Reagents[I]
			local Bags 				= ATSW_GetBagsAmount	(R.Name)
			local Bank 				= ATSW_GetBankAmount	(R.Name)
			local Alts 				= ATSW_GetAltsAmount		(R.Name)
			local Merchant 		= ''
			
			if ATSW_IsInMerchant(R.Name) then
				Merchant 			= ' ' .. Color.GREY .. ATSW_TOOLTIP_BUYABLE..'|r'
			end
			
			local Amountstring 	= ''
			
			if R.Amount > 1 then
				Amountstring 	= Color.GREY .. ' (' .. R.Amount .. ')|r'
			end
			
			if Bags == 0 then
				Bags = ''
			end
			
			if Bank == 0 then
				Bank = ''
			end
			
			if Alts == 0 then
				Alts = ''
			end
			
			local BagStr, BankStr, AltsStr = Bags, Bank, Alts
			
			BagStr 	= AddSpace	(BagStr				)
			BankStr	= AddSpace	(BankStr			)
			AltsStr 	= AddSpace	(AltsStr				)
			BagStr	= AddColor	(BagStr, 	Bags	)
			BankStr	= AddColor	(BankStr, 	Bank	)
			AltsStr	= AddColor	(AltsStr,		Alts	)
			
			local cR, cG, cB = GetLinkColorRGB(R.Link)
			
			Tooltip:AddDoubleLine(R.Texture, 
				(R.Name or '') .. Amountstring .. Merchant, 
				BagStr 	.. '       ' .. BankStr .. '       ' .. AltsStr .. ' ', cR, cG, cB)
		end
	end
	
	local S
	
	if ChatFrameEditBox:IsVisible() or WIM_EditBoxInFocus then
		S = GetSayTooltipString()
	elseif ATSW_HowManyItemsArePossibleToCreate(R.Name) > 0 then
		S = ATSW_TOOLTIP_ADDITEM
	end
	
	Tooltip:Show()
	Tooltip:SetHeight(Tooltip.NumLines * LINE_HEIGHT + 12 - ATSWRecipeItemTooltip:NumLines() * 2.3)
	
	if S then
		Tooltip:AddTextLine(S)
		Tooltip:SetHeight(Tooltip:GetHeight() + 24)
	end
	
	Tooltip:SetWidth(Tooltip.MaxLineWidth)
	
	ATSWRecipeItemTooltip:ClearAllPoints()
	ATSWRecipeItemTooltip:SetPoint('TOPLEFT', Tooltip, 'TOPLEFT', 0, -8)
end

-- Inventory functions

ATSW_Bags = {}

function ATSW_SaveBag(Bag)
    if ATSW_Bags[realm] == nil then
        ATSW_Bags[realm] = {}
    end
	
	if ATSW_Bags[realm][player] == nil then
		ATSW_Bags[realm][player] = {}
	end
	
	if ATSW_Bags[realm][player][Bag] == nil then
		ATSW_Bags[realm][player][Bag] = {}
	end
	
	-- Clear
	for Slot in pairs(ATSW_Bags[realm][player][Bag]) do
		ATSW_Bags[realm][player][Bag][Slot] = nil
	end
	
	-- Memorize
	for Slot = 1, GetContainerNumSlots(Bag) do
		local Name = LinkToName(GetContainerItemLink(Bag, Slot))
		
		if Name then
			local _, Amount = GetContainerItemInfo(Bag, Slot)
			
			if ATSW_Bags[realm][player][Bag][Slot] == nil then
				ATSW_Bags[realm][player][Bag][Slot] = {}
			end
			
			 ATSW_Bags[realm][player][Bag][Slot][Name] = Amount
		end
	end
end

function ATSW_GetBagsAmount(Name)
    local Total = 0
	
	if Name then
		for Bag = 0, 4 do
			for Slot = 1, GetContainerNumSlots(Bag) do
				local ItemName = LinkToName(GetContainerItemLink(Bag, Slot))
				
				if ItemName and ItemName == Name then
					local _, Amount = GetContainerItemInfo(Bag, Slot)
					
					Total = Total + Amount
				end
			end
		end
	end
	
    return Total
end

-- Bank functions

ATSW_Bank = {}

function ATSW_SaveBank()
	if BankFrameOpened then
		if not ATSW_Bank[realm] then
			ATSW_Bank[realm] = {}
		end
		
		if not ATSW_Bank[realm][player] then
			ATSW_Bank[realm][player] = {}
		end
		
		-- Clear
		for I in pairs(ATSW_Bank[realm][player]) do
			ATSW_Bank[realm][player][I] = nil
		end
		
		-- Memorize item slots
		for Slot = 1, 24 do
			local Name = LinkToName(GetContainerItemLink(BANK_CONTAINER, Slot))
			
			if Name then
				local _, Amount = GetContainerItemInfo(BANK_CONTAINER, Slot)
				
				ATSW_AddToBank(Name, Amount)
			end
		end
		
		-- Memorize bank bag slots
		for Container = 5, 10 do
			for Slot = 1, GetContainerNumSlots(Container) do
				local Name = LinkToName(GetContainerItemLink(Container, Slot))
				
				if Name then
					local _, Amount = GetContainerItemInfo(Container, Slot)
					
					ATSW_AddToBank(Name, Amount)
				end
			end
		end
		
		if ATSWFrame:					IsVisible() then ATSW_UpdateRecipes					() end
		if ATSWReagentsFrame:		IsVisible() then ATSW_UpdateNecessaryReagents	() end
		if ATSWShoppingListFrame:	IsVisible() then ATSW_UpdateAuctionList				() end
	end
end

function ATSW_AddToBank(Name, Amount)
    if not ATSW_Bank[realm] then
        ATSW_Bank[realm] = {}
		ATSW_Bank[realm][player] = {}
    end
	
	local BankAmount = ATSW_Bank[realm][player][Name] or 0
	
	ATSW_Bank[realm][player][Name] = BankAmount + Amount
end

function ATSW_GetBankAmount(Name)
    if Name then
		if ATSW_Bank[realm] then
			if ATSW_Bank[realm][player] then
				if ATSW_Bank[realm][player][Name] then
					return ATSW_Bank[realm][player][Name]
				end
			end
		end
	end
	
    return 0
end

-- Alternative character functions
local function GetAltsAmountInBags(Name, PlayerName)
	local Table		= ATSW_Bags[realm]
	local Amount	= 0
	
	if Name and Table then
		for PName in pairs(Table) do
			if (PlayerName and PlayerName == PName) or (PlayerName == nil and PName ~= player) then
				for Bag 	in pairs(Table[PName]) do
					for Slot 	in pairs(Table[PName][Bag]) do
						for IName, IAmount in pairs(Table[PName][Bag][Slot]) do
							if IName == Name then
								Amount = Amount + IAmount
							end
						end
					end
				end
			end
		end
	end
	
	return Amount
end

local function GetAltsAmountInBank(Name, PlayerName)
	local Table		= ATSW_Bank[realm]
	local Amount	= 0
	
	if Name and Table then
		for PName in pairs(Table) do
			if PName ~= player then
				for IName, IAmount in pairs(Table[PName]) do
					if IName == Name then
						Amount = Amount + IAmount
					end
				end
			end
		end
	end
	
	return Amount
end

function ATSW_GetAltsAmount(Name)
    return GetAltsAmountInBags(Name) + GetAltsAmountInBank(Name)
end

local function GetLocation(Table, In)
	if Name then
		for RName in pairs(Table) do
			if RName == realm then
				for PName in pairs(Table[RName]) do
					if PName ~= player then
						local Amount = 0
						
						if Table == ATSW_Bags then
							Amount = Amount + GetAltsAmountInBags(Name, PName)
						elseif Table == ATSW_Bank then
							Amount = Amount + GetAltsAmountInBank(Name, PName)
						end
						
						if Amount > 0 then
							if not HeaderAdded then
								Tooltip:AddTextLine(ATSW_TOOLTIP_POSSESS .. ' ' .. this:GetParent().Link .. ':')
								
								HeaderAdded = true
							end
							
							Tooltip:AddTextLine(ClassColorize(PName) .. ': ' .. '|cffffffff' .. Amount .. '|r ' .. In)
						end
					end
				end
			end
		end
	end
end

function ATSW_GetAltsLocationIntoTooltip(Name)
	local HeaderAdded = false
	local Tooltip = ATSWRecipeTooltip
	
	Tooltip:ClearLines()
	Tooltip:SetOwner(this, 'ANCHOR_BOTTOMRIGHT', 0)
	
	GetLocation(ATSW_Bags, ATSW_ALTLIST1)
	GetLocation(ATSW_Bank, ATSW_ALTLIST2)
	
	Tooltip:Show()
	Tooltip:SetWidth(Tooltip.MaxLineWidth)
	Tooltip:SetHeight(18 + Tooltip.NumLines * 16)
end

-- Merchant functions

ATSW_Merchant = {}

function ATSW_UpdateMerchant()
    if MerchantFrame:IsVisible() then
		for I = 1, GetMerchantNumItems() do
			local Name, _, _, _, Available = GetMerchantItemInfo(I)
			
			if Name and Available == -1 then
				ATSW_Merchant[Name] = true
			end
		end
	end
end

function ATSW_IsInMerchant(Name)
    return Name and ATSW_Merchant[Name]
end

local function GetMerchantReagentsPrice(Buy)
	if not (MerchantFrame:IsVisible() and NecessaryReagentsSize() > 0) then
		return
	end
	
	local TotalPrice = 0
	
	for N = 1, NecessaryReagentsSize() do
		-- Calculate total price
		local Item = NecessaryReagent(N)
		
		for M = 1, GetMerchantNumItems() do
			local MName, _, MPrice, MQuantity, MAvailable = GetMerchantItemInfo(M)
			
			if Item.Name == MName then
				local HaveQuantity	= ATSW_GetBagsAmount(Item.Name) + (ATSW_ConsigerBank and ATSW_GetBankAmount(Item.Name) or 0)
				local NeedQuantity	= Item.Amount - HaveQuantity
				local BuyQuantity = math.ceil(NeedQuantity / MQuantity)
				
				if BuyQuantity > MAvailable and MAvailable > 0 then
					BuyQuantity = MAvailable
				end
				
				if BuyQuantity < 0 then
					BuyQuantity = 0
				end
				
				TotalPrice = TotalPrice + BuyQuantity * MPrice
				
				if Buy and BuyQuantity > 0 then
					BuyMerchantItem(M, BuyQuantity)
				end
			end
		end
	end
	
	return TotalPrice
end

function ATSW_SetBuyFrameVisible()
	local Price = GetMerchantReagentsPrice()
	
   if Price and Price > 0 then
		MoneyFrame_Update(ATSWBuyPrice:GetName(), Price)
		ATSWBuyButton:Enable()
		ATSWBuyNecessaryFrame:Show()
	else
		ATSWBuyNecessaryFrame:Hide()
	end
end

function ATSW_BuyFromMerchant()
    GetMerchantReagentsPrice(true)
end

-- Compatibility with other AddOns

-- ArmorCraft
function ATSW_ArmorCraftCompatibility()
	if AC_Craft and AC_Craft:GetParent() ~= ATSWFrame then
		AC_Craft:				SetParent			(ATSWFrame)
		AC_Craft:				SetPoint			('TOPLEFT', 'ATSWFrame', 'TOPRIGHT', 0, 0)
		AC_Craft:				SetFrameLevel	(0)
		AC_ToggleButton:	SetParent			(ATSWFrame)
		AC_ToggleButton:	SetFrameLevel	(ATSWFrame:GetFrameLevel() + 3)
		AC_ToggleButton:	ClearAllPoints()
		AC_ToggleButton:	SetPoint			('RIGHT', 'ATSWFrameCloseButton', 'LEFT', - AC_ToggleButton:GetWidth() - 80)
		AC_UseButton:		ClearAllPoints()
		AC_UseButton:		SetFrameLevel	(ATSWFrame:GetFrameLevel() + 3)
		AC_UseButton:		SetPoint			('RIGHT', 'AC_ToggleButton', 'LEFT', -2, 0)
		AC_Craft:				SetAlpha			(1.0)
		AC_ToggleButton:	SetAlpha			(1.0)
		AC_UseButton:		SetAlpha			(1.0)
		AC_ToggleButton:	Show()
	end
end

-- AtlasLoot
ATSW_AtlasLoot = nil

function ATSW_CheckForAtlasLootLoaded()
	return AtlasLoot_Data and AtlasLoot_Data['AtlasLootCrafting']
end

ATSWSkillUpCache = {}

function ATSW_SkillUps(Name)
	if not ATSW_AtlasLoot then
		return
	end

	if ATSWSkillUpCache[Name] then
		local C = ATSWSkillUpCache[Name]
		
		return C[1], C[2], C[3], C[4]
	end
	
	local Texture = ATSW_GetProfessionTexture(Profession())
	
	if not (Texture and ProfessionNamesForAtlasLoot[Texture]) then
		return
	end
	
	local Found = false
	
	for _, Item in pairs(ProfessionNamesForAtlasLoot[Texture]) do
		if Item ~= '' and ATSW_AtlasLoot[Item] then
			for _, Info in pairs(ATSW_AtlasLoot[Item]) do
				for N, Param in pairs(Info) do
					if N == 3 and string.sub(Param, 5, -1) == Name then
						Found = true
					end
					
					if N == 4 and Found then
						-- AtlasLoot item example:
						-- { 's3924', 'inv_gizmo_pipe_02', '=q1=Copper Tube', '=ds=#sr# =so1=50 =so2=80 =so3=95 =so4=110' },
						-- =so parameters contain difficulty of the skill
						
						local _, _, SU1, SU2, SU3, SU4 = string.find(Param, '=so1=(.+)%s*=so2=(.+)%s*=so3=(.+)%s*=so4=(.+)')

						SU1 = tonumber(SU1)
						SU2 = tonumber(SU2)
						SU3 = tonumber(SU3)
						SU4 = tonumber(SU4)
						
						ATSWSkillUpCache[Name] = ATSWSkillUpCache[Name] or {SU1, SU2, SU3, SU4}

						return SU1, SU2, SU3, SU4
					end
				end
			end
		end
	end
end

function ATSW_CompareSkill(Name)
	local SU1, SU2, SU3, SU4 = ATSW_SkillUps(Name)
	
	SU1 = SU1 or 0
	SU2 = SU2 or 0
	SU3 = SU3 or 0
	SU4 = SU4 or 0
	
	if SU1 then
		return SU1*20+(SU2-SU1)+(SU3-SU2)+(SU4-SU3) -- Works somehow
	else
		return 0
	end
end

function ATSW_CompareDifficultyUsingExternalData(Left, Right)
	return (ATSW_TypeToNumber(Left.Type) == ATSW_TypeToNumber(Right.Type)) and (ATSW_CompareSkill(Left.Name) > ATSW_CompareSkill(Right.Name))
end