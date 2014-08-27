
local PANEL = {}

AccessorFunc( PANEL, "m_bChecked", 		"Checked", 		FORCE_BOOL )

Derma_Hook( PANEL, "Paint", "Paint", "CheckBox" )
Derma_Hook( PANEL, "ApplySchemeSettings", "Scheme", "CheckBox" )
Derma_Hook( PANEL, "PerformLayout", "Layout", "CheckBox" )


Derma_Install_Convar_Functions( PANEL )

--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetSize( 15, 15 )
	self:SetText( "" )


end

function PANEL:IsEditing()
	return self.Depressed
end

--[[---------------------------------------------------------
   Name: SetValue
-----------------------------------------------------------]]
function PANEL:SetValue( val )

	val = tobool( val )

	self:SetChecked( val )
	self.m_bValue = val
	
	self:OnChange( val )
	
	if ( val ) then val = "1" else val = "0" end	
	self:ConVarChanged( val )

end

--[[---------------------------------------------------------
   Name: DoClick
-----------------------------------------------------------]]
function PANEL:DoClick()

	self:Toggle()

end

--[[---------------------------------------------------------
   Name: Toggle
-----------------------------------------------------------]]
function PANEL:Toggle()

	if ( self:GetChecked() == nil || !self:GetChecked() ) then
		self:SetValue( true )
	else
		self:SetValue( false )
	end

end

--[[---------------------------------------------------------
   Name: OnChange
-----------------------------------------------------------]]
function PANEL:OnChange( bVal )

	-- For override

end

--[[---------------------------------------------------------
	Think
-----------------------------------------------------------]]
function PANEL:Think()

	self:ConVarStringThink()

end

derma.DefineControl( "RCheckBox", "Simple Checkbox", PANEL, "RButton" )


local PANEL = {}
AccessorFunc( PANEL, "m_iIndent", 		"Indent" )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetTall( 16 )
	self.Button = vgui.Create( "RCheckBox", self )
	function self.Button.OnChange( _, val ) self:OnChange( val ) end

	
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
	self:SetMinWidth(5)
	self:SetMinHeight(5)

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
	Think
-----------------------------------------------------------]]
function PANEL:Think()

local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
	

		if( self.select  and self.build) then

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

	if ( self.select and self.build and self.mouse ) then
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
	SetTolerance
-----------------------------------------------------------]]
function PANEL:SetHorizontalTolerance( bool )

self.ToleranceHorizontal = bool

end

function PANEL:SetVerticalTolerance( bool ) 

self.ToleranceVertical = bool


end

function PANEL:SetDark( b )
	if ( self.Label ) then
		self.Label:SetDark( b )
	end
end

--[[---------------------------------------------------------
   Name: SetConVar
-----------------------------------------------------------]]
function PANEL:SetConVar( cvar )
	self.Button:SetConVar( cvar )
end

--[[---------------------------------------------------------
   Name: SetValue
-----------------------------------------------------------]]
function PANEL:SetValue( val )
	self.Button:SetValue( val )
end

--[[---------------------------------------------------------
   Name: SetChecked
-----------------------------------------------------------]]
function PANEL:SetChecked( val )
	self.Button:SetChecked( val )
end

--[[---------------------------------------------------------
   Name: GetChecked
-----------------------------------------------------------]]
function PANEL:GetChecked( val )
	return self.Button:GetChecked()
end

--[[---------------------------------------------------------
   Name: SetValue
-----------------------------------------------------------]]
function PANEL:Toggle()
	self.Button:Toggle()
end


--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	local x = self.m_iIndent or 0

	self.Button:SetSize( 15, 15 )
	self.Button:SetPos( x, 0 )
	
	if ( self.Label ) then
		self.Label:SizeToContents()
		self.Label:SetPos( x + 14 + 10, 0 )
	end



end

--[[---------------------------------------------------------
   Name: SetTextColor
-----------------------------------------------------------]]
function PANEL:SetTextColor( color )

	self.Label:SetTextColor( color )

end


--[[---------------------------------------------------------
	SizeToContents
-----------------------------------------------------------]]
function PANEL:SizeToContents()

	self:PerformLayout( true )
	self:SetWide( self.Label.x + self.Label:GetWide() )
	self:SetTall( self.Button:GetTall() )
	
end

--[[---------------------------------------------------------
   Name: SetConVar
-----------------------------------------------------------]]
function PANEL:SetText( text )

	if ( !self.Label ) then
		self.Label = vgui.Create( "RLabel", self )
		self.Label:SetMouseInputEnabled( true )
		self.Label.DoClick = function() self:Toggle() end
	end
	
	self.Label:SetText( text )
	self:InvalidateLayout()

end


function PANEL:OnMousePressed( mousecode )

self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }


if(!self.build ) then

else
if( mousecode != MOUSE_LEFT ) then return end
	self.mouse = true
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
if(!self.build ) then
	return DLabel.OnMouseReleased( self, mousecode )
else


	self.mouse = false
end


if( mousecode != MOUSE_LEFT ) then return end
	self.Sizing = nil
	self:MouseCapture( false )


end

--[[---------------------------------------------------------
   Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint()

	if( self.select and self.build ) then
		surface.SetDrawColor(0,0,0,255)
		surface.DrawOutlinedRect(0,0,w,h)
	end

end

--[[---------------------------------------------------------
   Name: OnChange
-----------------------------------------------------------]]
function PANEL:OnChange( bVal )

	-- For override

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetText( "CheckBox" )
		ctrl:SetWide( 200 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RCheckBoxLabel", "Simple Checkbox", PANEL, "RPanel" )