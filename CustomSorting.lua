local player	= UnitName('player')
local realm 	= GetRealmName()

ATSW_CUSTOM_RECIPES_DISPLAYED 			= 23
ATSW_CUSTOM_CATEGORIES_DISPLAYED	= 19

ATSW_CSSelected		 								= {}
ATSW_CSSelected[realm] 							= {}
ATSW_CSSelected[realm][player] 					= {}
ATSW_CSOpenCategory 								= {}
ATSW_CSOpenCategory[realm] 					= {}
ATSW_CSOpenCategory[realm][player] 			= {}
ATSW_CustomCategories 							= {}
ATSW_CustomCategories[realm] 					= {}
ATSW_CustomCategories[realm][player] 		= {}

ATSWCS_PreviousSkill 									= nil

local function Profession()
	return ATSW_Profession[realm][player]
end

local function RecipesSize()
	return ATSW.RecipesSize[realm][player][Profession()] or 0
end

local function CategorySelected()
	return ATSW_CSOpenCategory[realm][player][Profession()]
end

local function GetSelected()
	return ATSW_CSSelected[realm][player][Profession()] or ''
end

local function SetSelected(Value)
	if Profession() == nil then
		return
	end
	
	ATSW_CSSelected[realm][player][Profession()] = Value or ''
end

ATSW_CustomRecipes 								= {}
ATSW_CustomRecipesSize 							= 0

local function CustomRecipes()
	return ATSW_CustomRecipes
end

local function CustomRecipesSize(Value)
	if Value and Profession() then
		ATSW_CustomRecipesSize = Value
	end
	
	return ATSW_CustomRecipesSize or 0
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
	
	CustomRecipesSize(Size)
end

local function SetVisible(Frame, State)
	if State then
		Frame:Show()
	else
		Frame:Hide()
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

local function GetCategoryTexture(Expanded)
	return 'Interface\\Buttons\\UI-' .. (Expanded and 'Min' or 'Pl') .. 'usButton-Up'
end

local function IsExpanded(Name)
	return not ATSW_IsContracted(Name)
end

local function Categories()
	return ATSW_CustomCategories[realm][player][Profession()]
end

local function CategoriesSize()
	return table.getn(Categories())
end

local function Category(I)
	return Categories()[I]
end

local function Item(I, J)
	return Category(I).Items[J]
end

local function SetCategorySelected(Value)
	if Profession() == nil then
		return
	end
	
	ATSW_CSOpenCategory[realm][player][Profession()] = Value
	
	if Value > 0 then
		SetSelected(Category(Value).Name)
	else
		SetSelected()
	end
end

local function ItemsSize(C)
	return table.getn(Category(C).Items)
end

local function GetCategoryItemByItemName(Name)
	for C = 1, CategoriesSize() do
		for I = 1, ItemsSize(C) do
			if Item(C, I).Name .. ATSW_SubNameToString(Item(C, I).SubName) == Name then
				return C, I
			end
		end
	end
end

local function CategoryExist(Name)
	if CategoriesSize() == 0 then return false end
	
	for C = 1, CategoriesSize() do
		if Category(C).Name == Name then
			return C
		end
	end
end

local function GetItemType(Name)
	local Type = 'item'
	local Name = Name or GetSelected()
	
	for I = 1, CategoriesSize() do
		if Category(I).Name == Name then
			Type = 'header'
			
			break
		end
	end
	
	return Type
end

local function IsFirst(Name)
	if GetItemType(Name) == 'header' then
		return Category(1).Name == Name
	else
		local C = GetCategoryItemByItemName(Name)
		
		if C then
			return Item(C, 1).Name .. ATSW_SubNameToString(Item(C, 1).SubName) == Name
		end
	end
end

local function IsLast(Name)
	if GetItemType(Name) == 'header' then
		return Category(CategoriesSize()).Name == Name
	else
		local C = GetCategoryItemByItemName(Name)
		
		if C then
			return Item(C, ItemsSize(C)).Name .. ATSW_SubNameToString(Item(C, ItemsSize(C)).SubName) == Name
		end
	end
end

function ATSWCS_OnLoad()
	for R = 1, ATSW_CUSTOM_RECIPES_DISPLAYED do
		local B = CreateFrame('Button', 'ATSWCSRecipe' .. R, ATSWCSFrame, 'ATSWCSRecipeButtonTemplate')
		
		if R == 1 then
			B:SetPoint('TOPLEFT', ATSWCSRecipesListScrollFrame, 'TOPLEFT', 0, -2)
		else
			B:SetPoint('TOPLEFT', 'ATSWCSRecipe' .. R - 1, 'BOTTOMLEFT')
		end
	end
	
	for C = 1, ATSW_CUSTOM_CATEGORIES_DISPLAYED do
		local F = CreateFrame('Frame', 'ATSWCSCategory' .. C, ATSWCSFrame, 'ATSWCSCategoryFrame')
		
		if C == 1 then
			F:SetPoint('TOPLEFT', ATSWCSCategoriesListScrollFrame, 'TOPLEFT')
		else
			F:SetPoint('TOPLEFT', 'ATSWCSCategory' .. C - 1, 'BOTTOMLEFT')
		end
	end
	
	ATSWCSFrameCloseButton:GetNormalTexture():SetTexCoord(0.20, 0.8, 0.2, 0.8)
	ATSWCSFrameCloseButton:GetPushedTexture():SetTexCoord(0.20, 0.8, 0.2, 0.8)
	
	getglobal('ATSWCSFrameDelete'):GetNormalTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
	getglobal('ATSWCSFrameDelete'):GetPushedTexture():SetTexCoord(0.2, 0.8, 0.2, 0.8)
	
	for I = 1, ATSW_CUSTOM_RECIPES_DISPLAYED do
		getglobal('ATSWCSRecipe'..I..'Highlight'):SetDesaturated(true)
	end
	
	local Color = ATSWTypeColor['header']
	
	ATSWCSHighlightTexture:SetVertexColor(Color.R, Color.G, Color.B, 0.8)
	
	ATSWCSFrame:SetMovable(true)
	ATSWCSFrame:EnableMouse(true)
	ATSWCSFrame:RegisterForDrag('LeftButton')
	ATSWCSFrame:SetScript('OnDragStart', function() this:StartMoving() end)
	ATSWCSFrame:SetScript('OnDragStop',
		function()
			this:StopMovingOrSizing()
		end
	)
end

function ATSWCS_OnShow()
	Name = Profession()
	
	if not Name then
		return
	end
	
	ATSWCSFrameTitleText:SetText(ATSWCS_TITLE .. ' (' .. Name .. ')')
	
	--Set Skill Portrait
	SetPortraitToTexture(ATSWCSFramePortrait, ATSW_GetProfessionTexture(Name))
	
	--Fill items list
	if ATSWCS_PreviousSkill ~= Profession() then
		ATSWCS_FillAllRecipes()
		
		ATSWCS_PreviousSkill = Profession()
	end
	
	ATSWCS_Update()
	ATSWUpdaterFrame:Show()
end

function ATSWCSAddButton_OnClick()
	local Text = ATSWCSNewCategoryBox:GetText()
	
	if Text ~= '' then
		ATSWCS_AddCategory(Text)
	end
end

function ATSWCSNewCategoryBox_OnTextChanged()
	local CatIndex = CategorySelected()
	local Text = ATSWCSNewCategoryBox:GetText()
	local Exist = false
	
	if Text ~= '' then
		for I = 1, CategoriesSize() do
			if Category(I).Name == Text then
				Exist = true
				
				break
			end
		end
		
		SetEnabled(ATSWCSAddButton, not Exist)
		ATSWCSAddCategoryLabel:Hide()
		ATSWCSAddCategoryIcon:Hide()
		
		SetEnabled(ATSWCSRenameButton, CatIndex and CatIndex > 0 and not CategoryExist(Text))
	else
		ATSWCSAddButton:Disable()
		ATSWCSRenameButton:Disable()
	end
end

function ATSWCSRenameButton_OnClick()
	local CatIndex = CategorySelected()
	local Text = ATSWCSNewCategoryBox:GetText()
	
	Category(CatIndex).Name = Text
	SetSelected(Text)
	
	ATSWCSNewCategoryBox:SetText('')
	
	ATSWCS_Update()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCSRecipeButton_OnClick(Name, SubName, Type, Texture)
	local CatIndex = CategorySelected()
	local ItemCount = 0
	local Position = 0
	
    if CatIndex == 0 then
		return
	end
	
	ItemCount = ItemsSize(CatIndex)
	
	if ItemCount > 0 and GetSelected() ~= Category(CatIndex).Name then
		for I = 1, ItemCount do
			local Name 		= Category(CatIndex).Items[I].Name
			local SubName 	= Category(CatIndex).Items[I].SubName
			
			if Name .. ATSW_SubNameToString(SubName) == GetSelected() then
				Position = I
				
				break
			end
		end
	end
	
	table.insert(Category(CatIndex).Items, Position+1, {Name = Name, SubName = SubName, Type = Type, Texture = Texture})
	
	ATSWCS_Update()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCSCategoryButton_OnClick(Name, Type, Index, CatIndex)
	if not Index then
		return
	end
	
	local PrevCategory = ''
	
	if CategorySelected() > 0 then
		PrevCategory = Category(CategorySelected()).Name
	end
	
	if CatIndex ~= CategorySelected() then
		SetCategorySelected(CatIndex)
	end
	
	if Type == 'header' then
		if CatIndex == CategorySelected() and Name == PrevCategory and Name == GetSelected() then
			ATSW_SwitchCategory(Category(CatIndex).Name)
		else
			SetCategorySelected(CatIndex)
		end
	else
		if Name ==  GetSelected() then
			table.remove(Category(CatIndex).Items, Index)
			SetSelected('')
		else
			SetSelected(Name)
		end
	end
	
	ATSWCS_Update()
	ATSWCS_UpdateATSWFrame()
end

local function PrepareForMove()
	local CatIndex = CategorySelected()
	local Type = GetItemType(GetSelected())
	local Index
	
	if Type == 'header' then
		Index = CatIndex
	else
		_, Index = GetCategoryItemByItemName(GetSelected())
	end
	
	return CatIndex, Index, Type
end

function ATSWCSFrameMoveUp_OnClick()
	local CatIndex, Index, Type = PrepareForMove()
	
	ATSWCS_Move(CatIndex, Index, Index-1, Type)
end

function ATSWCSFrameMoveDown_OnClick()
	local CatIndex, Index, Type = PrepareForMove()
	
	ATSWCS_Move(CatIndex, Index, Index+1, Type)
end

function ATSWCS_Move(CatIndex, From, To, Type)
	if Type == 'header' then
		ATSW_CustomCategories[realm][player][Profession()][To], ATSW_CustomCategories[realm][player][Profession()][From] =
		ATSW_CustomCategories[realm][player][Profession()][From], ATSW_CustomCategories[realm][player][Profession()][To]
		
		if 		ATSW_CSOpenCategory[realm][player][Profession()] == From then
			ATSW_CSOpenCategory[realm][player][Profession()] = To
		elseif ATSW_CSOpenCategory[realm][player][Profession()] == To then
			ATSW_CSOpenCategory[realm][player][Profession()] = From
		end
	else
		Category(CatIndex).Items[To], Category(CatIndex).Items[From] =
		Category(CatIndex).Items[From], Category(CatIndex).Items[To]
	end
	
	ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCSFrameRename_OnClick()
	ATSWCSNewCategoryBox:SetFocus()
	ATSWCSNewCategoryBox:SetText(GetSelected())
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
		table.insert(Categories(), 
							{
								Name = Name,
								SubName = nil,
								Type = 'header',
								Items = {}
							})
							
		SetCategorySelected(CategoriesSize())
	end
	
    ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

function ATSWCSFrameDelete_OnClick()
	local Index
	
	if GetItemType() == 'header' then
		Index = CategorySelected()
		
		local ItemsCount = ItemsSize(Index)
		local ContractedPos = ATSW_GetContractedPos(Category(Index).Name)
		
		table.remove(Categories(), Index)
		SetCategorySelected(0)
		
		if ContractedPos then
			table.remove(ATSW_Contracted(), ContractedPos)
		end
		
		if ItemsCount > 0 then
			ATSWCS_UpdateRecipes()
		end
	else
		_, Index = GetCategoryItemByItemName(GetSelected())
		local NewC, NewI = CategorySelected()
		local WasLast = IsLast(GetSelected())
		table.remove(Category(NewC).Items, Index)
		
		if ItemsSize(NewC) > 1 then
			if WasLast then
				NewI = ItemsSize(NewC)
			else
				NewI = Index
			end
		elseif ItemsSize(NewC) == 1 then
			NewI = 1
		end
		
		if ItemsSize(NewC) > 0 then
			SetSelected(Item(NewC, NewI).Name .. ATSW_SubNameToString(Item(NewC, NewI).SubName))
		else
			SetSelected(Category(NewC).Name)
		end
		
		ATSWCS_UpdateRecipes()
	end
	
	ATSWCS_UpdateCategories()
	ATSWCS_UpdateATSWFrame()
end

local function CompareDifficulty(Left, Right)
	return ATSW_TypeToNumber(Left.Type) < ATSW_TypeToNumber(Right.Type)
end

local function CompareDifficultyUsingExternalData(Left, Right)
	return (ATSW_TypeToNumber(Left.Type) == ATSW_TypeToNumber(Right.Type)) and (ATSW_CompareSkill(Left.Name) > ATSW_CompareSkill(Right.Name))
end

function ATSWCS_FillAllRecipes()
    CustomRecipesSize(0)
	
    for I = 1, RecipesSize() do
		if ATSW_Recipe(I).Type ~= 'header' then
			AddCustomRecipe(I)
		end
    end
	
		-- Compatibility for AtlasLoot
	if ATSW_CheckForAtlasLootLoaded() then
		ATSW_Sort(CustomRecipes(), CustomRecipesSize(), CompareDifficulty)
		ATSW_Sort(CustomRecipes(), CustomRecipesSize(), CompareDifficultyUsingExternalData)
	end
end

function ATSWCS_IsCategorized(Name, SubName)
	for C = 1, CategoriesSize() do
		for I = 1, ItemsSize(C) do
			local R = Item(C, I)
			
			local LSubName = SubName
			
			if LSubName == '' then
				LSubName = nil
			end
			
			if R.Name == Name and (LSubName and R.SubName == LSubName or LSubName == nil) then
				return true
			end
		end
	end
end

function ATSWCS_UpdateATSWFrame()
	if ATSW_SortBy[realm][player][Profession()] == 'Custom' then
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
        local Button 					= getglobal('ATSWCSRecipe' .. I)
		local ButtonText			= getglobal('ATSWCSRecipe' .. I .. 'Text')
		local ButtonTexture 		= getglobal('ATSWCSRecipe' .. I .. 'Texture')
		
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
			
			ButtonText:		SetWidth		(0)
			Button:				SetText			(R.Name .. ATSW_SubNameToString(R.SubName))
			Button:				SetTextColor	(Color.R, Color.G, Color.B)
			Button:				SetWidth		(Button:GetTextWidth() + tWidth + fsxOfs*2)
			ButtonTexture:	SetTexture	(R.Texture)
			
			local Width 		= math.min(Button:GetTextWidth() + 20, 280)
			
			Button:				SetWidth			(Width)
			ButtonText:		SetWidth			(Width)
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
        local Button 					= getglobal('ATSWCSCategory' .. I .. 'SkillButton')
        local ButtonText			= getglobal('ATSWCSCategory' .. I .. 'SkillButtonText')
		local ButtonTexture		= getglobal('ATSWCSCategory' .. I .. 'SkillButtonTexture')
		local ButtonHighlight 		= getglobal('ATSWCSCategory' .. I .. 'SkillButtonHighlight')
		
		local Index = I + ScrollOffset
		local Name, SubName, Type, Texture, Expanded
		local ItemExists 				= Index <= ListSize
		
		if ItemExists then
			CatIndex, Index, Name, SubName, Type, Texture, Expanded = ATSWCS_GetItemFromCategories(Index)
		end
		
		SetVisible(Button, Name)
		
		if Name then
			local point, relativeTo, relativePoint, xOfs, yOfs = Button:GetPoint(0)
			local tWidth 				= ButtonTexture:GetWidth()
			local _, _, _, txOfs 		= ButtonTexture:GetPoint(0)
			local _, _, _, fsxOfs 	= Button:GetFontString():GetPoint(0)
			local HighlightSize 		= 0.2
			local BorderSize 			= 0.071
			local Color 				= ATSWTypeColor[Type]
			
			xOfs = (Type == 'header' and 0 or 20)
			
			if Type == 'header' then
				HighlightSize = 0
				BorderSize = 0
			end
			
			if Name .. ATSW_SubNameToString(SubName) == GetSelected() then
				ATSWCSHighlight:SetPoint('TOP', Button:GetName(), 'TOP', 0, 0)
				ATSWCSHighlightTexture:SetVertexColor(Color.R, Color.G, Color.B, 0.7)
				Button:LockHighlight()
				IsHighlightSet = true
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
			ButtonTexture:	SetTexCoord		(0+BorderSize+0.025,	1-BorderSize,		0+BorderSize,	1-BorderSize)
			ButtonHighlight:	SetTexCoord		(0+HighlightSize, 		1-HighlightSize,	0+HighlightSize,	1-HighlightSize)
			ButtonHighlight:	SetDesaturated	(Type ~= 'header')
			
			local Width = math.min(Button:GetTextWidth() + 20, 280)
			
			Button:				SetWidth			(Width)
			ButtonText:		SetWidth			(Width)
		end
    end
	
	SetVisible(ATSWCSHighlight, IsHighlightSet)
	
	FauxScrollFrame_Update(	ATSWCSCategoriesListScrollFrame, ListSize,
										ATSW_CUSTOM_CATEGORIES_DISPLAYED, ATSW_TRADESKILL_HEIGHT	)
	
	ATSWCS_UpdateButtons()
end

local function SetLabelColor(Button)
	local Label = getglobal(Button:GetName() .. 'Label')
	
	if Button:IsEnabled() == 1 then
		Label:SetTextColor(1, 1, 1)
	else
		Label:SetTextColor(0.5, 0.5, 0.5)
	end
end

function ATSWCS_UpdateButtons()
	local Parent 		= 'ATSWCSFrame'
	local Delete		= getglobal(Parent .. 'Delete')
	local MoveDown	= getglobal(Parent .. 'MoveDown')
	local MoveUp		= getglobal(Parent .. 'MoveUp')
	local Rename		= getglobal(Parent .. 'Rename')
	
	SetEnabled(Delete, GetSelected() ~= '')
	SetEnabled(MoveDown, GetSelected() ~= '' and not IsLast(GetSelected()))
	SetEnabled(MoveUp, GetSelected() ~= '' and not IsFirst(GetSelected()))
	SetEnabled(Rename, CategorySelected() > 0 and GetSelected() == Category(CategorySelected()).Name)
	
	SetLabelColor(Delete)
	SetLabelColor(MoveDown)
	SetLabelColor(MoveUp)
	SetLabelColor(Rename)
end

function ATSWCS_GetCategoriesListSize()
	local Size, ListSize = CategoriesSize()
	
	ListSize = Size
	
	for C = 1, Size do
		if IsExpanded(Category(C).Name) then
			ListSize = ListSize + ItemsSize(C)
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
			for I = 1, ItemsSize(C) do
				NextIndex = NextIndex + 1
				
				if NextIndex == Need then
					local Type = ATSW_Recipe(ATSW_GetRecipePosition(Item(C, I).Name)).Type
					return C, I, Item(C, I).Name, Item(C, I).SubName, Type, Item(C, I).Texture
				end
			end
		end
	end
end

function ATSWCS_UpdateCategoriesTypes()
	local Size = CategoriesSize()
	
	for C = 1, Size do
		for I = 1, ItemsSize(C) do
			Item(C, I).Type = ATSW_GetSkillDataFromSkillList(Item(C, I).Name)
		end
	end
end