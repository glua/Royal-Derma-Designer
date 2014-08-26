--[[
	 _
	( )
   _| |   __   _ __   ___ ___     _ _
 /´_` | /´__`\( '__)/´ _ ` _ `\ /´_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_)

	DColorMixer
--]]


local PANEL = {}


AccessorFunc( PANEL, "m_ConVarR", "ConVarR" )
AccessorFunc( PANEL, "m_ConVarG", "ConVarG" )
AccessorFunc( PANEL, "m_ConVarB", "ConVarB" )
AccessorFunc( PANEL, "m_ConVarA", "ConVarA" )

AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

AccessorFunc( PANEL, "m_bPalette", "Palette", FORCE_BOOL )
AccessorFunc( PANEL, "m_bAlpha", "AlphaBar", FORCE_BOOL )
AccessorFunc( PANEL, "m_bWangsPanel", "Wangs", FORCE_BOOL )

AccessorFunc( PANEL, "m_Color", "Color" )

local BarWide = 26

local function CreateWangFunction( self, colindex )
	local function OnValueChanged( ptxt, strvar )
		if ( ptxt.notuserchange ) then return end

		self.m_Color[colindex] = tonumber( strvar ) or 0
		if ( colindex == "a" ) then
			self.Alpha:SetBarColor( ColorAlpha( self.m_Color, 255 ) )
			self.Alpha:SetValue( self.m_Color.a / 255 )
		else
			self.HSV:SetColor( self.m_Color )

			local h, s, v = ColorToHSV( self.HSV:GetBaseRGB() )
			self.RGB.LastY = ( 1 - h / 360 ) * self.RGB:GetTall()
		end

		self:UpdateColor( self.m_Color )
	end 

	return OnValueChanged
end

--[[---------------------------------------------------------
	Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	-- The defaults
	self.m_bPalette = true
	self.m_bAlpha = true
	self.m_bWangsPanel = true
	self.m_Color = Color( 255, 0, 0, 255 )

	self.Palette = vgui.Create( "DColorPalette", self )
	self.Palette:Dock( BOTTOM )
	self.Palette:SetVisible( self.m_bPalette )
	self.Palette:SetTall( 75 )
	self.Palette:SetButtonSize( 16 )
	self.Palette:DockMargin( 0, 8, 0, 0 )
	self.Palette:Reset()
	self.Palette.DoClick = function( ctrl, color, btn )
		self:SetColor( Color( color.r, color.g, color.b, self.m_bAlpha and color.a or 255 ) )
	end
	self.Palette.OnRightClickButton = function( ctrl, btn )
		ctrl:SaveColor( btn, self:GetColor() );
	end
	

	-- The label
	self.label = vgui.Create( "DLabel", self )
	self.label:SetText( "" )
	self.label:Dock( TOP )
	self.label:SetDark( true )
	self.label:SetVisible( false )

	--The number stuff
	self.WangsPanel = vgui.Create( "DPanel", self )
	self.WangsPanel:SetWide( 50 )
	self.WangsPanel:Dock( RIGHT )
	self.WangsPanel:DockMargin( 4, 0, 0, 0 )
	self.WangsPanel:SetVisible( self.m_bWangsPanel )

	self.txtR = self.WangsPanel:Add( "DNumberWang" )
		self.txtR:SetDecimals( 0 )
		self.txtR:SetMinMax( 0, 255 )
		self.txtR:SetTall( 20 )
		self.txtR:Dock( TOP )
		self.txtR:DockMargin( 0, 4, 0, 0 )
		self.txtR:SetTextColor( Color( 150, 0, 0, 255 ) )

	self.txtG = self.WangsPanel:Add( "DNumberWang" )
		self.txtG:SetDecimals( 0 )
		self.txtG:SetMinMax( 0, 255 )
		self.txtG:SetTall( 20 )
		self.txtG:Dock( TOP )
		self.txtG:DockMargin( 0, 4, 0, 0 )
		self.txtG:SetTextColor( Color( 0, 150, 0, 255 ) )

	self.txtB = self.WangsPanel:Add( "DNumberWang" )
		self.txtB:SetDecimals( 0 )
		self.txtB:SetMinMax( 0, 255 )
		self.txtB:SetTall( 20 )
		self.txtB:Dock( TOP )
		self.txtB:DockMargin( 0, 4, 0, 0 )
		self.txtB:SetTextColor( Color( 0, 0, 150, 255 ) )

	self.txtA = self.WangsPanel:Add( "DNumberWang" )
		self.txtA:SetDecimals( 0 )
		self.txtA:SetMinMax( 0, 255 )
		self.txtA:SetTall( 20 )
		self.txtA:Dock( TOP )
		self.txtA:DockMargin( 0, 4, 0, 0 )
		self.txtA:SetTextColor( Color( 80, 80, 80, 255 ) )

	self.txtR.OnValueChanged = CreateWangFunction( self, "r" )
	self.txtG.OnValueChanged = CreateWangFunction( self, "g" )
	self.txtB.OnValueChanged = CreateWangFunction( self, "b" )
	self.txtA.OnValueChanged = CreateWangFunction( self, "a" )

	-- The colouring stuff
	self.HSV = vgui.Create( "DColorCube", self )
	self.HSV:Dock( FILL )
	self.HSV.OnUserChanged = function( ctrl, color )
		color.a = self.m_Color.a
		self:UpdateColor( color )
	end

	self.RGB = vgui.Create( "DRGBPicker", self )
	self.RGB:Dock( RIGHT )
	self.RGB:SetWidth( BarWide )
	self.RGB:DockMargin( 4, 0, 0, 0 )
	self.RGB.OnChange = function( ctrl, color )
		self:SetBaseColor( color )
	end


	self.Alpha = vgui.Create( "DAlphaBar", self )
	self.Alpha:DockMargin( 4, 0, 0, 0 )
	self.Alpha:Dock( RIGHT )
	self.Alpha:SetVisible( self.m_bAlpha )
	self.Alpha:SetWidth( BarWide )
	self.Alpha.OnChange = function( ctrl, fAlpha )
		self.m_Color.a = math.floor( fAlpha * 255 )
		self:UpdateColor( self.m_Color )
	end


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

	-- Layout
	self:UpdateColor( self.m_Color )
	self:SetSize( 256, 230 )
	self:InvalidateLayout()

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

	--self.select = false
	self.mouse = false
end
--	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )

end

--[[---------------------------------------------------------
	Name: SetLabel
-----------------------------------------------------------]]
function PANEL:SetLabel( text )

	if ( !text or ( text == "" ) ) then
		self.label:SetVisible( false )
	
		return
	end

	self.label:SetText( text )
	self.label:SetVisible( true )

	self:InvalidateLayout()
end


--[[---------------------------------------------------------
	Name: SetPalette
-----------------------------------------------------------]]
function PANEL:SetPalette( bEnabled )
	self.m_bPalette = bEnabled

	local Palette = self.Palette
	Palette:SetVisible( bEnabled )

	self:InvalidateLayout()
end

--[[---------------------------------------------------------
	Name: SetAlphaBar
-----------------------------------------------------------]]
function PANEL:SetAlphaBar( bEnabled )
	self.m_bAlpha = bEnabled

	local Alpha = self.Alpha
	Alpha:SetVisible( bEnabled )

	local AlphaWang = self.txtA
	AlphaWang:SetVisible( bEnabled )

	self:InvalidateLayout()
end

--[[---------------------------------------------------------
	Name: SetWangs
-----------------------------------------------------------]]
function PANEL:SetWangs( bEnabled )
	self.m_bWangsPanel = bEnabled

	local WangsPanel = self.WangsPanel
	WangsPanel:SetVisible( bEnabled )

	self:InvalidateLayout()
end

--[[---------------------------------------------------------
	Name: ConVarR
-----------------------------------------------------------]]
function PANEL:SetConVarR( cvar )
	self.m_ConVarR = cvar
end

--[[---------------------------------------------------------
	Name: ConVarG
-----------------------------------------------------------]]
function PANEL:SetConVarG( cvar )
	self.m_ConVarG = cvar
end

--[[---------------------------------------------------------
	Name: ConVarB
-----------------------------------------------------------]]
function PANEL:SetConVarB( cvar )
	self.m_ConVarB = cvar
end

--[[---------------------------------------------------------
	Name: SetConVarA
-----------------------------------------------------------]]
function PANEL:SetConVarA( cvar )
	self.m_ConVarA = cvar
	self:SetAlphaBar( cvar != nil )
end

--[[---------------------------------------------------------
	Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout( x, y )

	local h, s, v = ColorToHSV( self.HSV:GetBaseRGB() )
	self.RGB.LastY = ( 1 - h / 360 ) * self.RGB:GetTall()

end

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint()
	-- Invisible background!
		if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	else
		end
end

--[[---------------------------------------------------------
	Name: TranslateValues ( Todo? )
-----------------------------------------------------------]]
function PANEL:TranslateValues( x, y )
	
end

--[[---------------------------------------------------------
	Name: SetColor
-----------------------------------------------------------]]
function PANEL:SetColor( color )
	local h, s, v = ColorToHSV( color )
	self.RGB.LastY = ( 1 - h / 360 ) * self.RGB:GetTall()

	self.HSV:SetColor( color )

	self:UpdateColor( color )
end


function PANEL:SetVector( vec )

	self:SetColor( Color( vec.x * 255, vec.y * 255, vec.z * 255, 255 ) )

end

--[[---------------------------------------------------------
	Name: SetBaseColor
-----------------------------------------------------------]]
function PANEL:SetBaseColor( color )
	self.HSV:SetBaseRGB( color )
	self.HSV:TranslateValues()
end


--[[---------------------------------------------------------
	Name: UpdateConVar
-----------------------------------------------------------]]
function PANEL:UpdateConVar( strName, strKey, color )

	if ( !strName ) then return end
	local col = color[strKey]

	RunConsoleCommand( strName, tostring( col ) )

	self[ 'ConVarOld'..strName ] = col
end

--[[---------------------------------------------------------
	Name: UpdateConVars
-----------------------------------------------------------]]
function PANEL:UpdateConVars( color )

	self.NextConVarCheck = SysTime() + 0.2

	self:UpdateConVar( self.m_ConVarR, 'r', color )
	self:UpdateConVar( self.m_ConVarG, 'g', color )
	self:UpdateConVar( self.m_ConVarB, 'b', color )
	self:UpdateConVar( self.m_ConVarA, 'a', color )

end

--[[---------------------------------------------------------
	Name: UpdateColor
-----------------------------------------------------------]]
function PANEL:UpdateColor( color )
	self.Alpha:SetBarColor( ColorAlpha( color, 255 ) )
	self.Alpha:SetValue( color.a / 255 )

	local r, g, b, a = color.r, color.g, color.b, color.a
	local r_old, g_old, b_old, a_old = self.txtR:GetValue(), self.txtG:GetValue(), self.txtB:GetValue(), self.txtA:GetValue()

	if ( r ~= r_old ) then
		self.txtR.notuserchange = true
		self.txtR:SetValue( r )
		self.txtR.notuserchange = nil
	end

	if ( g ~= g_old ) then
		self.txtG.notuserchange = true
		self.txtG:SetValue( g )
		self.txtG.notuserchange = nil
	end

	if ( b ~= b_old ) then
		self.txtB.notuserchange = true
		self.txtB:SetValue( b )
		self.txtB.notuserchange = nil
	end

	if ( a ~= a_old ) then
		self.txtA.notuserchange = true
		self.txtA:SetValue( a )
		self.txtA.notuserchange = nil
	end

	self:UpdateConVars( color )
	self:ValueChanged( color )

	self.m_Color = color
end

--[[---------------------------------------------------------
	Name: ValueChanged
-----------------------------------------------------------]]
function PANEL:ValueChanged( color )
	-- Override
end

--[[---------------------------------------------------------
	Name: GetColor
-----------------------------------------------------------]]
function PANEL:GetColor()

	self.m_Color.a = 255
	if ( self.Alpha:IsVisible() ) then
		self.m_Color.a = math.floor( self.Alpha:GetValue() * 255 )
	end

	return self.m_Color
end

function PANEL:GetVector()

	local col = self:GetColor();
	return Vector( col.r / 255, col.g / 255, col.b / 255 )

end

--[[---------------------------------------------------------
	Name: Think
-----------------------------------------------------------]]
function PANEL:Think()

	self:ConVarThink()

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
	Name: ConVarThink
-----------------------------------------------------------]]
function PANEL:ConVarThink()

	-- Don't update the convars while we're changing them!
	if ( input.IsMouseDown( MOUSE_LEFT ) ) then return end
	if ( self.NextConVarCheck > SysTime() ) then return end

	local r, changed_r = self:DoConVarThink( self.m_ConVarR )
	local g, changed_g = self:DoConVarThink( self.m_ConVarG )
	local b, changed_b = self:DoConVarThink( self.m_ConVarB )
	local a, changed_a = 255, false

	if ( self.m_ConVarA ) then 
		a, changed_a = self:DoConVarThink( self.m_ConVarA, 'a' )
	end

	if ( changed_r or changed_g or changed_b or changed_a ) then
		self:SetColor( Color( r, g, b, a ) )
	end
end

--[[---------------------------------------------------------
	Name: DoConVarThink
-----------------------------------------------------------]]
function PANEL:DoConVarThink( convar )

	if ( !convar ) then return end

	local fValue = GetConVarNumber( convar )
	local fOldValue = self[ 'ConVarOld'..convar ]
	if ( fOldValue && fValue == fOldValue ) then return fOldValue, false end

	self[ 'ConVarOld'..convar ] = fValue

	return fValue, true

end

--[[---------------------------------------------------------
	Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetSize( 256, 256 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RColorMixer", "", PANEL, "RPanel" )