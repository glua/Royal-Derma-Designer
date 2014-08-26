--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DComboBox

--]]

PANEL = {}


AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )
Derma_Install_Convar_Functions( PANEL )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self.DropButton = vgui.Create( "RPanel", self )
	self.DropButton.Parent = self	

	self.DropButton:SetMouseInputEnabled( true )
	self.DropButton.ComboBox = self
	
	self.DropButton.Paint = function( panel, w, h )  derma.SkinHook( "Paint", "ComboDownArrow", panel, w, h ) end 
	self.DropButton.OnMousePressed = function(self) self.Parent:OnMousePressed() end
	self.DropButton.OnMouseReleased = function(self) self.Parent:OnMouseReleased() end
	self:SetTall( 22 )
	self:Clear()
	
	self:SetContentAlignment( 4 )
	self:SetTextInset( 8, 0 )
	self:SetIsMenu( true )

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

function PANEL:Paint( w, h )
if( self.select and self.build ) then 
surface.SetDrawColor(0,0,0,255) 
surface.DrawOutlinedRect(0,0,w,h) 
else
derma.SkinHook( "Paint", "ComboBox", self, w-1, h-1 )
end

end
--[[---------------------------------------------------------
   Name: Clear
-----------------------------------------------------------]]
function PANEL:Clear()

	self:SetText( "" )
	self.Choices = {}
	self.Data = {}

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end
	
end

--[[---------------------------------------------------------
   Name: GetOptionText
-----------------------------------------------------------]]
function PANEL:GetOptionText( id )

	return self.Choices[ id ]

end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self.DropButton:SetSize( 15, 15 )
	self.DropButton:AlignRight( 4 )
	self.DropButton:CenterVertical()

end

--[[---------------------------------------------------------
   Name: ChooseOption
-----------------------------------------------------------]]
function PANEL:ChooseOption( value, index )

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self:SetText( value )
	self:OnSelect( index, value, self.Data[index] )
	
end

--[[---------------------------------------------------------
   Name: ChooseOptionID
-----------------------------------------------------------]]
function PANEL:ChooseOptionID( index )

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	local value = self:GetOptionText( index )
	self:SetText( value )

	self:OnSelect( index, value, self.Data[index] )
	
end



--[[---------------------------------------------------------
   Name: OnSelect
-----------------------------------------------------------]]
function PANEL:OnSelect( index, value, data )

	-- For override

end

--[[---------------------------------------------------------
   Name: AddChoice
-----------------------------------------------------------]]
function PANEL:AddChoice( value, data, select )

	local i = table.insert( self.Choices, value )
	
	if ( data ) then
		self.Data[ i ] = data
	end

	if ( select ) then

		self:ChooseOption( value, i )

	end
	
	return i

end

function PANEL:IsMenuOpen()

	return IsValid( self.Menu ) && self.Menu:IsVisible()

end

--[[---------------------------------------------------------
   Name: OpenMenu
-----------------------------------------------------------]]
function PANEL:OpenMenu( pControlOpener )

	if ( pControlOpener ) then
		if ( pControlOpener == self.TextEntry ) then
			return
		end
	end

	-- Don't do anything if there aren't any options..
	if ( #self.Choices == 0 ) then return end
	
	-- If the menu still exists and hasn't been deleted
	-- then just close it and don't open a new one.
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self.Menu = DermaMenu()
	
		for k, v in pairs( self.Choices ) do
			self.Menu:AddOption( v, function() self:ChooseOption( v, k ) end )
		end
		
		local x, y = self:LocalToScreen( 0, self:GetTall() )
		
		self.Menu:SetMinimumWidth( self:GetWide() )
		self.Menu:Open( x, y, false, self )		
		

end

function PANEL:CloseMenu()
	
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
	end	
	
end

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
			self:ConVarNumberThink()
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

function PANEL:SetValue( strValue )

	self:SetText( strValue )

end

function PANEL:DoClick()

	if ( self:IsMenuOpen() ) then
		return self:CloseMenu()
	end
	
	self:OpenMenu()

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:AddChoice( "Some Choice" )
		ctrl:AddChoice( "Another Choice" )
		ctrl:SetWide( 150 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RComboBox", "", PANEL, "RButton" )
