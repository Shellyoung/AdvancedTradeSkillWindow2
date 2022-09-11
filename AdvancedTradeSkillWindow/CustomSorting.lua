local player = UnitName("player")

ATSW_CUSTOM_RECIPES_DISPLAYED 			= 23
ATSW_CUSTOM_CATEGORIES_DISPLAYED	= 21

ATSW_CSOpenCategory 								= {}
ATSW_CSOpenCategory[player] 					= {}
ATSW_CustomCategories 							= {}
ATSW_CustomCategories[player] 					= {}

ATSWCS_PreviousSkill 									= nil

local function Profession()
	return ATSW_Profession[player]
end

local function RecipesSize()
	return ATSW_RecipesSize[player][Profession()] or 0
end

local function CategorySelected()
	return ATSW_CSOpenCategory[player][Profession()]
end

local function SetCategorySelected(Value)
	if Profession() == nil then return end
	
	ATSW_CSOpenCategory[player][Profession()] = Value
end

ATSW_CustomRecipes 								= {}
ATSW_CustomRecipesSize 							= 0

local function CustomRecipes()
	return ATSW_CustomRecipes
end

local function CustomRecipesSize()
	return ATSW_CustomRecipesSize or 0
end

local function SetCustomRecipesSize(Value)
	if Profession() then
		ATSW_CustomRecipesSize = Value
	end
end

local function CustomRecipe(I)
	return CustomRecipes()[I]
end

local function AddCustomRecipe(Index)
	local Size = CustomRecipesSize() + 1
	
	if Size > table.getn(ATSW_CustomRecipes) then
		for I = 1, ATSW_TABLE_CREATION_SIZE do
			table.insert(ATSW_CustomRecipes, nil)
		end
	end
	
	CustomRecipes()[Size] = ATSW_Recipe(Index)
	
	SetCustomRecipesSize(Size)
end

local function SetVisible(Frame, State)
	if State then
		Frame:Show()
	else
		Frame:Hide()
	end
end

local function GetCategoryTexture(Expanded)
	return "Interface\\Buttons\\UI-" .. (Expanded and "Min" or "Pl") .. "usButton-Up"
end

local function IsExpanded(Name)
	return not ATSW_IsContracted(Name)
end

local function Category(I)
	return ATSW_CustomCategories[player][Profession()][I]
end

local function Item(I, J)
	return Category(I).Items[J]
end

local function CategoriesSize()
	return table.getn(ATSW_CustomCategories[player][Profession()])
end

function ATSWCS_OnLoad()
	for R = 1, ATSW_CUSTOM_RECIPES_DISPLAYED do
		local B = CreateFrame("Button", "ATSWCSRecipe" .. R, ATSWCSFrame, "ATSWCSRecipeButtonTemplate")
		
		if R == 1 then
			B:SetPoint("TOPLEFT", ATSWCSRecipesListScrollFrame, "TOPLEFT", 22, -2)
		else
			B:SetPoint("TOPLEFT", "ATSWCSRecipe" .. R - 1, "BOTTOMLEFT")
		end
	end
	
	for C = 1, ATSW_CUSTOM_CATEGORIES_DISPLAYED do
		local F = CreateFrame("Frame", "ATSWCSCategory" .. C, ATSWCSFrame, "ATSWCSCategoryFrame")
		
		if C == 1 then
			F:SetPoint("TOPLEFT", ATSWCSCategoriesListScrollFrame, "TOPLEFT")
		else
			F:SetPoint("TOPLEFT", "ATSWCSCategory" .. C - 1, "BOTTOMLEFT")
		end
	end
	
	ATSWCSFrameCloseButton:GetNormalTexture():SetTexCoord(0.20, 0.8, 0.2, 0.8)
	ATSWCSFrameCloseButton:GetPushedTexture():SetTexCoord(0.20, 0.8, 0.2, 0.8)
	
	for I = 1, ATSW_CUSTOM_CATEGORIES_DISPLAYED do
		getglobal("ATSWCSCategory" .. I .. "Delete"):GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
		getglobal("ATSWCSCategory" .. I .. "Delete"):GetPushedTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
	end
	
	for I = 1, ATSW_CUSTOM_RECIPES_DISPLAYED do
		getglobal("ATSWCSRecipe"..I.."Highlight"):SetDesaturated(true)
	end
	
	local Color = ATSWTypeColor["header"]
	
	ATSWCSHighlightTexture:SetVertexColor(Color.R, Color.G, Color.B, 0.7)
end

function ATSWCS_OnShow()
	Name = Profession()
	
	if not Name then return end
	
	ATSWCSFrameTitleText:SetText(ATSWCS_TITLE .. " (" .. Name .. ")")
	
	--Set Skill Portrait
	SetPortraitToTexture(ATSWCSFramePortrait, ATSW_GetProfessionTexture(Name))
	
	--Fill items list
	if ATSWCS_PreviousSkill ~= Profession() then
		ATSWCS_FillAllRecipes()
		
		ATSWCS_PreviousSkill = Profession()
	end
	
	ATSWCS_Update()
end

function ATSWCSAddButton_OnClick()
	local Name = ATSWCSNewCategoryBox:GetText()
	
	if Name ~= "" then
		ATSWCS_AddCategory(Name)
	end
end

function ATSWCSRecipeButton_OnClick(Name, SubName, Type, Texture)
	local CatIndex = CategorySelected()
	
    if CatIndex == 0 then return end
	
	table.insert(Category(CatIndex).Items, {Name = Name, SubName = SubName, Type = Type, Texture = Texture})
	
	ATSWCS_Update()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCSCategoryButton_OnClick(Type, Index, CatIndex)
	if not Index then return end
	
	if Type == "header" then
		local Name		= Category(CatIndex).Name
		local Expanded	= IsExpanded(Name)
		
		if CatIndex ~= CategorySelected() then
			SetCategorySelected(CatIndex)
		else
			ATSW_SwitchCategory(Category(CatIndex).Name)
		end
	else
		table.remove(ATSW_CustomCategories[player][Profession()][CatIndex].Items, Index)
	end
	
	ATSWCS_Update()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCS_MoveUp(CatIndex, Index, Type)
	ATSWCS_Move(CatIndex, Index, Index-1, Type)
end

function ATSWCS_MoveDown(CatIndex, Index, Type)
	ATSWCS_Move(CatIndex, Index, Index+1, Type)
end

function ATSWCS_Move(CatIndex, From, To, Type)
	if Type == "header" then
		ATSW_CustomCategories[player][Profession()][To], ATSW_CustomCategories[player][Profession()][From] =
		ATSW_CustomCategories[player][Profession()][From], ATSW_CustomCategories[player][Profession()][To]
		
		if 			ATSW_CSOpenCategory[player][Profession()] == From then
			ATSW_CSOpenCategory[player][Profession()] = To
		elseif 	ATSW_CSOpenCategory[player][Profession()] == To then
			ATSW_CSOpenCategory[player][Profession()] = From
		end
	else
		ATSW_CustomCategories[player][Profession()][CatIndex].Items[To],
		ATSW_CustomCategories[player][Profession()][CatIndex].Items[From] =
		ATSW_CustomCategories[player][Profession()][CatIndex].Items[From],
		ATSW_CustomCategories[player][Profession()][CatIndex].Items[To]
	end
	
	ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCS_AddCategory(Name)
	local CategoryExists
	
    for I = 1, CategoriesSize() do
        if Category(I).Name == Name then
			CategoryExists = true
            SetCategorySelected(I)
        end
    end
	
	if not CategoryExists then
		table.insert(ATSW_CustomCategories[player][Profession()], 
							{
								Name = Name,
								SubName = nil,
								Type = "header",
								Items = {}
							})
							
		SetCategorySelected(CategoriesSize())
	end
	
    ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCS_Delete(Index)
	if this:GetParent().Type == "header" then
		local ItemsSize = table.getn(Category(Index).Items)
		local ContractedPos
		
		if Index == CategorySelected() then
			SetCategorySelected(0)
		end
		
		ContractedPos = ATSW_GetContractedPos(Category(Index).Name)
		
		if ContractedPos then
			table.remove(ATSW_Contracted(), ContractedPos)
		end
		
		table.remove(ATSW_CustomCategories[player][Profession()], Index)
		
		if ItemsSize > 0 then
			ATSWCS_UpdateRecipes()
		end
		
		if CategoriesSize() == 0 then
			SetCategorySelected(0)
		end
	else
		table.remove(Category(CategorySelected()).Items, Index)
		
		ATSWCS_UpdateRecipes()
	end
	
	ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCS_FillAllRecipes()
    SetCustomRecipesSize(0)
	
    for I = 1, RecipesSize() do
		if ATSW_Recipe(I).Type ~= "header" then
			AddCustomRecipe(I)
		end
    end
	
	ATSW_Sort(CustomRecipes(), CustomRecipesSize(), ATSWCS_SortUncategorizedList)
end

function ATSWCS_IsCategorized(Name, SubName)
	for C = 1, CategoriesSize() do
		for I = 1, table.getn(Category(C).Items) do
			local R = Item(C, I)
			
			local LSubName = SubName
			
			if LSubName == "" then LSubName = nil end
			
			if R.Name == Name and (LSubName and R.SubName == LSubName or LSubName == nil) then
				return true
			end
		end
	end
	
    return false
end

function ATSWCS_SortUncategorizedList(Left, Right)
    return string.lower(Left.Name) < string.lower(Right.Name)
end

function ATSWCS_UpdateATSWFrame()
	if ATSW_SortBy[player][Profession()] == "Custom" then
		ATSW_GetRecipesSorted(true)
		ATSW_UpdateRecipes()
	end
end

function ATSWCS_Update()
	ATSWCS_UpdateRecipes()
	ATSWCS_UpdateCategories()
end

function ATSWCS_UpdateRecipes()
	local IsHighlightSet
	local ListSize 						= CustomRecipesSize()
    local ScrollOffset 				= FauxScrollFrame_GetOffset(ATSWCSRecipesListScrollFrame)
	
    for I = 1, ATSW_CUSTOM_RECIPES_DISPLAYED do
        local Button 					= getglobal("ATSWCSRecipe" .. I)
		local ButtonTexture 		= getglobal("ATSWCSRecipe" .. I .. "Texture")
		
		local Index 					= I + ScrollOffset
		local ItemExists 				= Index <= ListSize
		local R
		
		if ItemExists then
			R 								= CustomRecipe(Index)
			ItemExists 					= not ATSWCS_IsCategorized(R.Name, R.SubName)
		end
		
		SetVisible(Button, ItemExists)
		
		if ItemExists then
			local tWidth 				= ButtonTexture:GetWidth()
			local _, _, _, fsxOfs 	= Button:GetFontString():GetPoint(0)
			local Color 				= ATSWTypeColor[R.Type]
			
			Button.Name 				= R.Name
			Button.SubName		= R.SubName
			Button.Type 				= R.Type
			Button.Texture 			= R.Texture
			
			Button:				SetText			(R.Name .. ATSW_SubNameToString(R.SubName))
			Button:				SetTextColor	(Color.R, Color.G, Color.B)
			Button:				SetWidth		(Button:GetTextWidth() + tWidth + fsxOfs*2)
			ButtonTexture:	SetTexture	(R.Texture)
		end
    end
	
	FauxScrollFrame_Update(	ATSWCSRecipesListScrollFrame, ListSize, 
										ATSW_CUSTOM_RECIPES_DISPLAYED, ATSW_TRADESKILL_HEIGHT)
end

function ATSWCS_UpdateCategories()
	local IsHighlightSet
	local ListSize 						= ATSWCS_GetCategoriesListSize()
    local ScrollOffset					= FauxScrollFrame_GetOffset(ATSWCSCategoriesListScrollFrame)
	
    for I = 1, ATSW_CUSTOM_CATEGORIES_DISPLAYED do
        local Button 					= getglobal("ATSWCSCategory" .. I .. "SkillButton")
        local ButtonText			= getglobal("ATSWCSCategory" .. I .. "SkillButtonText")
		local ButtonDelete 			= getglobal("ATSWCSCategory" .. I .. "Delete")
		local ButtonUp 				= getglobal("ATSWCSCategory" .. I .. "MoveUp")
		local ButtonDown 			= getglobal("ATSWCSCategory" .. I .. "MoveDown")
		local ButtonTexture		= getglobal("ATSWCSCategory" .. I .. "SkillButtonTexture")
		local ButtonHighlight 		= getglobal("ATSWCSCategory" .. I .. "SkillButtonHighlight")
		
		local Index = I + ScrollOffset
		local Name, SubName, Type, Texture, Expanded
		local ItemExists 				= Index <= ListSize
		
		if ItemExists then
			CatIndex, Index, Name, SubName, Type, Texture, Expanded = ATSWCS_GetItemFromCategories(Index)
		end
		
		SetVisible(Button, Name)
		SetVisible(ButtonDelete, Index and (Type == "header"))
		
		if Type == "header" then
			SetVisible(ButtonUp, 		ItemExists and (I > 1))
			SetVisible(ButtonDown, 	ItemExists and not (Index == CategoriesSize()))
		else			
			SetVisible(ButtonUp, 		ItemExists and not (Index == 1))
			SetVisible(ButtonDown, 	ItemExists and not (Index == table.getn(Category(CatIndex).Items)))
		end
		
		if Name then
			local point, relativeTo, relativePoint, xOfs, yOfs = Button:GetPoint(0)
			local tWidth 				= ButtonTexture:GetWidth()
			local _, _, _, txOfs 		= ButtonTexture:GetPoint(0)
			local _, _, _, fsxOfs 	= Button:GetFontString():GetPoint(0)
			local HighlightSize 		= 0.2
			local BorderSize 			= 0.071
			local Color 				= ATSWTypeColor[Type]
			
			xOfs = (Type == "header" and 0 or 20)
			
			if Type == "header" then
				HighlightSize = 0
				BorderSize = 0
				
				if Index == CategorySelected() then
					ATSWCSHighlight:SetPoint("TOP", Button:GetName(), "TOP", 0, 0)
					Button:LockHighlight()
					IsHighlightSet = true
				else
					Button:UnlockHighlight()
				end
			else
				Button:UnlockHighlight()
			end
			
			Button:GetParent().Index 			= Index
			Button:GetParent().CatIndex 		= CatIndex
			Button:GetParent().Name 			= Name
			Button:GetParent().Type 			= Type
			Button:GetParent().Texture 		= Texture
			
			ButtonText:		SetWidth			(0)
			Button:				SetText				(Name .. ATSW_SubNameToString(SubName))
			Button:				SetTextColor		(Color.R, Color.G, Color.B)
			Button:				SetPoint			(point, relativeTo:GetName(), relativePoint, xOfs, yOfs)
			Button:				SetWidth			(Button:GetTextWidth() + tWidth + fsxOfs*2)
			ButtonTexture:	SetTexture		(Texture)
			ButtonTexture:	SetTexCoord		(0+BorderSize+0.025, 1-BorderSize, 0+BorderSize, 1-BorderSize)
			ButtonHighlight:	SetTexCoord		(0+HighlightSize, 1-HighlightSize, 0+HighlightSize, 1-HighlightSize)
			ButtonHighlight:	SetDesaturated	(Type ~= "header")
			
			local Width = math.min(Button:GetTextWidth() + 20, 270)
			
			Button:				SetWidth			(Width)
			ButtonText:		SetWidth			(Width)
		end
    end
	
	SetVisible(ATSWCSHighlight, IsHighlightSet)
	
	FauxScrollFrame_Update(	ATSWCSCategoriesListScrollFrame, ListSize,
										ATSW_CUSTOM_CATEGORIES_DISPLAYED, ATSW_TRADESKILL_HEIGHT	)
end

function ATSWCS_GetCategoriesListSize()
	local Size, ListSize = CategoriesSize()
	
	ListSize = Size
	
	for C = 1, Size do
		if IsExpanded(Category(C).Name) then
			ListSize = ListSize + table.getn(Category(C).Items)
		end
	end
	
	return ListSize
end

function ATSWCS_GetItemFromCategories(Need)
	local Size = CategoriesSize()
	local NextIndex = 0
	local C = 0
	local Name, Type, Expanded, Texture
	
	for C = 1, Size do
		NextIndex = NextIndex + 1
		
		if NextIndex == Need then
			Name		= Category(C).Name
			Type			= Category(C).Type
			Expanded	= IsExpanded(Name)
			Texture		= GetCategoryTexture(Expanded)
			
			return C, C, Name, nil, Type, Texture, Expanded
		end
		
		if IsExpanded(Category(C).Name) then
			for I = 1, table.getn(Category(C).Items) do
				NextIndex = NextIndex + 1
				
				if NextIndex == Need then
					return C, I, Item(C, I).Name, Item(C, I).SubName, Item(C, I).Type, Item(C, I).Texture
				end
			end
		end
	end
end

function ATSWCS_UpdateCategoriesTypes()
	local Size = CategoriesSize()
	
	for I = 1, Size do
		for J = 1, table.getn(Category(I).Items) do
			Item(I, J).Type = ATSW_GetSkillDataFromSkillList(Item(I, J).Name)
		end
	end
end