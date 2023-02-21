
-- Advanced Trade Skill Window version 2.0.0 for WoW Vanilla
-- copyright 2006 by Rene Schneider (Slarti on EU-Blackhand), 2017 by laytya
-- Modified by Alexander Shelokhnev (Dreamios on Turtle-WoW) in year 2022

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

ERR_LEARN_RECIPE_PATTERN 			= string.gsub(ERR_LEARN_RECIPE_S, 			"%%s", "(.+)"		)
ERR_LEARN_SPELL_PATTERN 				= string.gsub(ERR_LEARN_SPELL_S, 			"%%s", "(.+)"		)
ERR_LEARN_ABILITY_PATTERN 			= string.gsub(ERR_LEARN_ABILITY_S, 		"%%s", "(.+)"		)
ERR_UNLEARN_RECIPE_PATTERN			= string.gsub(ERR_SPELL_UNLEARNED_S, 	"%%s", "(.+)"		)
ERR_SKILL_UP_PATTERN 					= string.gsub(string.gsub(ERR_SKILL_UP_SI,"%%d", "%%d+"),"%%s","(.+)")
ERR_SKILL_GAINED_PATTERN 				= string.gsub(ERR_SKILL_GAINED_S, 			"%%s", "(.+)"		)
LOOT_ITEM_CREATED_SELF_PATTERN = string.gsub(LOOT_ITEM_CREATED_SELF,	"%%s",	"(.+)"		)

UIPanelWindows["ATSWFrame"		] 	= { area = "left", 		pushable = 8 }
UIPanelWindows["ATSWCSFrame"		] 	= { area = "left", 		pushable = 8 }
UIPanelWindows["ATSWOptionsFrame"]	= { area = "center", 	pushable = 1 }

ATSWTypeColor 								= {}
ATSWTypeColor["optimal"	] 				= {	R = 1.00,	G = 0.50,	B = 0.25	}
ATSWTypeColor["medium"	] 				= {	R = 1.00,	G = 1.00,	B = 0.00	}
ATSWTypeColor["easy"		]    			= {	R = 0.25,	G = 0.75,	B = 0.25	}
ATSWTypeColor["trivial"		] 				= {	R = 0.50,	G = 0.50,	B = 0.50	}
ATSWTypeColor["used"		]  				= {	R = 0.50,	G = 0.50,	B = 0.50	}
ATSWTypeColor["header"	]  				= {	R = 1.00,	G = 0.82,	B = 0		}
ATSWTypeColor["none"		]    			= {	R = 0.25,	G = 0.75,	B = 0.25	}

local QualityColor 								= {}
QualityColor[1] 									= {	R = 0.62,	G = 0.62, 	B = 0.62	}
QualityColor[2] 									= {	R = 1,		G = 1, 		B = 1		}
QualityColor[3] 									= {	R = 0.12,	G = 1, 		B = 0		}
QualityColor[4] 									= {	R = 0,		G = 0.44, 	B = 0.87	}
QualityColor[5] 									= {	R = 0.64,	G = 0.21, 	B = 0.93	}
QualityColor[6] 									= {	R = 1,		G = 0.5, 	B = 0		}
QualityColor[7] 									= {	R = 0.9,	G = 0.8, 	B = 0.5		}
QualityColor[8] 									= {	R = 0,		G = 0.8, 	B = 1		}


local QualityNames								= {}
QualityNames["grey"		] 					= 1
QualityNames["white"		] 					= 2
QualityNames["green"		] 					= 3
QualityNames["blue"		] 					= 4
QualityNames["purple"		]					= 5
QualityNames["orange"	]	 				= 6
QualityNames["gold"		] 					= 7
QualityNames["cyan"		] 					= 8

QualityNames["poor"			] 				= 1
QualityNames["common"		] 				= 2
QualityNames["uncommon"	] 				= 3
QualityNames["rare"				] 				= 4
QualityNames["epic"			]				= 5
QualityNames["legendary"		] 				=	6
QualityNames["artifact"		] 				= 7
QualityNames["heirloom"		] 				= 8

local ToolID 										= {}
ToolID["Blacksmith Hammer"			] 		= 5956
ToolID["Arclight Spanner"				] 		= 6219
ToolID["Gyromatic Micro-Adjustor"	]		= 10498
ToolID["Philosopher's Stone"		] 		= 9149
ToolID["Runed Copper Rod"			] 		= 6218
ToolID["Runed Silver Rod"			] 		= 6339
ToolID["Runed Golden Rod"			] 		= 11130
ToolID["Runed Truesilver Rod"		] 		= 11145
ToolID["Runed Arcanite Rod"		] 		= 16207

local Professions	= {
	"Interface\\Icons\\Trade_Engraving",					-- Enchanting
	"Interface\\Icons\\Trade_Tailoring",					-- Tailoring
	"Interface\\Icons\\Trade_Engineering",				-- Engineering
	"Interface\\Icons\\Trade_BlackSmithing",			-- Blacksmithing
	"Interface\\Icons\\Spell_Fire_FlameBlades",			-- Smelting
	"Interface\\Icons\\Trade_Alchemy",					-- Alchemy
	"Interface\\Icons\\INV_Misc_ArmorKit_17",			-- Leatherworking
	"Interface\\Icons\\INV_Misc_Food_15",				-- Cooking
	"Interface\\Icons\\Spell_Holy_SealOfSacrifice",	-- First Aid
	"Interface\\Icons\\Trade_Survival",					-- Survival
	"Interface\\Icons\\Ability_Hunter_BeastCall02",	-- Beast Training
	"Interface\\Icons\\Trade_BrewPoison"				-- Poisons
}

local ClassColors 									= {}
ClassColors["Druid"		]						= "|cffff7c0a"
ClassColors["Hunter"	]						= "|cffaad372"
ClassColors["Mage"		]						= "|cff3fc7eb"
ClassColors["Paladin"		]						= "|cfff48cba"
ClassColors["Priest"		]						= "|cffffffff"
ClassColors["Rogue"		]						= "|cfffff468"
ClassColors["Shaman"	]						= "|cff0070dd"
ClassColors["Warlock"	]						= "|cff8788ee"
ClassColors["Warrior"	]						= "|cffc69b6d"

local realm 										= GetRealmName()
local player 										= UnitName("player")
local class											= UnitClass("player")
ATSW_player										= player

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
ATSW_Debug 									= false
ATSW_SwitchingToEditor					= false
ATSW_SwitchingToMain						= false

--Selected
ATSW_Profession 								= {}
ATSW_Profession[player] 					= nil
ATSW_SelectedRecipe 						= {}
ATSW_SelectedRecipe[player] 				= {}

--Top control panel
ATSW_SortBy 									= {}
ATSW_SortBy[player] 							= {}
ATSW_SearchString 							= {}
ATSW_SearchString[player] 					= {}
ATSW_BlockSearchTextChanged 			= false
ATSW_SubClassFilter 							= {}
ATSW_SubClassFilter[player] 				= {}
ATSW_InvSlotFilter 							= {}
ATSW_InvSlotFilter[player] 					= {}

--Recipes auxiliary arrays
ATSW_ContractedCategories 				= {}
ATSW_ContractedCategories[player] 	= {}
ATSW_ScrollOffset 								= {}
ATSW_ScrollOffset[player] 					= {}
ATSW_NeedToUpdate 						= {}
ATSW_NeedToUpdate[player] 				= {}

--Previous recipes
ATSW_PreviousRecipes 						= {}
ATSW_PreviousRecipes[player] 			= {}

--Tasks
ATSW_Tasks 										= {}
ATSW_Tasks[player] 							= {}
ATSW_NecessaryReagents 					= {}
ATSW_NecessaryReagents[player] 		= {}

--Bottom control panel
ATSW_Amount 									= {}
ATSW_Amount[player] 						= {}

--Processing
local Processing 									= false
local ProcessingProfession					= nil
local ProcessingRecipe 						= nil
local ProcessingTexture						= nil
local ProcessingRecipeTime					= 0
local ProcessingAmount 						= 0
local ProcessingDelay							= 0
local ProcessingComplete						= 0
local ProcessingStop							= false

--Options
ATSW_Unified 									= true
ATSW_ConsiderBank 							= false
ATSW_ConsiderAlts 							= false
ATSW_ConsiderMerchants 					= false
ATSW_RecipeTooltip 							= true
ATSW_AutoBuy 									= false
ATSW_DisplayShoppingList 					= true

--Controllable tables instead of standart tables do not leave garbage if they change in the game
ATSW_Recipes 									= {}
ATSW_Recipes[player] 						= {}
ATSW_RecipesSize 								= {}
ATSW_RecipesSize[player] 					= {}
ATSW_RecipesSorted 							= {}
ATSW_RecipesSorted[player] 				= {}
ATSW_RecipesSortedSize 					= {}
ATSW_RecipesSortedSize[player] 			= {}
local UncategorizedHeader 					= {}

--Game information get functions

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
								return 1 + (Type == "header" and 1 or 0) end
end

local function GetCraftNameType		(Index)
	local Name, Type, SubName
	
	if TradeSkill	then	Name, Type = GetTradeSkillInfo(Index)
						else	Name, SubName, Type = GetCraftInfo(Index) end
	
	return Name, Type, SubName
end

local function GetCraftTexture			(Index)
	if TradeSkill	then	return GetTradeSkillIcon(Index)
						else	return GetCraftIcon(Index) end
end

local function GetCraftLink					(Index)
	if TradeSkill	then	return GetTradeSkillItemLink(Index)
						else	return GetCraftItemLink(Index) end
end

local function GetCraftMinMax				(Index)
	local Min, Max
	
	if TradeSkill	then	Min, Max = GetTradeSkillNumMade(Index)
						else	Min, Max = 1, 1 end
	
	return Min, Max
end

local function GetCraftCooldown			(Index)
	if TradeSkill	then	return GetTradeSkillCooldown(Index)
						else	return nil end
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
	return ATSW_Profession[player]
end

local function RecipeSelected()
	return ATSW_SelectedRecipe[player][Profession()]
end

function ATSW_RecipeSelected()
	return RecipeSelected()
end

local function Recipes(Prof)
	if Prof == nil then Prof = Profession() end
	
	return ATSW_Recipes[player][Prof]
end

local function RecipesSize(Prof)
	if Prof == nil then Prof = Profession() end
	
	return ATSW_RecipesSize[player][Prof] or 0
end

local function SetRecipesSize(Value)
	if Profession() then
		ATSW_RecipesSize[player][Profession()] = Value
	end
end

local function Recipe(I, Prof)
	if Prof == nil then Prof = Profession() end
	
	return Recipes(Prof)[I]
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
	
	if R.Cooldown then R.Cooldown = R.Cooldown + GetTime() end
	
	SetRecipesSize(Size)
end

local function RecipesSorted()
	return ATSW_RecipesSorted[player][Profession()]
end

local function RecipesSortedSize()
	return ATSW_RecipesSortedSize[player][Profession()] or 0
end

local function SetRecipesSortedSize(Value)
	if Profession() then
		ATSW_RecipesSortedSize[player][Profession()] = Value
	end
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
	SetRecipesSortedSize(Size)
end

--Wrap functions with smaller names for easy access from code

local function NeedToUpdate()
	return ATSW_NeedToUpdate[player][Profession()]
end

local function SetNeedToUpdate(Prof, Value)
	if Value == nil then Value = true end
	
	if Prof then
		ATSW_NeedToUpdate[player][Prof] = Value
	else
		for I, V in pairs(ATSW_NeedToUpdate[player]) do
			ATSW_NeedToUpdate[player][I] = Value
		end
	end
end

local function PreviousRecipes(Prof)
	if Prof == nil then Prof = Profession() end
	
	return ATSW_PreviousRecipes[player][Prof]
end

local function PreviousRecipesSize(Prof)
	if Prof == nil then Prof = Profession() end
	if Prof == nil then return 0 end
	
	return table.getn(PreviousRecipes(Prof))
end

local function PreviousRecipe(I)
	return PreviousRecipes()[I]
end

local function SortBy()
	return ATSW_SortBy[player][Profession()]
end

local function SearchString()
	return ATSW_SearchString[player][Profession()]
end

local function SetSearchString(Text)
	ATSW_SearchString[player][Profession()] = Text
end

local function ScrollOffset()
	return ATSW_ScrollOffset[player][Profession()]
end

local function Contracted()
	return ATSW_ContractedCategories[player][Profession()][SortBy()]
end

function ATSW_Contracted()
	return Contracted()
end

local function SubClass()
	return ATSW_SubClassFilter[player][Profession()]
end

local function InvSlot()
	return ATSW_InvSlotFilter[player][Profession()]
end

local function SetSubClass(Value)
	if not Profession() then return end
	
	ATSW_SubClassFilter[player][Profession()] = Value
end

local function SetInvSlot(Value)
	if not Profession() then return end
	
	ATSW_InvSlotFilter[player][Profession()] = Value
end

local function TasksSize(Prof)
	if Prof == nil then Prof = Profession() end
	
	if ATSW_Tasks[player][Prof] then
		return table.getn(ATSW_Tasks[player][Prof])
	else
		return 0
	end
end

local function Tasks(Prof)
	if Prof == nil then Prof = Profession() end
	
	return ATSW_Tasks[player][Prof]
end

local function Task(I, Prof)
	if Prof == nil then Prof = Profession() end
	
	return ATSW_Tasks[player][Prof][I]
end
	
local function DoTaskExist(Name, Prof)
	if Prof == nil then Prof = Profession() end
	
	for I = 1, TasksSize(Prof) do
		if Task(I, Prof).Name == Name then
			return I
		end
	end
	
	return false
end

local function NoTasks()
	if ATSW_Tasks == nil or ATSW_Tasks[player] == nil then return true end
	
	local TotalAmount = 0
	
	for I, V in pairs(ATSW_Tasks[player]) do
		TotalAmount = TotalAmount + table.getn(ATSW_Tasks[player][I])
	end
	
	return TotalAmount == 0
end

local function NecessaryReagents()
	return ATSW_NecessaryReagents[player]
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

--Sound (Open/Close) management functions and last cast spell acquiring
Original_PlaySound = PlaySound

local Original_CastSpellByName = CastSpellByName
local function MyCastSpellByName(Name, OnSelf)
	local function Stub() end
	local Storage = PlaySound
	
	LastCastName = Name
	
	PlaySound = Stub	
	Original_CastSpellByName(Name, OnSelf)
	PlaySound = Storage
end
CastSpellByName = MyCastSpellByName

local Original_CastSpell = CastSpell
local function MyCastSpell(spellID, spellbookType)
	local function Stub() end
	local Storage = PlaySound
	
	LastCastName = GetSpellName(spellID, spellbookType)
	
	PlaySound = Stub
	Original_CastSpell(spellID, spellbookType)
	PlaySound = Storage
end
CastSpell = MyCastSpell

local Original_UseAction = UseAction
local function MyUseAction(Slot, CheckCursor, OnSelf)
	local function GetNameFromTooltip(Slot)
		ATSWActionNameTooltip:SetParent(UIParent)
		ATSWActionNameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		ATSWActionNameTooltip:SetAction(Slot)
		
		return ATSWActionNameTooltipTextLeft1:GetText()
	end
	
	local function Stub() end
	local Storage = PlaySound
	
	LastCastName = GetNameFromTooltip(Slot)
	
	PlaySound = Stub
	Original_UseAction(Slot, CheckCursor, OnSelf)
	PlaySound = Storage
end
UseAction = MyUseAction

--Craft delay detection functions
local Original_PickupContainerItem = PickupContainerItem
local function MyPickupContainerItem(Bag, Slot)
	ProcessingDelay = GetTime()
	Original_PickupContainerItem(Bag, Slot)
end
PickupContainerItem = MyPickupContainerItem

local Original_BindEnchant = BindEnchant
local function MyBindEnchant()
	ProcessingDelay = GetTime()
	Original_BindEnchant()
end
BindEnchant = MyBindEnchant

local Original_ReplaceEnchant = ReplaceEnchant
local function MyReplaceEnchant()
	ProcessingDelay = GetTime()
	Original_ReplaceEnchant()
end
ReplaceEnchant = MyReplaceEnchant

local Original_ReplaceTradeEnchant = ReplaceTradeEnchant
local function MyReplaceTradeEnchant()
	ProcessingDelay = GetTime()
	Original_ReplaceTradeEnchant()
end
ReplaceTradeEnchant = MyReplaceTradeEnchant

--Utility functions

local function SetVisible(Frame, State)
	if not Frame then return end
	
	if State then
		Frame:Show()
	else
		Frame:Hide()
	end
end

local function SetEnabled(Frame, State)
	if not Frame then return end
	
	if State then
		Frame:Enable()
	else
		Frame:Disable()
	end
end

local function FormatTime(Seconds, FourDigits)
	local Time
	
	if not tonumber(Seconds) then
		return Time
	end
	
  local D, H, M, S = ChatFrame_TimeBreakDown(Seconds)
  
	if D > 0 then
		Time =  string.format("%d days %d hours", D,H)
	elseif H > 0 then
		Time = string.format("%d hours %d minutes", H,M)
	else
		if FourDigits then
			Time = string.format( "%02d:%02d", M, S)
		else
			if M > 0 then
				Time = string.format("%d:%02d", M, S)
			elseif S > 0 then
				Time = string.format("%d", S)
			end
		end
	end
	
	if Time == 0 then
		Time = Time .. " seconds"
	end
	
	return Time
end

local function FormatCooldown(Cooldown)
	local Time
	
	if Cooldown then
		Time = math.floor(Cooldown)
		
		if Time > 0 then
			Time = SecondsToTime(Time, false)
			Time = string.gsub(Time, "Day", "day")
			Time = string.gsub(Time, "Hr", "hour")
			Time = string.gsub(Time, "Min", "minute")
			Time = string.gsub(Time, "Sec", "second")
		end
	end
	
	if Time == 0 then
		Time = Time .. " seconds"
	end
	
	return Time
end

local function ShortFormatCooldown(Cooldown, FourDigits)
	if Cooldown then
		local Time = Cooldown
		
		if Time >= 0 then
			Time = FormatTime(Time, FourDigits)
			
			return Time
		end
	end
	
	return nil
end

local function ConvertCooldown(Cooldown, Long)
	local S
	
	if Cooldown then
		S = Cooldown - GetTime()
	end
	
	if S and S >= 0 then
		if Long then
			S = FormatCooldown(S)
		else
			S = " |cffE00000(" .. ShortFormatCooldown(S) .. ")|r"
		end
	else
		S = nil
	end
	
	return S
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

local function LinkToID(Link)
    if Link then
        local _, _, ID = string.find(Link, "^.*|Hitem:(%d*):.*%[.*%].*$")
		
        return ID
    else
        return nil
    end
end

local function LinkToName(Link)
	if Link then
		return string.gsub(Link,"^.*%[(.*)%].*$","%1")
	else
		return nil
	end
end

local function LinkToColor(Link)
    if Link then
        local _, _, Color = string.find(Link, "^.*|cff(.-)|.*$")
		
        return Color
    else
        return nil
    end
end

local function GetLinkColorRGB(Link)
    if Link then
        local Color = HexToDec(LinkToColor(Link))
        local R	= math.floor(Color / 65536)
        local G	= math.floor((Color - R * 65536) / 256)
        local B	= math.floor((Color - R * 65536 - G * 256))
		
        return R / 255, G / 255, B / 255
    else
        return nil, nil, nil
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

local function GetItemQuality(ID, Reagent)
    ATSWScanTooltip:SetOwner(ATSWFrame, "ANCHOR_TOPLEFT")
	
	local localID = tonumber(ID, 10)
	
	if ATSW_TradeSkill() then
		ATSWScanTooltip:SetTradeSkillItem(localID)
	else
		if Reagent then
			ATSWScanTooltip:SetCraftItem(localID)
		else
			ATSWScanTooltip:SetCraftSpell(localID)
		end
	end
	
    local TextLeft = getglobal("ATSWScanTooltipTextLeft1")
	local Q = 0
	
    if TextLeft then
        local R, G, B = TextLeft:GetTextColor()
		
		Q = ColorToQuality(R, G, B)
    end
	
    ATSWScanTooltip:Hide()
	
    return Q
end

local function GetItemMinLevel(ID, Reagent)
    ATSWScanTooltip:SetOwner(ATSWFrame, "ANCHOR_TOPLEFT")
	
    local localID = tonumber(ID, 10)
	
	if ATSW_TradeSkill() then
		ATSWScanTooltip:SetTradeSkillItem(localID)
	else
		if Reagent then
			ATSWScanTooltip:SetCraftItem(localID)
		else
			ATSWScanTooltip:SetCraftSpell(localID)
		end
	end
	
    local NumLines = ATSWScanTooltip:NumLines()
	
    for K = 1, NumLines do
        local TextLeft = getglobal("ATSWScanTooltipTextLeft" .. K)
		
        if TextLeft then
            local Text = TextLeft:GetText()
			
            if Text then
                local _, _, level = string.find(Text, string.gsub(ITEM_MIN_LEVEL, "%%d", "%(%%d+%)"))
				
                if level then
                    ATSWScanTooltip:Hide()
					
                    return tonumber(level, 10)
                end
            end
        end
    end
	
    ATSWScanTooltip:Hide()
	
    return 0
end

local function RemoveEscapeCharacters(String)
	local Result = tostring(String)
	
	Result = gsub(Result, "|c........", ""			) 	-- Remove color start.
	Result = gsub(Result, "|r", ""					) 	-- Remove color end.
	Result = gsub(Result, "|H.-|h(.-)|h", "%1"	) 	-- Remove links.
	Result = gsub(Result, "|T.-|t", ""				) 	-- Remove textures.
	Result = gsub(Result, "{.-}", ""				) 	-- Remove raid target icons.
	
	return Result
end

local function GetCategoryTexture(Expanded)
	return "Interface\\Buttons\\UI-" .. (Expanded and "Min" or "Pl") .. "usButton-Up"
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
	return SubName and SubName ~= "" and ("     |cff606060(" .. SubName .. ")|r") or ""
end

function ATSW_SubNameToString(SubName)
	return SubNameToString(SubName)
end

local function SubNameToName(Name)
	if not Name then return nil, nil end
	
	local LName = Name
	local _, _, SubName = string.find(Name, "%s%s%s%(+(.+)%)+")
	
	--Triple space means SubName is in Name
	local TripleSpace = string.find(Name, "%s%s%s")
	
	if TripleSpace then
		LName = string.sub(Name, 1, TripleSpace - 1)
	end
	
	return LName, SubName
end

local function RecipePosition(Name, List, ListSize)
	if not (Name and ListSize > 0) then return nil end
	
	local LName, SubName = SubNameToName(Name)
	
	if SubName == "" then SubName = nil end
	
    for I = 1, ListSize do
		R = List[I]
		
        if R.Name == LName and (SubName and R.SubName == SubName or SubName == nil) then
            return R.Position
        end
    end
	
    return nil
end

local function GetRecipePosition(Name, Prof)
	if Prof == nil then Prof = Profession() end
	
	return RecipePosition(Name, Recipes(Prof), RecipesSize(Prof))
end

local function GetRecipeSortedPosition(Name)
	return RecipePosition(Name, RecipesSorted(), RecipesSortedSize())
end

function GetPositionFromGame(Name)
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
	
    return false
end

function ATSW_IsContracted(Name)
	return ATSW_GetContractedPos(Name)
end

local function IsExpanded(Name)
	return not ATSW_IsContracted(Name)
end

local function GetProfessionTexture(Name)
	local I = 0
	local SName
	
	repeat
		I = I + 1
		
		SName = GetSpellName(I, BOOKTYPE_SPELL)
		
		if SName and string.find(SName, Name) then
			return GetSpellTexture(I, BOOKTYPE_SPELL)
		end
	until not SName
	
	return nil
end

function ATSW_GetProfessionTexture(Name)
	return GetProfessionTexture(Name)
end

local function IsEnchant(Index)
	if not Index then return false end
	
	local T
	
	if type(Index) == "string" then
		T = Index
	else
		T = GetCraftTexture(Index)
	end
	
	return T == "Interface\\Icons\\Spell_Holy_GreaterHeal"
end

local function IsBeastTraining()
	return GetProfessionTexture(GetCraftCaption()) == "Interface\\Icons\\Ability_Hunter_BeastCall02"
end

local function IsPoisons()
	return GetProfessionTexture(GetCraftCaption()) == "Interface\\Icons\\Trade_BrewPoison"
end

local function ClassColorize(Name)
	for I, V in ipairs(ATSW_Characters[realm]) do
		if ATSW_Characters[realm][I].Name == Name then
			return ClassColors[ATSW_Characters[realm][I].Class] .. Name .. "|r"
		end
	end
	
	return Name
end

local function GetLatency()
	local _,_,lag = GetNetStats()
	return lag / 1000
end

-- Main code section

function ATSW_CreateListButtons()
	--Create recipe buttons
	for R = 1, ATSW_RECIPES_DISPLAYED do
		local B = CreateFrame("Button", "ATSWRecipe" .. R, ATSWFrame, "ATSWRecipeButtonTemplate")
		
		B.XOffset 	= 22
		B.Position	= nil
		B.Name 	= nil
		B.Type 		= nil
		B.Possible 	= nil
		B.Text		= nil
		
		if R == 1 then
			B:SetPoint	("TOP", ATSWFrame, "TOP", 0, -77)
		else
			B:SetPoint	("TOP", "ATSWRecipe" .. R - 1, "BOTTOM", 0, 0)
		end
		
		B:SetWidth	(ATSWListScrollFrame:GetWidth())
		B:SetHeight	(ATSW_TRADESKILL_HEIGHT)
		
		B:SetPoint		("LEFT", ATSWFrame, "LEFT", B.XOffset, 0)
	end
	
	--Set highlight frame
	ATSWHighlight:SetHeight(ATSW_TRADESKILL_HEIGHT)
	
	--Create tool buttons
	for T = 1, ATSW_TOOLS_DISPLAYED do
		local B = CreateFrame("Button", "ATSWTool" .. T, ATSWFrame, "ATSWToolTemplate")
		
		if T == 1 then
			B:SetPoint	("LEFT", ATSWToolsLabel, "RIGHT", 4, 0)
		else
			B:SetPoint	("LEFT", "ATSWTool" .. T - 1, "RIGHT", 6, 0)
		end
	end
	
	--Create reagent buttons
	local Columns = 4
	local Row, Column
	
	for R = 1, MAX_TRADE_SKILL_REAGENTS do
		local B 	= CreateFrame("Button", "ATSWReagent" .. R, ATSWFrame, "ATSWReagentTemplate")
		
		Row 		= math.ceil(R/Columns)
		Column 	= R - ((Row - 1) * Columns)
		
		if Column == 1 then
			if Row == 1 then
				B:SetPoint("TOPLEFT", ATSWReagentsLabel, "BOTTOMLEFT", 11, -6)
			else
				B:SetPoint("TOPLEFT", "ATSWReagent" .. 1 + (Columns * (math.max(Row - 2, 0))) , "BOTTOMLEFT", 0, -30)
			end
		else
			B:SetPoint	("LEFT", "ATSWReagent" .. R - 1, "RIGHT", 55, 0)
		end
		
		B:SetID			(R)
	end
	
	--Create task buttons
	for T = 1, ATSW_TASKS_DISPLAYED do
		local B 	= CreateFrame("Button", "ATSWTask" .. T, ATSWFrame, "ATSWTaskButtonTemplate")
		
		if T == 1 then
			B:SetPoint	("TOPLEFT", ATSWHorizontalBar1Left, "TOPLEFT", 6, -14)
		else
			B:SetPoint	("TOPLEFT", "ATSWTask" .. T - 1, "BOTTOMLEFT", 0, -5)
		end
		
		B:SetWidth	(314)
		B:SetHeight	(ATSW_TRADESKILL_HEIGHT)
		
		local D = CreateFrame("Button", "ATSWTask" .. T .. "DeleteButton", B, "UIPanelCloseButton")
		
		D:SetWidth	(18)
		D:SetHeight	(18)
		D:SetPoint		("RIGHT", ATSWTaskScrollFrame, "RIGHT", -3, 0)
		D:SetPoint		("TOP", B, "TOP", 0, 1)
		D:SetScript	("OnClick", ATSW_TaskDeleteOnClick)
	end
	
	--Create search help strings
	local StringsAmount 	= 0
	local Frame 				= ATSWSearchHelpFrame
	
	local function AddHelpItem(Parameter, Description, NoReplace)
		local function SetSizeAndPoints(S, Width, Point, RelativePoint, RelativeTo, X, Y)
			S:SetJustifyH("LEFT")
			S:SetJustifyV("TOP")
			S:SetWidth(Width)
			S:SetPoint(Point, RelativePoint, RelativeTo, X, Y)
		end
		local C = StringsAmount
		
		if not Parameter 	then Parameter 	= "" end
		if not Description 	then Description	= "" end
		
		if not NoReplace then
			Parameter 	= string.gsub(Parameter, "|c", "|cffFFD100")
			Description = string.gsub(Description, "|c", "|cffFFD100")
		end
		
		local S = Frame:CreateFontString("ATSWHelp" .. C + 1, "ARTWORK", "GameFontHighlightSmall")
		
		if C == 0 then
			SetSizeAndPoints(S, 120, "TOPLEFT", ATSWSearchHelpFrame, "TOPLEFT", 20, -50)
		else
			SetSizeAndPoints(S, 120, "TOPLEFT", "ATSWHelp" .. C, "BOTTOMLEFT", 0, -15)
		end
		
		S:SetText(Parameter)
		
		local D = Frame:CreateFontString("ATSWHelp" .. C + 1 .. "Description", "ARTWORK", "GameFontHighlightSmall")
		
		SetSizeAndPoints(D, 265, "TOPLEFT", S, "TOPRIGHT")
		
		D:SetText(Description)
		
		StringsAmount = C + 1
	end
	
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

function ATSW_OnLoad()
	LoadAddOn("Blizzard_TradeSkillUI")
	LoadAddOn("Blizzard_CraftUI")
	
	--Unregister events from Blizzard professions frames
	TradeSkillFrame:	UnregisterEvent(	"SKILL_LINES_CHANGED"				)
	TradeSkillFrame:	UnregisterEvent(	"PLAYER_ENTERING_WORLD"		)
	TradeSkillFrame:	UnregisterEvent(	"TRADE_SKILL_UPDATE"				)
	TradeSkillFrame:	UnregisterEvent(	"UNIT_PORTRAIT_UPDATE"			)
	
	CraftFrame:		UnregisterEvent(	"SKILL_LINES_CHANGED"				)
	CraftFrame:		UnregisterEvent(	"CRAFT_UPDATE"						)
	CraftFrame:		UnregisterEvent(	"UNIT_PORTRAIT_UPDATE"			)
	CraftFrame:		UnregisterEvent(	"SPELLS_CHANGED"					)
	CraftFrame:		UnregisterEvent(	"UNIT_PET_TRAINING_POINTS"	)
	
	--Replace Blizzard professions' Show/Hide functions
	TradeSkillFrame_Show 	= ATSW_TradeSkill_Show
	CraftFrame_Show 			= ATSW_Craft_Show
	TradeSkillFrame_Hide 		= ATSW_Hide
	CraftFrame_Hide 			= ATSW_Hide
	
	--Register slash commands
    SLASH_ATSW1 				= "/atsw"
    SLASH_ATSW2 				= "/advancedtradeskillwindow"
    SlashCmdList["ATSW"] 	= ATSW_Command
	
	--Register events
    ATSWFrame:		RegisterEvent(	"UNIT_PET"									)
    ATSWFrame:		RegisterEvent(	"UNIT_PET_TRAINING_POINTS"		)
    ATSWFrame:		RegisterEvent(	"BAG_UPDATE"								)
    ATSWFrame:		RegisterEvent(	"BANKFRAME_OPENED"					)
    ATSWFrame:		RegisterEvent(	"BANKFRAME_CLOSED"					)
    ATSWFrame:		RegisterEvent(	"MERCHANT_SHOW"						)
    ATSWFrame:		RegisterEvent(	"MERCHANT_UPDATE"						)
    ATSWFrame:		RegisterEvent(	"MERCHANT_CLOSED"						)
    ATSWFrame:		RegisterEvent(	"AUCTION_HOUSE_CLOSED"			)
    ATSWFrame:		RegisterEvent(	"AUCTION_HOUSE_SHOW"				)
    ATSWFrame:		RegisterEvent(	"PLAYERBANKSLOTS_CHANGED"		)
    ATSWFrame:		RegisterEvent(	"PLAYERBANKBAGSLOTS_CHANGED"	)
    ATSWFrame:		RegisterEvent(	"PLAYER_ENTERING_WORLD"			)
    ATSWFrame:		RegisterEvent(	"CHAT_MSG_SYSTEM"						)
    ATSWFrame:		RegisterEvent(	"CHAT_MSG_SKILL"							)
    ATSWFrame:		RegisterEvent(	"CHAT_MSG_LOOT"						)
    ATSWFrame:		RegisterEvent(	"CVAR_UPDATE"								)
	
	--Attach name sort checkbox
	ATSWNameSortCheckbox:SetPoint("LEFT", ATSWDifficultySortCheckbox, "RIGHT", ATSWDifficultySortCheckboxText:GetWidth()+5, 0)
	
	--Create side tabs
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local CB = CreateFrame("CheckButton", "ATSWFrameTab" .. T, ATSWFrameSideTabsFrame, "ATSWTabTemplate")
		
		if T == 1 then
			CB:SetPoint("TOPLEFT", ATSWFrameSideTabsFrame, "TOPRIGHT", 0, -36)
		else
			CB:SetPoint("TOPLEFT", "ATSWFrameTab" .. T - 1, "BOTTOMLEFT", 0, -17)
		end
	end
	
	--Fix Blizzard GameTooltip edges insets (from 5 to 4)
	local R, G, B, A = GameTooltip:GetBackdropColor()
	
	GameTooltip:SetBackdrop({bgFile=[[Interface\Tooltips\UI-Tooltip-Background]], edgeFile=[[Interface\Tooltips\UI-Tooltip-Border]], tile = true, edgeSize = 16, tileSize = 16, insets = {left = 4, right = 4, top = 4, bottom = 4}})
	GameTooltip:SetBackdropColor(R, G, B, A)
end

local function InitializeOnShow()
	if InitializedOnShow then return end
	
	ATSW_CreateListButtons()
	
	for I = 1, ATSW_TASKS_DISPLAYED do
		getglobal("ATSWTask" .. I .. "DeleteButton"):GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
		getglobal("ATSWTask" .. I .. "DeleteButton"):GetPushedTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
	end
	
	for I = 1, 20 do
		getglobal("ATSWRecipeTooltipTextureLeft" .. 3+I):SetTexCoord(0.08, 0.92, 0.08, 0.92)
	end
	
	ATSW_ConfigureSkillButtons()
	
	table.insert(UncategorizedHeader, {Name = ATSW_UNCATEGORIZED, Type = "header"})
	
	InitializedOnShow = true
end

local function SetDropDownFilter(SubClass, InvSlot)
	ATSWFrame:UnregisterEvent(	"TRADE_SKILL_UPDATE"	)
	
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
		ATSWFrame:RegisterEvent	(	"TRADE_SKILL_UPDATE"	)
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
	if not Profession() then return end
	
    ATSW_SortBy[player][Profession()] = Sort
	ATSW_GetRecipesSorted(true)
end

local OldCraftCount = 0

function ATSW_OnUpdate(TimePassed)
    if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
		-- Update frame if trade skill count is changed
		if ATSWFrame.UpdateIsRegistered then
			if NeedToUpdate() then
				ATSW_UpdateFrame()
			end
			
			if 	UpdateCount > 0 then
				if IsBeastTraining() or IsPoisons() then
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
						
						if R.Type ~= "header" then
							if not (R.Name and R.Texture) then
								local Name 	= GetCraftNameType(I)
								local Texture	= GetCraftTexture(I)
								
								if (Name and Texture) then
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
			local function WhatReagentIsLackingData()
				for I = 1, MAX_TRADE_SKILL_REAGENTS do
					local Button 				= getglobal("ATSWReagent" .. I)
					local ButtonTexture 	= getglobal("ATSWReagent" .. I .. "Texture")
					
					if Button:IsVisible() then
						if not (ButtonTexture:GetTexture() and Button.Name and Button.Link) then
							return Button
						end
					end
				end
				
				return false
			end
			
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
		if GetTime() >= CooldownUpdateTime + 1 then
			local function SetButtonCooldown(Button)
				if not (Button:IsVisible() and Button.Position) then return end
				
				Button:SetText(Button.Text .. (ConvertCooldown(Recipe(Button.Position).Cooldown) or ""))
			end
			
			-- Set cooldowns for recipe buttons
			for I = 1, ATSW_RECIPES_DISPLAYED do
				SetButtonCooldown(getglobal("ATSWRecipe" .. I))
			end
			
			-- Set cooldowns for task buttons
			for I = 1, ATSW_TASKS_DISPLAYED do
				SetButtonCooldown(getglobal("ATSWTask" .. I))
			end
			
			-- Set cooldown for schematic
			if ATSWRecipeCooldown.Cooldown then
				local CD = ConvertCooldown(ATSWRecipeCooldown.Cooldown, true)
				
				if CD then
					ATSWRecipeCooldown:SetText(COOLDOWN_REMAINING .. " " .. CD)
				else
					ATSWRecipeCooldown.Cooldown = nil
					ATSWRecipeCooldown:SetText("")
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
	
	if ATSWProgressBar.Working then
		local Bar 			= ATSWProgressBar
		local Border 		= ATSWProgressBarBorder
		local Spark 		= ATSWProgressBarSpark
		local Stop			= ATSWProgressBarStop
		local Glow 		= ATSWProgressBarGlow
		local ItemFound
		
		for I = 1, ATSW_TASKS_DISPLAYED do
			local Button 	= getglobal("ATSWTask" .. I)
		
			if Button.Name == ProcessingRecipe then	
				ItemFound = true
				
				if not Bar.TaskItem or Bar.TaskItem ~= Button then
					Bar:		SetParent(Button)
					Bar:		SetPoint("TOPLEFT", Button:GetName(), "TOPLEFT", -2, 0)
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
				Spark:	SetPoint("CENTER", Bar, "LEFT", (1 - (Bar.EndTime - GetTime())/(Bar.EndTime - Bar.StartTime)) * Bar:GetWidth(), -1)
			else
				if IsEnchant(ProcessingTexture) then
					Bar.Mode = ATSW_FLASH
				end
			end
			
			local TimeLeft 	= Bar.EndTime - GetTime()
			local FourDigits 	= true
			
			ATSWProgressBarStopSubText:SetText(ShortFormatCooldown(TimeLeft, FourDigits))
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
end

function ATSW_ProfessionExists(Prof)
	if Prof == nil then return false end
	
	local _, _, _, NumSpells = GetSpellTabInfo(1)
	
	for I, V in ipairs(Professions) do
		local ProfessionTexture = Professions[I]
	
		for B = 1, NumSpells do
			local Texture 	= GetSpellTexture	(B, "BOOKTYPE_SPELL")
			local Name		= GetSpellName		(B, "BOOKTYPE_SPELL")
			
			if Texture and Texture == ProfessionTexture and string.find(Name, Prof) then
				return true
			end
		end
	end
	
	return false
end

local function GetFirstProfession()
	local _, _, _, NumSpells = GetSpellTabInfo(1)
	
	--Search spell book by texture
	for I, V in ipairs(Professions) do
		local ProfessionTexture = Professions[I]
		
		for B = 1, NumSpells do
			local Texture	= GetSpellTexture	(B, "BOOKTYPE_SPELL")
			
			if Texture and Texture == ProfessionTexture then
				return GetSpellName(B, "BOOKTYPE_SPELL")
			end
		end
	end
	
	return nil
end

function ATSW_ConfigureSkillButtons(Exception)
	local function ResetTabs()
		for T = 1, ATSW_MAX_TRADESKILL_TABS do
			local Tab = getglobal("ATSWFrameTab"..T)
			
			if Tab then
				Tab.Name = nil
				
				local Tex = Tab:GetNormalTexture()
				
				if Tex then
					Tex:SetTexture(nil)
				end
			end
		end
	end

	local _, _, _, NumSpells = GetSpellTabInfo(1)
	
	local function TabExists(Texture)
		for T = 1, ATSW_MAX_TRADESKILL_TABS do
			local Tab = getglobal("ATSWFrameTab"..T)
			
			if Tab then
				local Tex = Tab:GetNormalTexture()
				
				if Tex and Tex:GetTexture() == Texture then
					return true
				end
			end
		end
		
		return false
	end
	
	ResetTabs()
	
	--Scan spell book for professions
	for T = 1, ATSW_MAX_TRADESKILL_TABS do
		local Tab = getglobal("ATSWFrameTab" .. T)
		local TabName, TabTexture
		
		for I, V in ipairs(Professions) do
			local ProfessionTexture = Professions[I]
			
			if not TabExists(ProfessionTexture) then
				for B = 1, NumSpells do
					local Texture 	= GetSpellTexture	(B, "BOOKTYPE_SPELL")
					local Name		= GetSpellName		(B, "BOOKTYPE_SPELL")
					
					if Name ~= Exception and Texture and Texture == ProfessionTexture then
						TabName 		= GetSpellName(B, "BOOKTYPE_SPELL")
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
		local Tab = getglobal("ATSWFrameTab" .. T)
		
		Tab:SetChecked(Tab.Name == Name)
	end
end

function ATSW_AttachTabsTo(Frame)
	if ATSWFrameSideTabsFrame:GetParent() == Frame then return end
	
	ATSWFrameSideTabsFrame:SetParent(Frame)
	ATSWFrameSideTabsFrame:SetPoint("TOPLEFT", Frame, "TOPRIGHT", -59, -28)
	ATSWFrameSideTabsFrame:Show()
end

function ATSW_SwitchToFrame(Frame)
	local function GetFrame(F)
		if 			F == 1 then return ATSWFrame
		elseif 	F == 2 then return ATSWCSFrame end
	end
	
	if ATSW_SwitchingToMain then
		ATSW_SwitchingToMain = false
	else
		if Frame and not (GetFrame(1):IsVisible() or GetFrame(2):IsVisible()) then
			Original_PlaySound("igCharacterInfoOpen")
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
		end
	end
	
	if not Frame and Processing then
		ProcessingStop = true
	end
end

local function LoadAllProfessionsOnce()
	if LoadingProfessions then return end
	
	LoadingProfessions 			= true
	
	local CurrentProfession 	= GetCraftCaption()
	local LastName				=	CurrentProfession
	
	local _, _, _, NumSpells 	= GetSpellTabInfo(1)
	
	UIParent:	UnregisterEvent(	"TRADE_SKILL_SHOW"	)
	UIParent:	UnregisterEvent(	"TRADE_SKILL_CLOSE"	)
	UIParent:	UnregisterEvent(	"CRAFT_SHOW"				)
	UIParent:	UnregisterEvent(	"CRAFT_CLOSE"				)
	
	local function Stub() end
	local OldSound 				= PlaySound
	PlaySound 						= Stub
	
	for I, V in ipairs(Professions) do
		local ProfessionTexture = Professions[I]
		
		for B = 1, NumSpells do
			local Texture			= GetSpellTexture	(B, "BOOKTYPE_SPELL")
			local Name 			= GetSpellName		(B, "BOOKTYPE_SPELL")
			
			if Name and not string.find(Name, CurrentProfession) and Texture == ProfessionTexture then
				CastSpellByName(Name)
				LastName = Name
				
				break
			end
		end
	end
	
	PlaySound 						= OldSound
	
	if LastName ~= CurrentProfession then
		CloseTradeSkill()
		CloseCraft()
		CastSpellByName(CurrentProfession)
	end
	
	UIParent:	RegisterEvent(	"TRADE_SKILL_SHOW"	)
	UIParent:	RegisterEvent(	"TRADE_SKILL_CLOSE"	)
	UIParent:	RegisterEvent(	"CRAFT_SHOW"				)
	UIParent:	RegisterEvent(	"CRAFT_CLOSE"				)
end

local function ExecutionConnection1()
	LoadAllProfessionsOnce()
	--This function will cause all learned professions recipe data to load into the game from the server at once.
	--After the user chose another profession the recipe data is already in the game.
	
	InitializeOnShow()
	
	ATSW_UpdateCaption					()
	ATSW_SelectTab						(Profession())
	ATSW_ShowAmount					()
	ATSW_ShowAmountMenu			(TradeSkill)
	ATSW_ShowDropDownMenu		(TradeSkill)
	ATSW_ShowReagentsButton		(not IsBeastTraining())
	ATSW_ShowTaskButton				(not IsBeastTraining())
	ATSW_ShowTrainingPointsMenu	(IsBeastTraining())
	
	if RecipesSize() > 0 then
		ATSW_GetRecipes()
		ATSW_ShowSelection()
		ATSW_UpdateTasks()
		
		if SortBy() == "Custom" then
			ATSWCS_FillAllRecipes()
			ATSWCS_Update()
		end
	end
	
	if NoTasks() then ResetNecessaries() end
	
	ATSW_SwitchToFrame(ATSWFrame)
end

function ATSW_TradeSkill_Show()
	if not UIParent:IsVisible() then
		CloseTradeSkill()
		
		return
	end
	
	if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
		UIParent:	UnregisterEvent	("CRAFT_CLOSE"		)
		CloseCraft()
		UIParent:	RegisterEvent		("CRAFT_CLOSE"		)
	end
	
	TradeSkill = true
	ExecutionConnection1()
end

function ATSW_Craft_Show()
	if not UIParent:IsVisible() then
		CloseCraft()
		
		return
	end
	
	if ATSWFrame:IsVisible() or ATSWCSFrame:IsVisible() then
		UIParent:	UnregisterEvent	("TRADE_SKILL_CLOSE")
		CloseTradeSkill()
		
		if TradeSkill then
			ProcessingStop = true
		end
		
		UIParent:	RegisterEvent		("TRADE_SKILL_CLOSE")
	end
	
	TradeSkill = false
	ExecutionConnection1()
end

function ATSW_Hide()
	if not UIParent:IsVisible() then return end
	
	ATSW_SwitchToFrame()
	Original_PlaySound("igCharacterInfoClose")
end

local function InitializeTable(Table, Value, Prof)
	if Prof == nil then Prof = Profession() end
	
	if Table 					== nil 	then Table 					= {} 		end
	if Table[player] 			== nil 	then Table[player] 			= {} 		end
	if Table[player][Prof] 	== nil 	then Table[player][Prof] 	= Value 	end
end

local function InitializeTables()
	local function InitializeContractedCategories()
		local Table = ATSW_ContractedCategories
		
		InitializeTable(Table, {}, Profession())
		
		if 	Table[player][Profession()]["Category"] == nil 	then
			Table[player][Profession()]["Category"] = {}
		end
		
		if 	Table[player][Profession()]["Custom"] == nil 	then
			Table[player][Profession()]["Custom"] = {}
		end
	end
	
	InitializeTable(ATSW_Recipes, 				{}			)
	InitializeTable(ATSW_RecipesSize, 			0				)
	InitializeTable(ATSW_RecipesSorted, 		{}			)
	InitializeTable(ATSW_RecipesSortedSize, 0				)
	InitializeTable(ATSW_SelectedRecipe, 	nil			)
	InitializeTable(ATSW_NeedToUpdate, 	true			)
	InitializeTable(ATSW_SortBy, 				"Category"	)
	InitializeTable(ATSW_SearchString, 		""				)
	InitializeTable(ATSW_SubClassFilter, 		0				)
	InitializeTable(ATSW_InvSlotFilter, 		0				)
	InitializeTable(ATSW_ScrollOffset, 			0				)
	InitializeTable(ATSW_Amount, 				0				)
	InitializeTable(ATSW_PreviousRecipes, 	{}			)
	InitializeTable(ATSW_Tasks, 					{}			)
	InitializeTable(ATSW_CustomCategories, {}			)
	InitializeTable(ATSW_CSOpenCategory, 	0				)
	
	InitializeContractedCategories()
end

local function GetProfession()
	local function InitializeProfession()
		local Table = ATSW_Profession
		
		if not Table 				then Table = {} 			end
		if not Table[player] 	then Table[player] = nil 	end
	end
	
	InitializeProfession()

	local Skill = GetCraftCaption()
	
	if Skill and Skill ~= "UNKNOWN" then
		ATSW_Profession[player] = Skill
	end
	
	return Skill
end

function ATSW_UpdateStatusBarRank()
	local _, Rank, MaxRank 	= GetCraftCaption()
	
	SetVisible(ATSWRankFrame, 		Rank > 0)
	SetVisible(ATSWRankFrameRank, 	MaxRank > 0)
	
	if ATSWRankFrame:IsVisible() then
		ATSWRankFrame:			SetMinMaxValues(0, MaxRank)
		ATSWRankFrame:			SetValue(Rank)
	end
	
	if ATSWRankFrameRank:IsVisible() then
		ATSWRankFrameRank:		SetText(Rank .. "/" .. MaxRank)
	end
end

local function InitializeFrame()
	local SameProfession = GetCraftCaption() == Profession()
	
	if not SameProfession or RecipesSize() == 0 then
		GetProfession					()
		InitializeTables					()
		ATSW_ShowDropDown	()
		ATSW_HideRecipes			()
		ATSW_HideRecipe			()
		ATSW_HideTasks			()
		ATSWCreateButton:		Disable()
	end
end

function ATSW_UpdateCaption()
	InitializeFrame()
	
	local Name = GetCraftCaption()
	
	-- Set status bar info
	ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), Name))
	ATSW_UpdateStatusBarRank()
	
	--Set skill portrait
	SetPortraitToTexture(ATSWFramePortrait, GetProfessionTexture(Name))
	
	ATSW_ShowSort		()
	ATSW_ShowSearch	()
end

function ATSW_UpdateFrame()
	InitializeFrame()
	ATSW_GetRecipes(true)
	ATSW_ShowSelection()
	
	if NoDropDownUpdate then
		NoDropDownUpdate = false
	else
		ATSW_ShowDropDown()
	end
	
	if SortBy() == "Custom" then
		ATSWCS_FillAllRecipes()
		ATSWCS_Update()
	end
	
	SetNeedToUpdate(Profession(), false)
	
	if not ATSWFrame.UpdateIsRegistered and RecipesSize() > 0 and RecipesSize() == GetCraftCount()  then
		ATSWFrame:RegisterEvent(	"TRADE_SKILL_UPDATE"				)
		ATSWFrame:RegisterEvent(	"CRAFT_UPDATE"						)
		ATSWFrame.UpdateIsRegistered = true
	end
	
	ATSW_UpdateTasks()
	ATSW_ShowTrainingPoints()
end

function ATSW_OnEvent()
	if ATSW_Debug then
		local s = ""
		
		if arg1 	then s = s .. " (|cffB0B0B0arg1|r = "  .. 	"|cffFFD100" .. arg1 .. "|r" 	end
		if arg2 	then s = s .. ", |cffB0B0B0arg2|r = "  ..	"|cffFFD100" .. arg2 .. "|r" 	end
		if arg3 	then s = s .. ", |cffB0B0B0arg3|r = "  ..	"|cffFFD100" .. arg3 .. "|r" 	end
		if arg4 	then s = s .. ", |cffB0B0B0arg4|r = "  ..	"|cffFFD100" .. arg4 .. "|r" 	end
		if arg5 	then s = s .. ", |cffB0B0B0arg5|r = "  ..	"|cffFFD100" .. arg5 .. "|r" 	end
		if arg6 	then s = s .. ", |cffB0B0B0arg6|r = "  ..	"|cffFFD100" .. arg6 .. "|r" 	end
		if arg7 	then s = s .. ", |cffB0B0B0arg7|r = "  ..	"|cffFFD100" .. arg7 .. "|r" 	end
		if arg8 	then s = s .. ", |cffB0B0B0arg8|r = "  ..	"|cffFFD100" .. arg8 .. "|r" 	end
		if arg9 	then s = s .. ", |cffB0B0B0arg9|r = "  ..	"|cffFFD100" .. arg9 .. "|r" 	end
		if arg10	then s = s .. ", |cffB0B0B0arg10|r = " ..	"|cffFFD100" .. arg10 .. "|r" 	end
		
		if s ~= "" then s = s .. ")" end
		
		ChatFrame1:AddMessage("ATSW Debug: |cffB0B0B0event|r = " .. "|cffFFD100" .. tostring(event) .. "|r" .. s)
	end
	
    if 			event == "UNIT_PET"									then
	
		ATSW_ShowTrainingPoints()
		
    elseif 	event == "UNIT_PET_TRAINING_POINTS" 		then
	
		ATSW_ShowTrainingPoints()
	
    elseif 	event == "BANKFRAME_OPENED"
    or 		event == "PLAYERBANKSLOTS_CHANGED"
    or 		event == "PLAYERBANKBAGSLOTS_CHANGED" 	then
		
		BankFrameOpened = true
        ATSW_SaveBank()
	
    elseif 	event == "BANKFRAME_CLOSED" 					then
	
		BankFrameOpened = false
	
    elseif 	event == "MERCHANT_SHOW" 						then
		
        ATSW_UpdateMerchant()
        
		if ATSW_AutoBuy then
			ATSW_BuyFromMerchant()
		else
			ATSW_SetBuyFrameVisible()
		end
	
    elseif 	event == "MERCHANT_CLOSED" 						then
	
		ATSWBuyNecessaryFrame:Hide()
	
    elseif 	event == "MERCHANT_UPDATE" 						then
	
		ATSW_UpdateMerchant()
	
    elseif 	event == "AUCTION_HOUSE_SHOW" 				then
	
        ATSW_ShowAuctionShoppingList()
	
    elseif 	event == "AUCTION_HOUSE_CLOSED" 			then
	
        ATSWShoppingListFrame:Hide()
	
    elseif 	event == "BAG_UPDATE" 								then
		ATSW_SaveBank()
		ATSW_SaveBag(arg1)
		
		if ATSWFrame:IsVisible() then
			--Check if a selected tool is update
			for Slot = 1, GetContainerNumSlots(arg1) do
				local function ToolIsUpdating(BID)
					for I = 1, ATSW_TOOLS_DISPLAYED do
						local Button = getglobal("ATSWTool" .. I)
						
						if Button:IsVisible() then
							local ToolID = ToolID[Button.Name]
						
							if BID == ToolID then
								return true
							end
						end
					end
					
					return false
				end
				
				local BID = LinkToID(GetContainerItemLink(arg1, Slot))
				
				if ToolIsUpdating(BID) then
					ATSW_SelectRecipe(RecipeSelected())
				end
			end
		end
		
		--Update all frame sections
		
		if ATSWFrame:					IsVisible() 	then 	ATSW_UpdateRecipes					()
																			ATSW_UpdateTasks					()
																			
		if RecipeSelected()								then 	ATSW_SelectRecipe(RecipeSelected()) 	end end
		
		ATSW_UpdateNecessaryReagents()
		if MerchantFrame:				IsVisible() 	then 	ATSW_SetBuyFrameVisible			() 	end
		if ATSWShoppingListFrame:	IsVisible() 	then 	ATSW_UpdateAuctionList			() 	end
		
    elseif 	event == "TRADE_SKILL_UPDATE"
	or 		event == "CRAFT_UPDATE" 							then
		
		UpdateCount = UpdateCount + 1
	
	
    elseif 	event == "SPELLCAST_START"  						then
		
		if arg1 == ProcessingRecipe and not Processing then
			ProcessingRecipeTime = arg2 / 1000
			
			local CastTime = ProcessingRecipeTime + GetLatency()
			
			if TradeSkill then
				CastTime = CastTime * ProcessingAmount
			end
			
			ATSW_InitializeProgressBar(ProcessingDelay, (ProcessingDelay + CastTime))
			ProcessingDelay = GetTime() - ProcessingDelay
			ATSW_StartProcessing()
		end
		
	elseif	event == "SPELLCAST_INTERRUPTED"				then
		
		ATSW_StopProcessing()
		
	elseif 	event == "PLAYER_ENTERING_WORLD" 			then
		
		ATSW_SaveBag(0)
		
		local function InitializeTable(Table, Value, Prof)
			if Table == nil then
				Table = {}
			end
			
			if Table[player] == nil then
				Table[player] = Value
			end
		end
		
		InitializeTable(ATSW_NecessaryReagents, {})
		
		if ATSW_Characters and ATSW_Characters[realm] then
			for I, V in ipairs(ATSW_Characters[realm]) do
				if ATSW_Characters[realm][I].Name == player then
					return
				end
			end
		end
		
		table.insert(ATSW_Characters[realm], {
			Name 	= player,
			Class		= class
		})
	
	elseif 	event == "CHAT_MSG_SYSTEM" 						then
	
		if string.find(arg1, ERR_LEARN_RECIPE_PATTERN)
		or string.find(arg1, ERR_LEARN_SPELL_PATTERN) then 				-- Learn new recipe
			SetNeedToUpdate()
		end
		
		if string.find(arg1, ERR_UNLEARN_RECIPE_PATTERN) then 			-- Unlearn profession
			local _, _, Skill = string.find(arg1, ERR_UNLEARN_RECIPE_PATTERN)
			
			if ATSW_ProfessionExists(Skill) then
				--Reset previous recipes
				for I = 1, PreviousRecipesSize(Skill) do
					table.remove(PreviousRecipes(Skill), PreviousRecipesSize(Skill)-1+I)
				end
				
				ATSW_ConfigureSkillButtons(Skill) -- Reconfigure tabs except Skill
				
				--Reset tasks
				for I = 1, TasksSize(Skill) do
					ATSW_DeleteTask(Task(I, Skill).Name, nil, Skill)
				end
				
				-- Reset necessary settings
				ATSW_SelectedRecipe	[player][Skill]	= nil
				ATSW_RecipesSize			[player][Skill]	= 0
				ATSW_RecipesSortedSize	[player][Skill]	= 0
				ATSW_SubClassFilter		[player][Skill]	= 0
				ATSW_InvSlotFilter			[player][Skill]	= 0
				ATSW_SelectedRecipe	[player][Skill]	= nil
				ATSW_ScrollOffset			[player][Skill]	= 0
				
				if Skill == Profession() then
					ATSW_Profession		[player]			= nil
					
					ATSW_SwitchToFrame() -- Hide frame if Skill is selected
				end
			end
		end
	elseif 	event == "CHAT_MSG_LOOT" 						then
		
		-- Task completion
		if Processing then
			if string.find(arg1, LOOT_ITEM_CREATED_SELF_PATTERN) then -- React on "You create: %s" pattern
				Bar = ATSWProgressBar
				
				if ProcessingAmount > 1 then
					ATSW_CompleteTask()
				else
					if ProcessingStop then
						ATSW_CompleteTask() -- Complete immediately
					else
						Bar.Mode = ATSW_FLASH -- Start flash animation
					end
				end
				
				RecipesRemaining = ProcessingAmount - ProcessingComplete
				
				TimePassed 	= GetTime() - Bar.StartTime
				ERT 				= (ProcessingRecipeTime + GetLatency()) * RecipesRemaining -- Estimated remaining time
				
				Bar.EndTime = GetTime() + TimePassed + ERT
				
				Bar:SetMinMaxValues(Bar.StartTime, Bar.EndTime)
			end
		end
	
	elseif 	event == "CHAT_MSG_SKILL" 							then
	
		if string.find(arg1, ERR_SKILL_UP_PATTERN) then						-- Increase profession rank
			local _, _, Skill = string.find(arg1, ERR_SKILL_UP_PATTERN)
			
			NoDropDownUpdate = true
			
			if ATSW_ProfessionExists(Skill) then
				SetNeedToUpdate(Skill)
			else
				SetNeedToUpdate()
			end
			
			ATSW_UpdateStatusBarRank()
		elseif string.find(arg1, ERR_SKILL_GAINED_PATTERN) then 			-- Learn new profession
			ATSW_ConfigureSkillButtons()
		end
	elseif 	event == "CVAR_UPDATE" 								then
		if arg1 		== "USE_UISCALE" 		then
			ATSWRecipeTooltip:SetScale(GetCVar("uiscale"))
		elseif arg1	== "WINDOWED_MODE"	then
			-- Fix for ButtonPanel texture becomes white if toggling windowed mode
			ATSWButtonPanel:SetTexture(nil)
			ATSWButtonPanel:SetTexture("Interface\\AddOns\\AdvancedTradeSkillWindow\\Textures\\ButtonPanel")
			ATSWProgressBarGlow:SetTexture(nil)
			ATSWProgressBarGlow:SetTexture("Interface\\AddOns\\AdvancedTradeSkillWindow\\Textures\\ProgressBarFlash")
		end
    end
end

--Control

local function SetSortCheckboxes(Sort)
	ATSWCategorySortCheckbox:	SetChecked(	Sort == "Category"	)
	ATSWDifficultySortCheckbox:	SetChecked(	Sort == "Difficulty"		)
	ATSWNameSortCheckbox:		SetChecked(	Sort == "Name"			)
	ATSWCustomSortCheckbox:		SetChecked(	Sort == "Custom"		)
	SetVisible(ATSWCustomEditorButton, Sort == "Custom")
end

function ATSW_SortCheckbox_OnClick()
	SetSortBy(this.Sort)
	
	if this:GetChecked() then
		PlaySound("igMainMenuOptionCheckBoxOn")
	end
	
	SetSortCheckboxes(this.Sort)
end

function ATSWSubClassDropDownButton_OnClick()
	local Value = this:GetID() - 1
	
	if Value == SubClass() then return end
	
	SetSubClass(Value)
	UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, Value + 1)
	SetTradeSkillSubClassFilter(Value, 1, 1)
	
	ATSW_GetRecipesSorted(true)
end

function ATSWInvSlotDropDownButton_OnClick()
	local Value = this:GetID() - 1
	
	if Value == InvSlot() then return end
	
	SetInvSlot(Value)
    UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, Value + 1)
	SetTradeSkillInvSlotFilter(Value, 1, 1)

	ATSW_GetRecipesSorted(true)
end

function ATSWRecipeButton_OnClick(Button)
    if not (Button == "LeftButton") then return end
	
	local Name 	= this.Name
	local Type 	= this.Type
	local Link		= this.Link
	local Pos		= this.Position
	
	if IsShiftKeyDown() and not (Type == "header") then
		if ChatFrameEditBox:IsVisible() or WIM_EditBoxInFocus then
			ATSW_AddReagentLinksToChatFrame(Pos)
		elseif not (IsBeastTraining() or Type == "header") then
			local Possible = ATSW_HowManyItemsArePossibleToCreate(Name)
			
			ATSW_AddTask(Name, Possible > 0 and Possible or 1)
		end
	elseif IsControlKeyDown() and Link then
		DressUpItemLink(Link)
	else
		ATSW_SelectRecipe(Name, Type)
	end
end

function ATSW_TaskDeleteOnClick()
	ATSW_DeleteTask(this:GetParent().Name)
end

function ATSWTool_OnClick(Button)
	if Button == "LeftButton" then
		table.insert(PreviousRecipes(), RecipeSelected())
		ATSW_SelectRecipe(this.Name)
	end
end

function ATSWReagentsButton_OnClick()
    if ATSWReagentsFrame:IsVisible() then
        ATSWReagentsFrame:Hide()
    else
		for R = 1, ATSW_NECESSARIES_DISPLAYED do -- Create reagent frame buttons
			local F = CreateFrame("Frame", "ATSWRFReagent" .. R, ATSWReagentsFrame, "ATSWRFReagentTemplate")
			
			if R == 1 then
				F:SetPoint("TOPLEFT", 26, -59)
			else
				F:SetPoint("TOPLEFT", "ATSWRFReagent" .. R - 1, "BOTTOMLEFT")
			end
		end
		
        ATSW_UpdateNecessaryReagents()
		ATSWReagentsFrame:Show()
    end
end

function ATSWFrameDecrement_OnClick()
	local PreviousAmount = ATSWAmountBox:GetNumber()
	local Amount = ATSWAmountBox:GetNumber()
	
	if 			IsShiftKeyDown() 	then		Amount = 0
    elseif 	Amount > 0 			then		Amount = Amount - 1	end
	
	if PreviousAmount ~= Amount then
		if Amount == 0 then
			ATSWAmountBox:SetText(ATSW_ALL)
		else
			ATSWAmountBox:SetNumber(Amount)
		end
	end
end

function ATSWFrameIncrement_OnClick()
	local PreviousAmount = ATSWAmountBox:GetNumber()
	local Amount = ATSWAmountBox:GetNumber()

	if 			IsShiftKeyDown() 	then Amount = 100
    elseif 	Amount < 100 		then Amount = Amount + 1	end
	
	if PreviousAmount ~= Amount then
		ATSWAmountBox:SetNumber(Amount)
	end
end

function ATSWTask_OnClick(arg1)
	if arg1 == "LeftButton" and IsShiftKeyDown() then
		if not Processing and not Recipe(this.Position).Cooldown then
			local QName 			= Task(this.TaskIndex).Name
			local QAmount 		= Task(this.TaskIndex).Amount
			local IncludeTasks 	= true
			local Possible 			= ATSW_HowManyItemsArePossibleToCreate(QName, ATSW_POSSIBLE_NOTASK) > 0
			
			if Possible then
				ATSW_Craft(QName, QAmount)
			end
		end
	else
		ATSWRecipeButton_OnClick(arg1)
	end
end

function ATSWTaskButton_OnClick()
	local Amount = ATSWAmountBox:GetNumber()
	local Name = RecipeSelected()

	if Amount == 0 then
		if TradeSkill then
			Amount = ATSW_HowManyItemsArePossibleToCreate(Name)
		else
			Amount = 1
		end
	end
	
	if Amount == 0 and (ATSW_ConsiderBank or ATSW_ConsiderAlts or ATSW_ConsiderMerchants) then
		Amount = ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
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
		
		return
	end
	
	if not Processing then
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
	local P = ATSW_ProfessionExists(Profession()) and Profession() or GetFirstProfession()
	
	if P then CastSpellByName(P) end
end

function ATSW_Command(Command)
	local function Chat(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
	
    if 			Command == "options"
	or 		Command == "configuration" 
	or 		Command == "config" 	then ATSW_ToggleOptionsFrame()
	elseif 	Command == "debug" 	then ATSW_Debug = not ATSW_Debug
    else													ATSW_ShowFrame()
	end
end

function ATSW_ToggleOptionsFrame()
    if ATSWOptionsFrame:IsVisible() then
        ATSWOptionsFrame:Hide()
    else
		ATSWOFUnifiedButton:					SetChecked(ATSW_Unified)
		ATSWOFSeparateButton:					SetChecked(not ATSW_Unified)
		ATSWOFIncludeBankButton:			SetChecked(ATSW_ConsiderBank)
		ATSWOFIncludeAltsButton:				SetChecked(ATSW_ConsiderAlts)
		ATSWOFIncludeMerchantsButton:		SetChecked(ATSW_ConsiderMerchants)
		ATSWOFAutoBuyButton:					SetChecked(ATSW_AutoBuy)
		ATSWOFTooltipButton:					SetChecked(ATSW_RecipeTooltip)
		ATSWOFShoppingListButton:			SetChecked(ATSW_DisplayShoppingList)
		
        ShowUIPanel(ATSWOptionsFrame)
    end
end

function ATSWRecipe_OnClick(Link)
	if not arg1 then return end
	
    if arg1 == "RightButton" then
        if aux_frame and aux_frame:IsVisible() then --TODO проверить
            local _, _, ID = string.find(Link, "item:(%d+)")
            local Link = string.format("item:%d", tonumber(ID))
			
            SetItemRef(Link, "", "RightButton")
        elseif CanSendAuctionQuery() and AuctionFrame and AuctionFrame:IsVisible() then
            BrowseName:SetText(Link)
            AuctionFrameBrowse_Search()
            BrowseNoResultsText:SetText(BROWSE_NO_RESULTS)
        end
	elseif arg1 == "LeftButton" then
		if IsControlKeyDown() then
			DressUpItemLink(this.Link)
		elseif IsShiftKeyDown() then
			if WIM_EditBoxInFocus then
				WIM_EditBoxInFocus:Insert(this.Link)
			elseif ChatFrameEditBox:IsVisible() then
				ChatFrameEditBox:Insert(this.Link)
			else
				if this.Link then
					ATSWSearchBox:SetText(":r " .. (LinkToName(this.Link) or ""))
				end
			end
		elseif string.find(this:GetName(), "ATSWReagent") then
			local ReagentID = LinkToID(GetReagentLink(GetPositionFromGame(RecipeSelected()), this:GetID()))
			
			for I = 1, RecipesSize() do
				local Link = Recipe(I).Link
				
				if ReagentID == LinkToID(Link) then
					table.insert(PreviousRecipes(), RecipeSelected())
					
					ATSW_SelectRecipe(Recipe(I).Name)
				end
			end
		end
	end
end

function ATSWPreviousItemButton_OnClick()
    local Name = table.remove(PreviousRecipes())
	
    if Name then
        ATSW_SelectRecipe(Name)
    end
end

function ATSWItemButton_OnEnter()
	local Link = this:GetParent().Link
	
	Link = string.gsub(Link, "|c(%x+)|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r", "%2")
	
    if Link then
        GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:SetPoint("BOTTOMLEFT", this:GetName(), "TOPLEFT")
        GameTooltip:SetHyperlink(Link)
        GameTooltip:Show()
    end
end

function ATSWItemButton_OnLeave()
    GameTooltip:Hide()
end

function ATSWSubClassDropDown_OnLoad()
	getglobal(this:GetName().."Button"):SetHeight(26)
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
	UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1)
end

function ATSWSubClassDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize())
	UIDropDownMenu_SetWidth(120)
end

function ATSWSubClassDropDown_Initialize()
    ATSWFilterFrame_LoadSubClasses(GetTradeSkillSubClasses())
end

local function SetDropDownText(frame, filter, t, DefaultText)
	if 			filter > 0 					then		UIDropDownMenu_SetText(t[filter], frame)
	elseif 	table.getn(t) == 1 	then		UIDropDownMenu_SetText(t[1], frame)
	else													UIDropDownMenu_SetText(DefaultText, frame) end
end

function ATSWFilterFrame_LoadSubClasses(...)
    local info = {}
	local filter = ATSW_SubClassFilter[player][Profession()]
	
	if not filter then filter = 0 end
	
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
	getglobal(this:GetName().."Button"):SetHeight(26)
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize)
	UIDropDownMenu_SetWidth(120)
	UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1)
end

function ATSWInvSlotDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize())
	UIDropDownMenu_SetWidth(120)
end

function ATSWInvSlotDropDown_Initialize()
    ATSWFilterFrame_LoadInvSlots(GetTradeSkillInvSlots())
end

function ATSWFilterFrame_LoadInvSlots(...)
    local info = {}
	local filter = ATSW_InvSlotFilter[player][Profession()]
	
	if not filter then filter = 0 end
	
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

function ATSW_GetRecipes(New)
	if RecipesSize() == 0 or New then
		SetDropDownFilter(0, 0) -- It is needed for full trade skill list initial loading
		SetRecipesSize(0)
		
		for I = 1, GetCraftCount() do
			AddRecipe(I)
		end
	end
	
	SetDropDownFilter(SubClass(), InvSlot())
	ATSW_GetRecipesSorted(New)
end

function ATSW_GetRecipesSorted(New)
	if RecipesSortedSize() == 0 or New then
		if 			SortBy() == "Category" 	then ATSW_GetRecipesSortedByCategory	()
		elseif 	SortBy() == "Difficulty" 	then ATSW_GetRecipesSortedByDifficulty	()
		elseif 	SortBy() == "Name" 		then ATSW_GetRecipesSortedByName		()
		elseif 	SortBy() == "Custom" 	then ATSW_GetRecipesSortedByCustom	() end
	end
	
	ATSW_UpdateRecipes()
end

function ATSW_GetRecipesSortedByCategory()
	SetRecipesSortedSize(0)
	
	local Expanded, H = true
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type == "header" then
			H = R
		else
			if ATSW_Filter(R.Name, R.Type) and DropDownFilterPass(R.Name) then
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
	SetRecipesSortedSize(0)
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type ~= "header" and ATSW_Filter(R.Name, R.Type) and DropDownFilterPass(R.Name) then
			AddRecipeSorted(R)
		end
	end
end

local function TypeToNumber(Type)
	local Number = 0
	
	if Type 	== "trivial" 	then Number = 	4 end
	if Type 	== "easy" 	then Number = 	3 end
	if Type 	== "medium"	then Number = 	2 end
	if Type 	== "optimal" 	then Number = 	1 end
	if Type 	== "none" 	then Number = 	0 end
	
	return Number
end

function ATSW_GetRecipesSortedByDifficulty()
	local function CompareDifficulty(Left, Right)
		return string.lower(TypeToNumber(Left.Type)) < string.lower(TypeToNumber(Right.Type))
	end

	GetRecipesSortedWithoutHeaders()
	ATSW_Sort(RecipesSorted(), RecipesSortedSize(), CompareDifficulty)
end

function ATSW_GetRecipesSortedByName()
	local function CompareName(Left, Right)
		return string.lower(Left.Name) < string.lower(Right.Name)
	end

	GetRecipesSortedWithoutHeaders()
	ATSW_Sort(RecipesSorted(), RecipesSortedSize(), CompareName)
end

function ATSW_GetRecipesSortedByCustom()
	SetRecipesSortedSize(0)
	
	--First add all custom categories and recipes in them
	local function Categories()
		return ATSW_CustomCategories[player][Profession()]
	end
	
	local Size = table.getn(Categories())
	
	for C = 1, Size do
		local function Category(C)
			return Categories()[C]
		end
		
		local function CatRecipe(C, I)
			return Category(C).Items[I]
		end
		
		local H = Category(C)
		local Expanded, HeaderIsAdded
		
		for I = 1, table.getn(Category(C).Items) do
			local CR = CatRecipe(C, I)
			
			if ATSW_Filter(CR.Name, CR.Type) and DropDownFilterPass(CR.Name) and IsInTradeSkills(CR.Name) then
				
				if not HeaderIsAdded then
					Expanded 	= IsExpanded(H.Name)
					AddRecipeSorted(H)
					HeaderIsAdded = true
				end
				
				if Expanded then
					AddRecipeSorted(Recipe(GetRecipePosition(CR.Name)))
				end
			end
		end
	end
	
	--Then add uncategorized recipes into the category named "Uncategorized"
	local UncategorizedAdded
	
	local function AddUncategorizedHeader()
		local Expanded = IsExpanded(ATSW_UNCATEGORIZED)
		
		if not UncategorizedAdded then
			AddRecipeSorted(UncategorizedHeader[1])
			UncategorizedAdded = true
		end
		
		return Expanded
	end
	
	local Expanded, HeaderIsAdded
	
	for I = 1, RecipesSize() do
		local R = Recipe(I)
		
		if R.Type ~= "header" and not ATSWCS_IsCategorized(R.Name, R.SubName) then
			if R.Type~="header" and ATSW_Filter(R.Name, R.Type) and DropDownFilterPass(R.Name) then
				if not HeaderIsAdded then
					Expanded = AddUncategorizedHeader()
					HeaderIsAdded = true
				end
				
				if Expanded then
					AddRecipeSorted(R)
				end
			end
		end
	end
end

--Thank you kikito for the function(https://stackoverflow.com/users/312586/kikito)
--https://stackoverflow.com/questions/36820438/how-can-built-in-sorting-algorithm-be-so-fast
function ATSW_Sort(Table, Size, SortingFunction)
	local function Sort(Table, Left, Right, SortingFunction)
		if Right - Left < 1 then return end
		
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
	
	Sort(Table, 1, Size, SortingFunction)
end

function ATSW_UpdateRecipes()
	local ScrollOffset 				= ATSW_ScrollOffset[player][Profession()] / ATSW_TRADESKILL_HEIGHT
	
	for I = 1, ATSW_RECIPES_DISPLAYED do
		local Button 					= getglobal("ATSWRecipe" .. I)
		
		local Index 					= I + ScrollOffset
		local Exist 						= Index <= RecipesSortedSize()
		local R, Possible, Text
		
		SetVisible(Button, false) --Needed for tooltip update if scrolled
		SetVisible(Button, Exist)
		
		if Exist then
			R = RecipeSorted(Index)
			
			if R.Type == "header" then
				R.Texture 				= GetCategoryTexture(IsExpanded(R.Name))
			else
				if not (R.Name and R.Texture and (R.Link or IsBeastTraining())) then
					RecipesDataIsComplete 	= RecipesDataIsComplete + 2
					RecipesDataTries 			= RecipesDataIsComplete
				end
			end
			
			local ButtonText		= getglobal("ATSWRecipe" .. I .. "Text")
			local ButtonSubText	= getglobal("ATSWRecipe" .. I .. "SubText")
			local ButtonTexture 	= getglobal("ATSWRecipe" .. I .. "Texture")
			local QualityTexture 	= getglobal("ATSWRecipe" .. I .. "QualityTexture")
			local ButtonHighlight 	= getglobal("ATSWRecipe" .. I .. "Highlight")
			
			local point, relativeTo, relativePoint, _, yOfs = Button:GetPoint(2) --LEFT, ATSWFrame, LEFT
			local BorderSize 			= 0.071
			local cR, cG, cB 			= GetLinkColorRGB(R.Link)
			local PossibleAmount	= 0
			local PossibleTotal		= 0
			local TypeColor 			= ATSWTypeColor[R.Type]
			local XOffset				= 0
			local HighlightSize 		= 0.2
			local TP = R.TrainingCost
			
			if R.Type == "header" then
				HighlightSize 			= 0
				BorderSize 				= 0
			else
				XOffset 					= 20
				
				if not IsBeastTraining() then
					PossibleAmount 		= ATSW_HowManyItemsArePossibleToCreate							(R.Name)
					PossibleTotal 			= ATSW_HowManyItemsArePossibleToCreateWithConsidering	(R.Name)
					
					if ATSW_Unified then
						Possible 			= PossibleTotal > 0 and PossibleTotal or nil
					elseif PossibleTotal > 0 then
						Possible				= PossibleAmount .. "/" .. PossibleTotal
					end
					
					if Possible then
						Possible				= " |cffB0B0B0[" .. Possible .. "]|r"
					end
				end
			end
			
			Text 				= R.Name .. SubNameToString(R.SubName) .. (Possible or "")
			
			if TP and TP > 0 then
				TP = format(TRAINER_LIST_TP, TP)
				
				if R.Type == "used" then
					TP = "|cff606060" .. TP .. "|r"
				end
			else
				TP = ""
			end
			
			ButtonText:		SetWidth			(0)
			ButtonSubText:	SetText				(TP)
			ButtonTexture:	SetTexture		(R.Texture)
			ButtonTexture:	SetTexCoord		(0+BorderSize, 1-BorderSize, 0+BorderSize, 1-BorderSize)
			QualityTexture:	SetVertexColor	(cR, cG, cB)
			Button:				SetText				(Text .. (ConvertCooldown(R.Cooldown) or ""))
			Button:				SetTextColor		(TypeColor.R, TypeColor.G, TypeColor.B)
			Button:				SetPoint			(point, relativeTo:GetName(), relativePoint, Button.XOffset + XOffset, yOfs)
			ButtonHighlight:	SetTexCoord		(0+HighlightSize, 1-HighlightSize, 0+HighlightSize, 1-HighlightSize)
			ButtonHighlight:	SetDesaturated	(R.Type ~= "header")
			
			local Width 		= math.min(Button:GetTextWidth() + 20, 280)
			
			Button:				SetWidth			(Width)
			ButtonText:		SetWidth			(Width)
			
			SetVisible(QualityTexture, cR and cG and cB and not (cR == 1 and cG == 1 and cB == 1))
		end
		
		Button.Name 			= R and (R.Name .. (R.SubName and R.SubName ~= "" and ("   (" .. R.SubName .. ")") or ""))
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
		getglobal("ATSWRecipe" .. I):Hide()
	end
end

function ATSW_UpdateTasks()
    local Offset 				= FauxScrollFrame_GetOffset(ATSWTaskScrollFrame)
	
	for I = 1, ATSW_TASKS_DISPLAYED do
		local Button 			= getglobal("ATSWTask" .. I)
		local DeleteButton 	= getglobal("ATSWTask" .. I .. "DeleteButton")
		
		local Name, Type, Amount, Texture, Link, Cooldown, Pos, Text, TypeColor, Possible
		local Index 			= I + Offset
		local Exist 				= Task(Index)
		local tR, tG, tB 		= 1, 1, 1
		
		SetVisible(Button, false) --It is needed for tooltip update if button text is changed
		SetVisible(Button, Exist)
		SetVisible(DeleteButton, Exist)
		
		if Exist then
			Name				= Exist.Name
			Amount				= Exist.Amount
			Texture				= Exist.Texture
			
			Pos = GetRecipePosition(Name)
			
			if Pos then
				Type 			= Recipe(Pos).Type or "trivial"
				Link				= Recipe(Pos).Link
				Cooldown 		= Recipe(Pos).Cooldown
				TypeColor 		= ATSWTypeColor[Type]
				tR, tG, tB 		= TypeColor.R, TypeColor.G, TypeColor.B
			end
			
			local ItemTexture 			= getglobal("ATSWTask" .. I .. "Texture")
			local QualityTexture 		= getglobal("ATSWTask" .. I .. "QualityTexture")
			local R, G, B 					= GetLinkColorRGB(Link)
			local t_Width 				= ItemTexture:GetWidth()
			local _, _, _, t_xOfs, _ 	= ItemTexture:GetPoint(0)
			local NameIsProcessing 	= Processing and (Name == ProcessingRecipe)
			local PossibleAmount		= ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
			
			if PossibleAmount > 0 then
				PossibleAmount 			= "|cff10C010" .. PossibleAmount .. "|r"
			end
			
			Text = Name .. " |cffB0B0B0[" .. Amount .. "/" .. PossibleAmount .. "|cffB0B0B0]|r"
			
			Button.R 						= tR
			Button.G 						= tG
			Button.B 						= tB
			Button.TaskIndex 			= Index
			DeleteButton.TaskIndex 	= Index
			
			Button:				SetText			(Text .. (ConvertCooldown(Cooldown) or ""))
			Button:				SetTextColor	(tR, tG, tB)
			ItemTexture:		SetTexture	(Texture)
			Button:				SetWidth		(Button:GetTextWidth() + t_xOfs + t_Width + 4)
			QualityTexture:	SetVertexColor(R, G, B)
			
			SetVisible(DeleteButton, not NameIsProcessing)
			SetVisible(QualityTexture, R and G and B and not (R == 1 and G == 1 and B == 1))
			
			Button:SetAlpha(1)
		end
		
		Button.Name 			= Name
		Button.Text			= Text
		Button.Position		=	Pos
		Button.TaskIndex	= Exist and Index or nil
	end
	
	SetEnabled(ATSWReagentsButton, 	NecessaryReagentsSize() ~= 0)
	SetVisible	(ATSWWeb, 					TasksSize() == 0)
	
	ATSW_UpdateCreateButton()
	ATSW_UpdateTaskListScroll()
end

function ATSW_HideTasks()
	for I = 1, ATSW_TASKS_DISPLAYED do
		getglobal("ATSWTask" .. I):Hide()
	end
end

function ATSW_ShowSort()
	SetSortCheckboxes(SortBy())
end

function ATSW_ShowSearch()
	ATSW_BlockSearchTextChanged = true
	ATSWSearchBox:SetText(SearchString())
	
	if SearchString() == "" then
		ATSWSearchLabel:Show()
		ATSWSearchIcon:Show()
	end
	
	ATSW_BlockSearchTextChanged = false
end

function ATSW_ShowDropDown()
	UIDropDownMenu_Initialize(ATSWSubClassDropDown, 	ATSWSubClassDropDown_Initialize())
	UIDropDownMenu_Initialize(ATSWInvSlotDropDown, 	ATSWInvSlotDropDown_Initialize())
end

function ATSW_ShowSelection()
	if RecipeSelected() then
		ATSW_SelectRecipe(RecipeSelected())
	else
		local Name, _, SubName = GetCraftNameType(GetFirstCraft())
		
		if SubName and SubName ~= "" then
			SubName = "   (" .. SubName .. ")"
		end
		
		if Name then
			ATSW_SelectRecipe(Name .. (SubName or ""))
		end
	end
end

function ATSW_ShowAmount()
	local Number = ATSW_Amount[player][Profession()]
	
	if Number == 0 then
		ATSWAmountBox:SetText(ATSW_ALL)
	else
		ATSWAmountBox:SetNumber(Number)
	end
end

function ATSW_ShowTrainingPoints()
	if not IsBeastTraining() then return end
	
	local Total, Spent = GetPetTrainingPoints()
	
	ATSWTrainingPointsText:SetText(Total - Spent)
	ATSWTrainingPointsFrame:SetWidth(ATSWTrainingPointsLabel:GetWidth()+ATSWTrainingPointsText:GetWidth()+20)
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
	
	if not Visible then ATSWReagentsFrame:Hide() end
end

function ATSW_ShowTaskButton			(Visible)
	SetVisible(ATSWTaskButton, 			Visible)
end

function ATSW_ShowTrainingPointsMenu	(Visible)
	SetVisible(ATSWTrainingPointsFrame, Visible)
end

function ATSW_SelectRecipe(Name, Type)
	if not Name then
		ATSW_SelectedRecipe[player][Profession()] = nil
		ATSW_HideRecipe()
		ATSWCreateButton:Disable()
		
		return
	end
	
	if Type == "header" then
		ATSW_SwitchCategory(Name)
	else
		--Store selected recipe name
		ATSW_SelectedRecipe[player][Profession()] = Name
		ATSW_ShowRecipe(Name)
		ATSW_UpdateCreateButton()
	end
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
	local Recipe = Recipe(GetRecipePosition(Name))
	
	if not Recipe then
		ATSW_HideRecipe()
		
		return
	end
	
	local GamePosition = GetPositionFromGame(Name)
	
	SelectCraftItem(GamePosition)
	
	ATSWRecipeName:Show()
	ATSWRecipeIcon:Show()
	
	--Name
	ATSWRecipeName:SetText(Recipe.Name)
	
	--Icon
	local Quality = GetItemQuality(GamePosition)
	
	SetVisible(ATSWRecipeIconQualityTexture, Quality > 2)
	
	if Recipe.Texture then
		ATSWRecipeIcon:SetNormalTexture(Recipe.Texture)
		ATSWRecipeIcon.Link = Recipe.Link
	else
		ATSWRecipeIcon:Hide()
	end
	
	--Quality border
	if Quality > 2 then
		local RColor = QualityColor[Quality]
		
		ATSWRecipeIconQualityTexture:SetVertexColor(RColor.R, RColor.G, RColor.B)
	else
		ATSWRecipeIconQualityTexture:SetVertexColor(1, 1, 1)
	end
	
	--Amount of production
	local Min	= Recipe.ProductMin
	local Max	= Recipe.ProductMax
	
	if Max > 1 then
		if Min == Max then
			ATSWRecipeIconAmount:SetText(Min)
		else
			ATSWRecipeIconAmount:SetText(Min .. "-" .. Max)
		end
	else
		ATSWRecipeIconAmount:SetText("")
	end
	
	--Cooldown
	local Cooldown = ConvertCooldown(Recipe.Cooldown, true)
	
	SetVisible(ATSWRecipeCooldown, Cooldown)
	ATSWRecipeCooldown.Cooldown = Recipe.Cooldown
	ATSWRecipeCooldown:SetText((Cooldown and COOLDOWN_REMAINING .. " " .. Cooldown) or "")
	
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
		--Requirements
		local Button 					= getglobal("ATSWTool" .. 1)
		local ButtonText 			= getglobal("ATSWTool" .. 1 .. "Text")
		local ButtonTexture 		= getglobal("ATSWTool" .. 1 .. "Texture")
		local ReqLevel				= Recipe.RequiredLevel
		
		Required 						= BuildColoredListString(GetCraftRequirements(GamePosition))
		
		SetVisible(ATSWToolsLabel, 	Required or ReqLevel and ReqLevel > 0)
		SetVisible(Button, 				Required or ReqLevel and ReqLevel > 0)
		ATSWToolsLabel:SetText(REQUIRES_LABEL .. " ")
		
		if Required then
			Button:						SetText(Required)
		else
			if ReqLevel and ReqLevel > 0 then
				if UnitLevel("pet") >= ReqLevel then
					Button:SetText(format(RemoveEscapeCharacters(TRAINER_PET_LEVEL), ReqLevel))
				else
					Button:SetText(format(TRAINER_PET_LEVEL_RED, ReqLevel))
				end
			else
				Button:SetText("")
			end
		end
		
		ButtonTexture:				SetWidth(Texture and 16 or -1)
		Button:							SetWidth(Button:GetTextWidth() + ButtonTexture:GetWidth())
		ButtonText:					SetTextColor(0, 0, 0)
		SetEnabled(Button, false)
	else
		--Tools
		Tools = ToolStringToTable(GetCraftRequirements(GamePosition))
		
		SetVisible(ATSWToolsLabel, table.getn(Tools) > 0)
		ATSWToolsLabel:SetText(ATSW_TOOLS)
		
		for I = 1, ATSW_TOOLS_DISPLAYED do
			local Button 				= getglobal("ATSWTool" .. I)
			local ButtonText 		= getglobal("ATSWTool" .. I .. "Text")
			local ButtonTexture 	= getglobal("ATSWTool" .. I .. "Texture")
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
					_, _, _, _, _, _, _, _, Texture = GetItemInfo(ID)
				end
				
				R 							= (Available or not Texture) and 0 or 1
				Position 				= GetRecipePosition(Name)
				Link						= Position and GetCraftLink(Position)
				
				SetEnabled(Button, Position)
				ButtonTexture:		SetWidth(Texture and 16 or -1)
				ButtonTexture:		SetTexture(Texture)
				Button:					SetText(Name .. (I < table.getn(Tools) and "," or ""))
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
		--Training cost
		if Recipe.TrainingCost > 0 then
			local Total, Spent 	= GetPetTrainingPoints()
			local Usable		 	= Total - Spent
		
			if Usable >= Recipe.TrainingCost then
				ATSWCostText:SetText(Recipe.TrainingCost .. " " .. TRAINING_POINTS_LABEL)
			else
				ATSWCostText:SetText(RED_FONT_COLOR_CODE .. Recipe.TrainingCost .. FONT_COLOR_CODE_CLOSE .. " " .. TRAINING_POINTS_LABEL)
			end
		end
		
		SetVisible(ATSWReagentsLabel, 	Recipe.TrainingCost > 0)
		SetVisible(ATSWCostText, 			Recipe.TrainingCost > 0)
		ATSWReagentsLabel:SetText(COSTS_LABEL .. " ")
		
		--Description
		local Description = GetCraftDescription(GamePosition)
		
		SetVisible(ATSWCraftDescription, Description)
		
		if Description then
			ATSWCraftDescription:SetText(Description)
		end
	else
		--Reagents
		local NumReagents 		= Recipe.ReagentsSize
		
		SetVisible(ATSWReagentsLabel, NumReagents > 0)
		ATSWReagentsLabel:SetText(SPELL_REAGENTS)
		
		for I = 1, MAX_TRADE_SKILL_REAGENTS do
			local Button 				= getglobal("ATSWReagent" .. I)
			local ButtonQuality 	= getglobal("ATSWReagent" .. I .. "QualityTexture")
			local Exists 				= I <= NumReagents
			local RName, RTexture, RAmount, RPlayerAmount, RLink, RTotalAmount, Quality, RColor, R, G, B, A, Craftable, Position
			
			SetVisible(Button, false) --Needed for tooltip update if schematic is changed
			SetVisible(Button, Exists)
			
			if Exists then
				local ButtonTexture 	= getglobal("ATSWReagent" .. I .. "Texture")
				local ButtonAmount 	= getglobal("ATSWReagent" .. I .. "Amount")
				local ButtonTitle 		= getglobal("ATSWReagent" .. I .. "Title")
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
						RTotalAmount 	= RPlayerAmount .. " /" .. RAmount
					else
						A 						= 0.5
						RTotalAmount 	= ""
					end
					
					ButtonTitle:SetTextColor(R, G, B, A)
				end
				
				Position 				= GetRecipePosition(RName)
				
				ButtonTexture:		SetTexture		(RTexture)
				ButtonTexture:		SetVertexColor	(A, A, A, A)
				ButtonAmount:		SetText				(RTotalAmount)
				ButtonTitle:			SetText				(RName or "")
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
	
	--Remove previous recipe if it is selected
	for I = 1, PreviousRecipesSize() do
		if PreviousRecipe(I) == Recipe.Name then
			table.remove(PreviousRecipes(), I)
			
			break
		end
	end
	
	--Previous recipes button
	SetVisible(ATSWPreviousItemButton, PreviousRecipesSize() > 0)
	
	--Task button
	ATSWTaskButton:Enable()
	
	--Amount control
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
		getglobal("ATSWRecipe" .. I):UnlockHighlight()
	end
	
	for I = 1, ATSW_TOOLS_DISPLAYED do
		SetVisible(getglobal("ATSWTool" .. I), 		Visible)
	end
	
	for I = 1, MAX_TRADE_SKILL_REAGENTS do
		SetVisible(getglobal("ATSWReagent" .. I), 	Visible)
	end
	
	--Task button
	ATSWTaskButton:Disable()
	
	--Amount control
	ATSWIncrementButton:Disable()
	ATSWDecrementButton:Disable()
end

function ATSW_SetHighlight(Name, SubName)
	local HighlightIsSet = false
	
	if Name then
		for I = 1, ATSW_RECIPES_DISPLAYED do
			local Button = getglobal("ATSWRecipe" .. I)
			
			if Button.Name == Name then
				local R, G, B = Button:GetTextColor()
				
				ATSWHighlight:SetPoint("TOP", Button:GetName())
				ATSWHighlightTexture:SetVertexColor(R, G, B)
				HighlightIsSet = true
				
				Button:LockHighlight()
			else
				Button:UnlockHighlight()
			end
		end
	end
	
	SetVisible(ATSWHighlight, HighlightIsSet)
end

function ATSW_UpdateCreateButton()
	local Amount = ATSWAmountBox:GetNumber()
	local TaskPossible, Possible = 0
	local IncludeTasks = true
	
	local Position 	= GetPositionFromGame(RecipeSelected())
	
	if RecipesSize() > 0 then
		Possible = not Processing
		
		if not Processing then
			local Type
			
			if Position then
				_, Type		= GetCraftNameType(Position)
			end
			
			if IsBeastTraining() then
				if UnitName("pet") then
					local Total, Spent = GetPetTrainingPoints()
					local _, _, _, _, _, TrainingCost, ReqLevel = GetCraftInformation(Position)
					
					Possible = Type ~= "used" and Total - Spent >= TrainingCost
					
					if ReqLevel and ReqLevel > 0 then
						if UnitLevel("pet") < ReqLevel then
							Possible = false
						end
					end
				else
					Possible = false
				end
			else
				if not Amount or Amount == 0 then Amount = 1 end
				
				Possible = (Position and not GetCraftCooldown(Position)) and (Type ~= "used") and ATSW_HowManyItemsArePossibleToCreate(RecipeSelected()) >= Amount
				
				for I = 1, TasksSize() do
					Pos = GetPositionFromGame(Task(I).Name)
					
					if Pos then
						local Cooldown = GetCraftCooldown(Pos)
						
						if not Cooldown then
							TaskPossible = ATSW_HowManyItemsArePossibleToCreate(Task(I).Name, ATSW_POSSIBLE_NOTASK)
							
							if TaskPossible > 0 then
								Possible = not (Processing and ProcessingRecipe == Task(I).Name)
								
								break
							end
						end
					end
				end
			end
		end
	end
	
	SetEnabled(ATSWCreateButton, Possible)
	
	local Name = getglobal(GetCraftButtonToken())
	local Text
	
	if Name == "Enchant" then
		if Position and IsEnchant(Position) then
			Text = ATSW_ENCHANT
		else
			Text = ATSW_CREATE
		end
	elseif Name == "Create" or Name == "Use" then
		Text = ATSW_CREATE
	else
		Text = Name
	end
	
	ATSWCreateButton:SetText(Text or Name or "")
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
	
	ProcessingProfession	= Profession()
	ProcessingRecipe 		= Name
	ProcessingTexture		= GetCraftTexture(Index)
	ProcessingAmount 		= math.min(Amount, Possible)
	
	ATSWFrame:RegisterEvent("SPELLCAST_START")
	
	ProcessingDelay			= GetTime()
	
	Craft(Index, Amount)
end

function ATSW_AddReagentLinksToChatFrame(Position)
    local ChatType, ChatNumber

    if WIM_EditBoxInFocus ~= nil then
        ChatType 		= "WHISPER"
        ChatNumber 	= WIM_EditBoxInFocus:GetParent().theUser
    else
        ChatType, ChatNumber = ChatFrameEditBox.chatType
		
        if 			ChatType == "WHISPER" then ChatNumber = ChatFrameEditBox.tellTarget
        elseif	ChatType == "CHANNEL" then ChatNumber = ChatFrameEditBox.channelTarget end
    end
	
    local ChatLine, LineStart
	local R = Recipe(Position)
	
	if not R.Link then return end
	
	if IsEnchant(Position) then
		LineStart = ""
	else
		LineStart = ATSW_REAGENTLIST1 .. " "
	end
	
	SendChatMessage(LineStart .. R.Link .. " " .. ATSW_REAGENTLIST2, ChatType, nil, ChatNumber)
		
	for J = 1, GetReagentCount(Position) do
		local _, _, Amount, _, Link = GetReagentData(Position, J)
		
		if Amount and Amount > 1 then
			Amount = " (" .. Amount .. ")"
		else
			Amount = ""
		end
		
		ChatLine = (Link or "") .. (Amount or "")
		SendChatMessage(ChatLine, ChatType, nil, ChatNumber)
	end
end

function ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
	return ATSW_HowManyItemsArePossibleToCreate(
				Name,
				ATSW_ConsiderBank 			and ATSW_POSSIBLE_BANK,
				ATSW_ConsiderAlts 			and ATSW_POSSIBLE_ALTS,
				ATSW_ConsiderMerchants 	and ATSW_POSSIBLE_MERCHANT,
				ATSW_POSSIBLE_NOTASK	)
end

function ATSW_HowManyItemsArePossibleToCreate(Name, ...)
	local Pos 					= GetPositionFromGame(Name)
	
	if not Pos then return 0 end
	
	local I = 0
	local Possible, PossibleAmount, PossibleAmountTotal
	local MaxReagents 		= GetReagentCount(Pos)
	
	if MaxReagents == 0 then return 0 end
	
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
				TotalAmount 	= math.max(PossibleAmountTotal or 0, RAmount)
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

function ATSW_SetNecessary(Name, Amount, Link, Texture, NecessaryReagentMode)
	if not Name or (Amount and Amount <= 0) then return end
	
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

--Task functions

local function AmountInTasksIndirect(Name, Prof)
	local Amount = 0
	
	for I = 1, TasksSize(Prof) do
		local Pos = GetRecipePosition(Task(I, Prof).Name, Prof)
		local TAmount = Task(I, Prof).Amount
		
		for J = 1, Recipe(Pos, Prof).ReagentsSize do
			local R = Recipe(Pos, Prof).Reagents[J]
			
			if R.Name == Name then
				Amount = Amount + R.Amount * TAmount
				
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
	if not Name or (Amount and Amount <= 0) then return end
	
	if Prof == nil then Prof = Profession() end
	
	local Pos = GetRecipePosition(Name, Prof)
	
	local function Posession(Name)
		local Bags, Bank, OtherCharacters
		
		Bags 					= ATSW_GetBagsAmount(Name)
		Bank 				= ATSW_ConsiderBank 	and ATSW_GetBankAmount(Name) 	or 0
		OtherCharacters	= ATSW_ConsiderAlts 	and ATSW_GetAltsAmount(Name) 	or 0
		
		return Bags + Bank + OtherCharacters
	end
	
	if not Pos then
		ATSW_SetNecessary(Name, Amount, Link, Texture, NecessaryReagentMode)
		
		return
	end
	
	for I = 1, Recipe(Pos, Prof).ReagentsSize do
		local R = Recipe(Pos, Prof).Reagents[I]
		local Merchant, Required, InsertBefore = 1, 0
		
		Merchant 			= ATSW_ConsiderMerchants and ATSW_Merchant[R.Name] and 0 or 1
		
		if GetRecipePosition(R.Name, Prof) then
			Required 		= ((R.Amount * Amount) - Posession(R.Name) + AmountInTasks(R.Name, Prof)) * Merchant
			
			if AmountInTasksDirect(Name, Prof) > 0 and AmountInTasksDirect(R.Name, Prof) == 0 then
				InsertBefore = Name
			end
		else
			Required 		= R.Amount * Amount
		end
		
		ATSW_AddTask(R.Name, Required, R.Link, R.Texture, true, NecessaryReagentMode, Insert or InsertBefore, Prof)
	end
	
	if NecessaryReagentMode then return end
	
	local TPos 			= DoTaskExist(Name)
	
	if TPos then
		Task(TPos).Amount = Task(TPos).Amount + Amount
	else
		local InsertPos 	= Insert and DoTaskExist(Insert) or TasksSize() + 1
		
		table.insert(Tasks(), InsertPos, {	Name 	= Name,
														Amount = Amount,
														Texture = GetCraftTexture(Pos)	})
	end
	
	if not Recursive then
		ATSW_UpdateRecipes()
		ATSW_UpdateTasks()
	end
end

function ATSW_DeleteTask(Name, Amount, Prof)
	for I = 1, TasksSize(Prof) do
		T = Task(I, Prof)
		
		if T.Name == Name then
			--Get removing amount
			local Removed = Amount or T.Amount
			
			--Remove task
			if not Amount or T.Amount <= Amount then
				table.remove(Tasks(Prof), I)
			else
				T.Amount = T.Amount - Amount
			end
			
			--Remove necessary item
			ATSW_AddTask(Name, Removed, nil, nil, nil, ATSW_NECESSARY_REAGENT_DELETE, nil, Prof)
			
			if NoTasks() then ResetNecessaries() end
			
			--Update lists
			if not (Prof and Prof ~= Profession()) then
				ATSW_UpdateRecipes()
				ATSW_UpdateTasks()
			end
			
			break
		end
	end
end

--Progress bar functions

function ATSW_InitializeProgressBar(StartTime, EndTime)
	ATSWProgressBar:SetMinMaxValues(StartTime, EndTime)
	
	ATSWProgressBar.StartTime = StartTime
	ATSWProgressBar.EndTime 	= EndTime
	ATSWProgressBar.Mode		= ATSW_CAST
	ATSWProgressBar:				SetAlpha(1)
	ATSWProgressBarGlow:		SetAlpha(0)
	ATSWProgressBar.Working 	= true
end

function ATSW_StartProcessing()
	ATSWFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
	
	ProcessingComplete				= 0
	ProcessingStop					= false
	Processing 							= true
	
	ATSW_UpdateTasks()
	ATSWCreateButton:Disable()
end

function ATSW_StopProcessing()
	ATSWFrame:UnregisterEvent("SPELLCAST_START")
	ATSWFrame:UnregisterEvent("SPELLCAST_INTERRUPTED")
	
	Processing 							= false
	ProcessingStop					= false
	ATSWProgressBar.Working 	= false
	ATSWProgressBar.TaskItem 	= nil
	ATSWProgressBar:Hide()
	
	ATSW_UpdateTasks()
	ATSW_UpdateCreateButton()
end

function ATSW_CompleteTask()
	ATSW_DeleteTask(ProcessingRecipe, 1, ProcessingProfession)
	ProcessingAmount 			= ProcessingAmount - 1
	ProcessingComplete 		= ProcessingComplete + 1
	
	if (ProcessingProfession == Profession()) and ATSWFrame:IsVisible() then
		local Cooldown 			= GetCraftCooldown(GetPositionFromGame(ProcessingRecipe))
		
		if Cooldown then
			ATSW_UpdateFrame()
		end
	end
	
	if ProcessingAmount == 0 or ProcessingStop then
		ATSW_StopProcessing()
	end
end

-- Auction/Necessaries functions

function ATSW_ShowAuctionShoppingList()
    if (AuctionFrame:IsVisible() or aux_frame:IsVisible()) and 
	NecessaryReagentsSize() > 0 and 
	ATSW_DisplayShoppingList then
		for A = 1, ATSW_AUCTION_ITEMS_DISPLAYED do --Create auction shopping frame buttons
			if not getglobal("ATSWSLFReagent" .. A) then
				local F = CreateFrame("Frame", "ATSWSLFReagent" .. A, ATSWShoppingListFrame, "ATSWSLFReagentTemplate")
				
				if A == 1 then
					F:SetPoint("TOPLEFT", 10, -44)
				else
					F:SetPoint("TOPLEFT", "ATSWSLFReagent" .. A - 1, "BOTTOMLEFT")
				end
			end
		end
		
		--Attach (Compatible with aux)
        if not aux_frame and AuctionFrame then
            ATSWShoppingListFrame:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT", 348, -435.5)
        else
            ATSWShoppingListFrame:ClearAllPoints()
            ATSWShoppingListFrame:SetPoint("TOPRIGHT", "aux_frame", "BOTTOMRIGHT", 30, 0)
        end
		
        ATSWShoppingListFrame:Show()
		
		ATSW_UpdateAuctionList() -- Update
    end
end

function ATSWAuction_SearchForRecipe()
    if aux_frame then
        local _, _, ID = string.find(this:GetParent().Link, "item:(%d+)")
        local Link = string.format("item:%d", tonumber(ID))
		
		if IsShiftKeyDown() then
			SetItemRef(Link, "", "RightButton")
		end
    elseif CanSendAuctionQuery() then
        BrowseName:SetText(this:GetParent().Name)
        AuctionFrameBrowse_Search()
        BrowseNoResultsText:SetText(BROWSE_NO_RESULTS)
    end
end

local function UpdateReagentList(ButtonName, ButtonsMax, Offset)
	for I = 1, ButtonsMax do
		local Button				= getglobal(ButtonName .. I					)
        local Item 					= getglobal(ButtonName .. I .. "Item"		)
        local Bags 					= getglobal(ButtonName .. I .. "Bags"		)
        local Bank 					= getglobal(ButtonName .. I .. "Bank"		)
		local Alts 					= getglobal(ButtonName .. I .. "Alt"			)
        local Merchant 			= getglobal(ButtonName .. I .. "Merchant"	)
		
		local R 						= NecessaryReagent(I + Offset)
		
		SetVisible(Button, false) --It is needed for tooltip update if button text is changed
		SetVisible(Button, R)
		
        if R and Button then
			local Color				= LinkToColor(R.Link) or "ffffff"
            local AmountBags 	= ATSW_GetBagsAmount	(R.Name)
            local AmountBank 	= ATSW_GetBankAmount	(R.Name)
            local AmountAlts 	= ATSW_GetAltsAmount		(R.Name)
            local IsInMerchant	= ATSW_IsInMerchant		(R.Name)
			
			Button.Link			= R.Link
			Button.Name 			= R.Name
			
			SetEnabled(Bags, 		false)
			SetEnabled(Bank, 		false)
			SetEnabled(Merchant,	false)
			
			if AmountBags 	==	0 	then AmountBags 	=	"|cff808080" 	..	AmountBags 	.. 	"|r" end
			if AmountBank 	==	0 	then AmountBank 	=	"|cff808080" 	.. 	AmountBank 	..	"|r" end
			if AmountAlts		==   0 	then AmountAlts 	=	"|cff808080" 	..	AmountAlts 	.. 	"|r" end
			
			Item:	SetNormalTexture	(R.Texture)
            Item:	SetText					("|cff" .. Color .. "[" .. R.Name .. "]|r" .. " |cff808080[" .. R.Amount .. "]|r")
            Bags:		SetText					(AmountBags)
			Bank:	SetText					(AmountBank)
			Alts:		SetText					(AmountAlts)
						SetVisible				(Merchant, IsInMerchant)
        end
    end
end

function ATSW_UpdateAuctionList()
	local ButtonsMax 	= ATSW_AUCTION_ITEMS_DISPLAYED
    local Offset 			= FauxScrollFrame_GetOffset(ATSWSLScrollFrame)
	
	UpdateReagentList	("ATSWSLFReagent", ButtonsMax, Offset)
	
    FauxScrollFrame_Update(ATSWSLScrollFrame, NecessaryReagentsSize(), ButtonsMax, ATSW_TRADESKILL_HEIGHT)
end

function ATSW_UpdateNecessaryReagents()
	if NoTasks() then ResetNecessaries() end
	
	UpdateReagentList	("ATSWRFReagent", ATSW_NECESSARIES_DISPLAYED, 0)
	
	SetVisible(ATSWReagentsFrameAndMore, NecessaryReagentsSize() > ATSW_NECESSARIES_DISPLAYED)
	
	if NecessaryReagentsSize() == 0 then
		ATSWReagentsFrame:Hide()
	end
end

--Search functions

function ATSW_SetSearch(Text)
	if ATSW_BlockSearchTextChanged then return end

    SetSearchString(Text)
	
	if RecipesSize() > 0 then
		ATSW_GetRecipesSorted(true)
	end
end

function ATSW_Filter(Name, Type)
	if not Name then return false end
	if (Type == "header") or (Name == "") then return true end
	
	local function ReplaceMagicCharacters(String)
		local S = String
		-- Magic characters are ^$()%.[]*? and maybe + and -
		
		S = string.gsub(S, "%%", "%%%%")
		S = string.gsub(S, "%[", "%%[")
		S = string.gsub(S, "%^", "%%^")
		S = string.gsub(S, "%$", "%%$")
		S = string.gsub(S, "%(", "%%(")
		S = string.gsub(S, "%)", "%%)")
		S = string.gsub(S, "%.", "%%.")
		S = string.gsub(S, "%[", "%%[")
		S = string.gsub(S, "%]", "%%]")
		S = string.gsub(S, "%*", "%%*")
		S = string.gsub(S, "%?", "%%?")
		
		return S
	end
	
	local function RemoveSideSpaces(S)
		if S then
			_, _, S = string.find(S, "^%s*(.-)%s*$")
		end
		
		return S
	end
	
	ParameterString = string.lower(ReplaceMagicCharacters(SearchString()))
	
	local _, _, Search = string.find(ParameterString, "^([^:]*)")
	local Parameters = {}
	
    if Search then
		Search = RemoveSideSpaces(Search)
		
        table.insert(Parameters, {Name = "name", Value = Search})
    end
	
    for w in string.gfind(ParameterString, ":[^:]+") do
        local _, _, Param_Name, Param_Value = string.find(w, ":(%a+)%s([^:]+)")
		
		RemoveSideSpaces(Param_Value)
		
        if Param_Name then
            table.insert(Parameters, {Name = Param_Name, Value = Param_Value})
        end
    end
	
    for I = 1, table.getn(Parameters) do
		local PName = Parameters[I].Name
		local PValue = Parameters[I].Value
		
        if PName == "name" then
            if not string.find(string.lower(Name), PValue) then return false end
        end
		
        if PName == "reagent" or PName == "r" then
            local Index = GetRecipePosition(Name)
			
			if not Index then return false end
			
			local Found = false
			
			for J = 1, Recipe(Index).ReagentsSize do
				if string.find(string.lower(GetReagentData(Index, J) or ""), PValue) then
					Found = true
				end
			end
			
			if not Found then return false end
        end
		
        if	PName == "level"
		or	PName == "rarity"
		or	PName == "quality"
		or PName == "q"
		or	PName == "possible" 
		or	PName == "possibletotal" then 
			
			local PMin, PDirection, PMax
			
			if PName == "rarity" or PName == "quality" or PName == "q" then
				_, _, PMin, PDirection, PMax = string.find(PValue, "^(%a+)%s*([%+%-]?)%s*(%a-)$")
				
				PMin	=	QualityNames[PMin]
				PMax	=	QualityNames[PMax]
			else
				_, _, PMin, PDirection, PMax = string.find(PValue, "^(%d+)%s*([%+%-]?)%s*(%d-)$")
				
				PMin =	tonumber(PMin)
				PMax =	tonumber(PMax)
			end
			
			local Param
			
			if 			PName == "level" 				then
						Param = GetItemMinLevel(Recipe(GetRecipePosition(Name)).Position)
						
			elseif 	PName == "rarity" or PName == "quality" or PName == "q" then
						Param = GetItemQuality(Recipe(GetRecipePosition(Name)).Position)
						
			elseif 	PName == "possible" 			then
						Param = ATSW_HowManyItemsArePossibleToCreate(Name)
						
			elseif 	PName == "possibletotal" 	then
						Param = ATSW_HowManyItemsArePossibleToCreateWithConsidering(Name)
			end
			
			if PMin and not PMax then
				if PDirection ~= "" then
					if PDirection == "+" then
						if not (Param >= PMin) then return false end
					elseif PDirection == "-" then
						if not (Param <= PMin) then return false end
					end
				else
					if not (Param == PMin) then return false end
				end
			elseif PDirection == "-" then
				if not (Param > PMin and Param < PMax) then return false end
			elseif PDirection == "+" then
				if not (Param == PMin + PMax) then return false end
			end
        end
    end
	
    return true
end

-- Tooltip functions

function ATSW_DisplayRecipeTooltip()
    if not ATSW_RecipeTooltip then return end
	
    local R
	
	if IsBeastTraining() then
		R = Recipe(GetRecipeSortedPosition(this.Name))
		
		if R then
			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetCraftSpell(R.Position)
		end
		
		return
	end
	
	ATSWRecipeTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 0)
    ATSWRecipeTooltip:SetBackdropColor(0, 0, 0, 1)
	
    if this.Type ~= "header" then
		ATSWRecipeTooltipTextureLeft4:SetPoint("TOPLEFT", "$parentTextLeft3", "BOTTOMLEFT", 0, -4)
		
		R = Recipe(GetRecipeSortedPosition(this.Name))
		
        ATSWRecipeTooltip:AddLine(R.Name)
		
		local cR, cG, cB
		
		if R.Link then
			cR, cG, cB 						= GetLinkColorRGB(R.Link)
		else
			cR, cG, cB = 1, 1, 1
		end
		
		ATSWRecipeTooltipTextLeft1:SetVertexColor(cR, cG, cB)
		ATSWRecipeTooltip:AddLine(" ")
        ATSWRecipeTooltip:AddLine(ATSW_TOOLTIP_NECESSARY)
		
        local Reagents = {}
		
		local function GetReagents(Name, Amount, Link, Texture)
			if not Amount or Amount <= 0 then return end
			
			local Pos 						= GetPositionFromGame(Name)
			
			if not Pos then
				for I = 1, table.getn(Reagents) do
					if Reagents[I].Name == Name then
						Reagents[I].Amount = Reagents[I].Amount + Amount
						
						return
					end
				end
				
				table.insert(Reagents,{	Name 	= Name,
													Amount = Amount,
													Link 		= Link,
													Texture	= Texture	})
				
				return
			end
			
			for I = 1, GetReagentCount(Pos) do
				local RName, RTexture, RAmount, _, RLink = GetReagentData(Pos, I)
				
				GetReagents(RName, (RAmount * Amount), RLink, RTexture)
			end
		end
		
		GetReagents(R.Name, 1)
		
        for I = 1, 20 do
			local Texture
			local TooltipTexture = getglobal("ATSWRecipeTooltipTextureLeft" .. 3 + I)
			
            if I <= table.getn(Reagents) then
                local Bags 				= ATSW_GetBagsAmount	(Reagents[I].Name)
                local Bank 				= ATSW_GetBankAmount	(Reagents[I].Name)
                local Alts 				= ATSW_GetAltsAmount		(Reagents[I].Name)
                local Merchant 		= ""
				
                if ATSW_IsInMerchant(Reagents[I].Name) then
                    Merchant 			= " |cff808080"..ATSW_TOOLTIP_BUYABLE.."|r"
                end
				
				local Amount			= Reagents[I].Amount
				local Amountstring 	= ""
				
				if Amount > 1 then
					Amountstring 	= Reagents[I].Amount
					Amountstring 	= " |cffffffff(" .. Amountstring .. ")|r"
				end
				
				local BagStr, BankStr, AltsStr = Bags, Bank, Alts
				
				local function AddSpace(S)
					if string.len(S) 	== 1 then S = S .. "  " end
					
					return S
				end
				
				local function AddColor(S, Amount)
					if Amount == 0 then S = "|cff808080" .. S	.. "|r" else S = "|cffffffff" .. S .. "|r"  end
					
					return S
				end
				
				BagStr 	= AddSpace	(BagStr				)
				BankStr	= AddSpace	(BankStr			)
				AltsStr 	= AddSpace	(AltsStr				)
				BagStr	= AddColor	(BagStr, 	Bags	)
				BankStr	= AddColor	(BankStr, 	Bank	)
				AltsStr	= AddColor	(AltsStr,		Alts	)
				
				local cR, cG, cB = GetLinkColorRGB(Reagents[I].Link)
				
                ATSWRecipeTooltip:AddDoubleLine(
					(Reagents[I].Name or "") .. Amountstring .. Merchant, 
					"(" .. ATSW_TOOLTIP_INBAGS 	.. " " .. BagStr 	.. "  " ..
							ATSW_TOOLTIP_INBANK 	.. " " .. BankStr 	.. "  " ..
							ATSW_TOOLTIP_ONALTS 	.. " " .. AltsStr 	.. ")",	 cR, cG, cB)
				
				Texture 				= Reagents[I].Texture
            end
			
			TooltipTexture:SetTexture(Texture)
			TooltipTexture:SetWidth(Texture and 16 or -1)
        end
		
        ATSWRecipeTooltip:Show()
		ATSWRecipeTooltip:SetHeight(table.getn(Reagents)*18+64)
		ATSWRecipeTooltip:SetWidth(ATSWRecipeTooltip:GetWidth()+18)
		
		local S
		
		if ChatFrameEditBox:IsVisible() or WIM_EditBoxInFocus then
			S = ATSW_TOOLTIP_SAYREAGENTS
		elseif ATSW_HowManyItemsArePossibleToCreate(R.Name) > 0 then
			S = ATSW_TOOLTIP_ADDITEM
		end
		
		if S then
			ATSWRecipeTooltip:AddLine(S)
			ATSWRecipeTooltip:SetHeight(ATSWRecipeTooltip:GetHeight()+20)
			ATSWRecipeTooltip:SetWidth(math.max(string.len(S)*4.4, ATSWRecipeTooltip:GetWidth()))
		end
    end
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
	
	--Clear
	for Slot in pairs(ATSW_Bags[realm][player][Bag]) do
		ATSW_Bags[realm][player][Bag][Slot] = nil
	end
	
	--Memorize
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
	if not Name then return 0 end
	
    local Total = 0
	
    for Bag = 0, 4 do
        for Slot = 1, GetContainerNumSlots(Bag) do
            local ItemName = LinkToName(GetContainerItemLink(Bag, Slot))
			
            if ItemName and ItemName == Name then
                local _, Amount = GetContainerItemInfo(Bag, Slot)
				
				Total = Total + Amount
            end
        end
    end
	
    return Total
end

-- Bank functions

ATSW_Bank = {}

function ATSW_SaveBank()
	if not BankFrameOpened then return end
	
	if not ATSW_Bank[realm] then
		ATSW_Bank[realm] = {}
	end
	
	if not ATSW_Bank[realm][player] then
		ATSW_Bank[realm][player] = {}
	end
	
	--Clear
	for I, Value in pairs(ATSW_Bank[realm][player]) do
		ATSW_Bank[realm][player][I] = nil
	end
	
	--Memorize item slots
	for Slot = 1, 24 do
		local Name = LinkToName(GetContainerItemLink(BANK_CONTAINER, Slot))
		
		if Name then
			local _, Amount = GetContainerItemInfo(BANK_CONTAINER, Slot)
			
			ATSW_AddToBank(Name, Amount)
		end
	end
	
	--Memorize bank bag slots
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

function ATSW_AddToBank(Name, Amount)
    if not ATSW_Bank[realm] then
        ATSW_Bank[realm] = {}
		ATSW_Bank[realm][player] = {}
    end
	
	local BankAmount = ATSW_Bank[realm][player][Name] or 0
	
	ATSW_Bank[realm][player][Name] = BankAmount + Amount
end

function ATSW_GetBankAmount(Name)
	if not Name then return 0 end
	
    if ATSW_Bank[realm] then
        if ATSW_Bank[realm][player] then
            if ATSW_Bank[realm][player][Name] then
                return ATSW_Bank[realm][player][Name]
            end
        end
    end
	
    return 0
end

-- Alternative character functions
local function GetAltsAmountInBags(Name, PlayerName)
	if not Name then return 0 end
	
	local Table		= ATSW_Bags
	local Amount	= 0
	
	for RName in pairs(Table) do
		for PName in pairs(Table[RName]) do
			if (PlayerName and PlayerName == PName) or (PlayerName == nil and PName ~= player) then
				for Bag 	in pairs(Table[RName][PName]) do
					for Slot 	in pairs(Table[RName][PName][Bag]) do
						for IName, IAmount in pairs(Table[RName][PName][Bag][Slot]) do
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
	if not Name then return 0 end
	
	local Table		= ATSW_Bank
	local Amount	= 0
	
	for RName in pairs(Table) do
		if RName == realm then
			for PName in pairs(Table[RName]) do
				if PName ~= player then
					for IName, IAmount in pairs(Table[RName][PName]) do
						if IName == Name then
							Amount = Amount + IAmount
						end
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

function ATSW_GetAltsLocationIntoTooltip(Name)
	local HeaderAdded = false
	
	local function AddHeader()
		if not HeaderAdded then
			ATSWRecipeTooltip:AddLine(ATSW_TOOLTIP_POSESS .. " " .. this:GetParent().Link .. ":")
			
			HeaderAdded = true
		end
	end
	
	local function GetLocation(Table, In)
		if Name then
			for RName in pairs(Table) do
				if RName == realm then
					for PName in pairs(Table[RName]) do
						if PName ~= player then
							local Amount = 0
							
							if 		Table == ATSW_Bags then
								Amount = Amount + GetAltsAmountInBags(Name, PName)
							elseif Table == ATSW_Bank then
								Amount = Amount + GetAltsAmountInBank(Name, PName)
							end
							
							if Amount > 0 then
								AddHeader()
								ATSWRecipeTooltip:AddLine(ClassColorize(PName) .. ": " .. "|cffffffff" .. Amount .. "|r " .. In)
							end
						end
					end
				end
			end
		end
	end
	
	ATSWRecipeTooltip:ClearLines()
	
	ATSWRecipeTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT", 0)
	ATSWRecipeTooltip:SetBackdropColor(0, 0, 0, 1)
	
	for I = 1, 20 do
		local TooltipTexture = getglobal("ATSWRecipeTooltipTextureLeft" .. 3 + I)
		
		TooltipTexture:SetTexture(nil)
		TooltipTexture:SetWidth(-1)
	end
	
	GetLocation(ATSW_Bags, ATSW_ALTLIST1)
	GetLocation(ATSW_Bank, ATSW_ALTLIST2)
	
	if ATSWRecipeTooltip:NumLines() > 0 then
		ATSWRecipeTooltipTextureLeft4:SetPoint("TOPLEFT", "$parentTextLeft3", "BOTTOMLEFT", -1, 0)
	end
	
	ATSWRecipeTooltip:Show()
end

-- Merchant functions

ATSW_Merchant = {}

function ATSW_UpdateMerchant()
    if not (MerchantFrame:IsVisible()) then return end
	
	for I = 1, GetMerchantNumItems() do
		local Name, _, _, _, Available = GetMerchantItemInfo(I)
		
		if Name and Available == -1 then
			ATSW_Merchant[Name] = true
		end
	end
end

function ATSW_IsInMerchant(Name)
	if not Name then return false end
	
    return ATSW_Merchant[Name]
end

local function GetMerchantReagentsPrice(Buy)
	if not (MerchantFrame:IsVisible() and NecessaryReagentsSize() > 0) then return nil end
	
	local TotalPrice = 0
	
	local function GetTotalPrice(Item)
		for M = 1, GetMerchantNumItems() do
			local MName, _, MPrice, MQuantity, MAvailable = GetMerchantItemInfo(M)
			
			if Item.Name == MName then
				local HaveQuantity	= ATSW_GetBagsAmount(Item.Name) + (ATSW_ConsigerBank and ATSW_GetBankAmount(Item.Name) or 0)
				local NeedQuantity	= Item.Amount - HaveQuantity
				local BuyQuantity = math.ceil(NeedQuantity / MQuantity)
				
				if BuyQuantity > MAvailable and MAvailable > 0 then
					BuyQuantity = MAvailable
				end
				
				if BuyQuantity < 0 then BuyQuantity = 0 end
				
				TotalPrice = TotalPrice + BuyQuantity * MPrice
				
				if Buy and BuyQuantity > 0 then BuyMerchantItem(M, BuyQuantity) end
			end
		end
	end
	
	for N = 1, NecessaryReagentsSize() do
		GetTotalPrice(NecessaryReagent(N))
	end
	
	return TotalPrice
end

function ATSW_SetBuyFrameVisible()
	local Price = GetMerchantReagentsPrice()
	
   if Price and Price > 0 then
		MoneyFrame_Update(ATSWBuyPrice:GetName(), Price)
		ATSWBuyNecessaryFrame:Show()
		ATSWBuyButton:Enable()
	else
		ATSWBuyNecessaryFrame:Hide()
	end
end

function ATSW_BuyFromMerchant()
    GetMerchantReagentsPrice(true)
end

--Compatibility with other AddOns

-- ArmorCraft
function ATSW_ArmorCraftCompatibility()
	if AC_Craft and AC_Craft:GetParent() ~= ATSWFrame then
		AC_Craft:				SetParent			(ATSWFrame)
		AC_Craft:				SetPoint			("TOPLEFT", "ATSWFrame", "TOPRIGHT", -40, 0)
		AC_Craft:				SetFrameLevel	(0)
		AC_ToggleButton:	SetParent			(ATSWFrame)
		AC_ToggleButton:	SetFrameLevel	(ATSWFrame:GetFrameLevel() + 3)
		AC_ToggleButton:	SetPoint			("RIGHT", "ATSWFrameCloseButton", "LEFT", - AC_ToggleButton:GetWidth() - 80)
		AC_UseButton:		SetFrameLevel	(ATSWFrame:GetFrameLevel() + 3)
		AC_UseButton:		SetPoint			("RIGHT", "AC_ToggleButton", "LEFT")
		AC_Craft:				SetAlpha			(1.0)
		AC_ToggleButton:	SetAlpha			(1.0)
		AC_UseButton:		SetAlpha			(1.0)
	end
end
