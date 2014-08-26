--[[
	 _
	( )
   _| |   __   _ __   ___ ___     _ _
 /´_` | /´__`\( '__)/´ _ ` _ `\ /´_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_)

	DColorPalette
--]]

local color_Error = Color( 255, 0, 255 )

local PANEL = {}

AccessorFunc( PANEL, "m_ConVarR", "ConVarR" )
AccessorFunc( PANEL, "m_ConVarG", "ConVarG" )
AccessorFunc( PANEL, "m_ConVarB", "ConVarB" )
AccessorFunc( PANEL, "m_ConVarA", "ConVarA" )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )
AccessorFunc( PANEL, "m_buttonsize", "ButtonSize", FORCE_NUMBER )

AccessorFunc( PANEL, "m_NumRows", "NumRows", FORCE_NUMBER )

--[[---------------------------------------------------------
	Default palette
-----------------------------------------------------------]]
local function CreateColorTable( rows )

	local rows = rows or 8
	local index = 0
	local ColorTable = {}
	for i=0, rows * 2 - 1 do -- HSV 
		local col = math.Round( math.min( i * ( 360 / ( rows * 2 ) ), 359 ) )
		index = index + 1
		ColorTable[index] = HSVToColor( 360 - col, 1, 1 )
	end

	for i=0, rows - 1 do -- HSV dark
		local col = math.Round( math.min( i * ( 360 / rows ), 359 ) )
		index = index + 1
		ColorTable[index] = HSVToColor( 360 - col, 1, 0.5 )
	end

	for i=0, rows - 1 do -- HSV grey
		local col = math.Round( math.min( i * ( 360 / rows ), 359 ) )
		index = index + 1
		ColorTable[index] = HSVToColor( 360 - col, 0.5, 0.5 )
	end

	for i=0, rows - 1 do -- HSV bright
		local col = math.min( i * ( 360 / rows ), 359 )
		index = index + 1
		ColorTable[index] = HSVToColor( 360 - col, 0.5, 1 )
	end

	for i=0, rows - 1 do -- Greyscale
		local white = 255 - math.Round( math.min( i * ( 256 / ( rows - 1 ) ), 255 ) )
		index = index + 1
		ColorTable[index] = Color( white, white, white )
	end

	return ColorTable

end

local function AddButton( panel, color, size, id )

	local button = vgui.Create( "RColorButton", panel )
	button:SetSize( size or 10, size or 10 )
	button:SetID( id )

	--
	-- If the cookie value exists, then use it
	--
	local col_saved = panel:GetCookie( "col."..id, nil );
	if ( col_saved != nil ) then
		color = col_saved:ToColor()
	end

	button:SetColor( color or color_Error )

	button.DoClick = function( self )
		local col = self:GetColor() or color_Error
		panel:OnValueChanged( col )
		panel:UpdateConVars( col )
		panel:DoClick( col, button )
	end

	button.DoRightClick = function( self )
		panel:OnRightClickButton( self )
	end

	return button

end

--[[---------------------------------------------------------
	Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetSize( 80, 120 )
	self:SetNumRows( 8 )
	self:Reset()
	self:SetCookieName( "palette" )
	
	self:SetButtonSize( 10 )
		// add
	self:SetDraggable( true )
	self.select = false
	self.build = false
	self.Dragging = {}
	self.mouse = false
	self.ToleranceHorizontal = false
	self.ToleranceVertical = false
	self.mpos = {x=0,y=0}
	self.sizebutton = {}
	self:SetMinWidth(25)
	self:SetMinHeight(25)

	for i=1,3 do
		self.sizebutton[i] = vgui.Create("DDSButton",self)
	    self.sizebutton[i]:SetVisible(false)
		
	end
end

--[[---------------------------------------------------------
	Buildmode
-----------------------------------------------------------]]
function PANEL:Buildmode( b )

	self.build = b

end

--[[---------------------------------------------------------
	select
-----------------------------------------------------------]]
function PANEL:Select( b )

	self.select = b


end
--[[---------------------------------------------------------
	IsSelected
-----------------------------------------------------------]]
function PANEL:IsSelected()

	return self.select

end

--[[---------------------------------------------------------
	SetTolerance
-----------------------------------------------------------]]
function PANEL:SetHorizontalTolerance( bool )

self.ToleranceHorizontal = bool

end

function PANEL:SetVerticalTolerance( bool ) 

self.ToleranceVertical = bool


end

--[[---------------------------------------------------------
	Think 
-----------------------------------------------------------]]
function PANEL:Think()

	local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	if( self.select and self.build ) then
		for i=1,3 do
				
			self.sizebutton[i]:SetSize(5,5)
			
		    if( i == 1 ) then
			self.sizebutton[i]:SetPos(self:GetWide()-5,self:GetTall() * 0.5 - 2.5)
			self.sizebutton[i]:SetType("sizewe") -- <=> sizewe sizeall


			elseif( i == 2 ) then
			self.sizebutton[i]:SetPos(self:GetWide() * 0.5 - 2.5,self:GetTall()-5)
			self.sizebutton[i]:SetType("sizens") -- |

			elseif( i == 3 ) then
			self.sizebutton[i]:SetPos(self:GetWide()-5,self:GetTall()-5)
			self.sizebutton[i]:SetType("sizenwse") -- \

			end
			
			self.sizebutton[i]:SetVisible(true)
	
		end
	else
		for i=1,3 do
		self.sizebutton[i]:SetVisible(false)
		end
	end
	if ( self.select and self.build  and self.mouse ) then

		self:SetCursor("sizeall")
		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]
		if( self.ToleranceVertical ) then
			if( self.mpos.x < mousex - self.Dragging[1] and mousex -  self.Dragging[1] < self.mpos.x + 30 ) then -- nach rechts
				self.y = y
				return
			elseif( self.mpos.x > mousex - self.Dragging[1] and mousex -  self.Dragging[1] > self.mpos.x - 30 ) then -- nach links
				self.y = y
				return
			end
		end

		if( self.ToleranceHorizontal ) then
			if( self.mpos.y < mousey - self.Dragging[2] and mousey - self.Dragging[2] < self.mpos.y + self:GetTall() * 0.5 ) then
				self.x = x
				return
			elseif( self.mpos.y > mousey - self.Dragging[2] and mousey - self.Dragging[2] > self.mpos.y - self:GetTall() * 0.5) then
				self.x = x
				return
			end
		end
			self:SetPos( x, y )

	else

	self:SetCursor( "arrow" )
	end

end

--[[---------------------------------------------------------
	OnMousePressed
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )
self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
if( mousecode != MOUSE_LEFT ) then return end
	self.mouse = true
if(!self.build ) then

else
self.select = true
self.mpos.x = self.x
self.mpos.y = self.y
	if ( self.m_bSizable and self.select ) then
	
		if ( gui.MouseX() > (self.x + self:GetWide() - 5) &&
			gui.MouseY() > (self.y + self:GetTall() - 5) ) then			
	
			self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
			self:MouseCapture( true )
			return
		end
		
	end
end

end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )
if( mousecode != MOUSE_LEFT ) then return end
if(!self.build ) then

else

	self.mouse = false
end

	self.Sizing = nil
	self:MouseCapture( false )

end

--[[---------------------------------------------------------
	Name: DoClick
-----------------------------------------------------------]]
function PANEL:DoClick( color, button )

	-- Override

end

--[[---------------------------------------------------------
	Name: Reset
-----------------------------------------------------------]]
function PANEL:Reset()

	self:SetColorButtons( CreateColorTable( self:GetNumRows() ) )

end

function PANEL:PaintOver( w, h )

	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawOutlinedRect( 0, 0, w, h )

end

--[[---------------------------------------------------------
	Name: SetColorButtons
-----------------------------------------------------------]]
function PANEL:SetColorButtons( tab )

	self:Clear()

	for i, color in pairs( tab or {} ) do

		local index = tonumber( i )
		if ( !index ) then break end

		AddButton( self, color, self.m_buttonsize, i )

	end

	self:InvalidateLayout()

end

--[[---------------------------------------------------------
	Name: SetButtonSize
-----------------------------------------------------------]]
function PANEL:SetButtonSize( val )

	self.m_buttonsize = math.floor( val )

	for k, v in pairs( self:GetChildren() ) do
		v:SetSize( self.m_buttonsize, self.m_buttonsize )	
	end

	self:InvalidateLayout()

end

--[[---------------------------------------------------------
	Name: UpdateConVar
-----------------------------------------------------------]]
function PANEL:UpdateConVar( strName, strKey, color )

	if ( !strName ) then return end

	RunConsoleCommand( strName, tostring( color[ strKey ] ) )

end

--[[---------------------------------------------------------
	Name: UpdateConVars
-----------------------------------------------------------]]
function PANEL:UpdateConVars( color )

	self:UpdateConVar( self.m_ConVarR, 'r', color )
	self:UpdateConVar( self.m_ConVarG, 'g', color )
	self:UpdateConVar( self.m_ConVarB, 'b', color )
	self:UpdateConVar( self.m_ConVarA, 'a', color )

end

--[[---------------------------------------------------------
	Name: SaveColor
-----------------------------------------------------------]]
function PANEL:SaveColor( btn, color )

	-- Avoid unintended color changing.
	color = table.Copy( color or color_Error ) 

	btn:SetColor( color )
	self:SetCookie( "col."..btn:GetID(), string.FromColor( color ) );

end

--
-- TODO: This should mark this colour as selected..
--
function PANEL:SetColor( newcol )

end

--
-- For override
--

function PANEL:OnValueChanged( newcol )

end

function PANEL:OnRightClickButton( btn )

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetSize( 256, 256 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RColorPalette", "", PANEL, "RIconLayout" )