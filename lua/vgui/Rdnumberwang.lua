--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DNumberWang

--]]

local PANEL = {}

AccessorFunc( PANEL, "m_numMin", 		"Min" )
AccessorFunc( PANEL, "m_numMax", 		"Max" )
AccessorFunc( PANEL, "m_iDecimals", 	"Decimals" )		-- The number of decimal places in the output
AccessorFunc( PANEL, "m_fFloatValue", 	"FloatValue" )
AccessorFunc( PANEL, "m_bDraggable", 			"Draggable", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_iMinWidth", 			"MinWidth" )
AccessorFunc( PANEL, "m_iMinHeight", 			"MinHeight" )

--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetDecimals( 2 )
	self:SetTall( 20 )
	self:SetMinMax( 0, 100 )
	
	self:SetUpdateOnType( true )
	self:SetNumeric( true )

	self.OnChange = function() self:OnValueChanged( self:GetValue() ) end
		
	self.Up = vgui.Create( "RButton", self )
	self.Up:SetText( "" );
	self.Up.DoClick = function( button, mcode ) self:SetValue( self:GetValue() + 1 ) end
	self.Up.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "NumberUp", panel, w, h ) end
	
	self.Down = vgui.Create( "RButton", self )
	self.Down:SetText( "" );
	self.Down.DoClick = function( button, mcode ) self:SetValue( self:GetValue() - 1 ) end
	self.Down.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "NumberDown", panel, w, h ) end
		
	self:SetValue( 10 )

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
	
	
	if( self.select ) then

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
	OnMousePressed
-----------------------------------------------------------]]
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

	if ( self.Dragging ) then
	--	self:EndWang()
	return end

else


	self.mouse = false
end


if( mousecode != MOUSE_LEFT ) then return end
	self.Sizing = nil
	self:MouseCapture( false )


end



function PANEL:HideWang()

	self.Up:Hide();
	self.Down:Hide();

end

--[[---------------------------------------------------------
	
-----------------------------------------------------------]]
function PANEL:SetDecimals( num )

	self.m_iDecimals = num
	self:SetValue( self:GetValue() )

end



--[[---------------------------------------------------------
	SetMinMax
-----------------------------------------------------------]]
function PANEL:SetMinMax( min, max )

	self:SetMin( min )
	self:SetMax( max )

end

--[[---------------------------------------------------------
	SetMin
-----------------------------------------------------------]]
function PANEL:SetMin( min )

	self.m_numMin = tonumber( min )

end

--[[---------------------------------------------------------
	SetMax
-----------------------------------------------------------]]
function PANEL:SetMax( max )

	self.m_numMax = tonumber( max )

end

--[[---------------------------------------------------------
	GetFloatValue
-----------------------------------------------------------]]
function PANEL:GetFloatValue( max )

	if ( !self.m_fFloatValue ) then m_fFloatValue = 0 end

	return tonumber( self.m_fFloatValue ) or 0

end

--[[---------------------------------------------------------
   Name: SetValue
-----------------------------------------------------------]]
function PANEL:SetValue( val )

	if ( val == nil ) then return end
	
	local OldValue = val
	val = tonumber( val )
	val = val or 0
	
	if ( self.m_numMax != nil ) then
		val = math.min( self.m_numMax, val )
	end
	
	if ( self.m_numMin != nil ) then
		val = math.max( self.m_numMin, val )
	end
	
	if ( self.m_iDecimals == 0 ) then
	
		val = Format( "%i", val )
	
	elseif ( val != 0 ) then
	
		val = Format( "%."..self.m_iDecimals.."f", val )
			
		-- Trim trailing 0's and .'s 0 this gets rid of .00 etc
		val = string.TrimRight( val, "0" )		
		val = string.TrimRight( val, "." )
		
	end
	
	--
	-- Don't change the value while we're typing into it!
	-- It causes confusion!
	--
	if ( !self:HasFocus() ) then
		self:SetText( val )
		self:ConVarChanged( val )
	end
	
	self:OnValueChanged( val )

end

local meta = FindMetaTable( "Panel" )

--[[---------------------------------------------------------
   Name: GetValue
-----------------------------------------------------------]]
function PANEL:GetValue()

	return tonumber( meta.GetValue( self ) ) or 0

end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	local s = math.floor(self:GetTall() * 0.5);

	self.Up:SetSize( s, s-1 )
	self.Up:AlignRight( 3 );
	self.Up:AlignTop(0);
	
	self.Down:SetSize( s, s-1 )
	self.Down:AlignRight( 3 );
	self.Down:AlignBottom(2);

end

--[[---------------------------------------------------------
	SizeToContents
-----------------------------------------------------------]]
function PANEL:SizeToContents()

	-- Size based on the max number and max amount of decimals
	
	local chars = 0
	
	local min = math.Round( self:GetMin(), self:GetDecimals() )
	local max = math.Round( self:GetMax(), self:GetDecimals() )
	
	local minchars = string.len( ""..min.."" )
	local maxchars = string.len( ""..max.."" )
	
	chars = chars + math.max( minchars, maxchars )
	
	if ( self:GetDecimals() && self:GetDecimals() > 0 ) then
	
		chars = chars + 1 -- .
		chars = chars + self:GetDecimals()
	
	end
	
	self:InvalidateLayout( true )
	self:SetWide( chars * 6 + 10 + 5 + 5 )
	self:InvalidateLayout()

end


--[[---------------------------------------------------------
   Name: GetFraction
-----------------------------------------------------------]]
function PANEL:GetFraction( val )

	local Value = val or self:GetValue()

	local Fraction = ( Value - self.m_numMin ) / (self.m_numMax - self.m_numMin)
	return Fraction

end

--[[---------------------------------------------------------
   Name: SetFraction
-----------------------------------------------------------]]
function PANEL:SetFraction( val )

	local Fraction = self.m_numMin + ( (self.m_numMax - self.m_numMin) * val )
	self:SetValue( Fraction )

end


--[[---------------------------------------------------------
   Name: OnValueChanged
-----------------------------------------------------------]]
function PANEL:OnValueChanged( val )

end

--[[---------------------------------------------------------
   Name: GetTextArea
-----------------------------------------------------------]]
function PANEL:GetTextArea()

	return self

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:SetDecimals( 0 )
		ctrl:SetMinMax( 0, 255 )
		ctrl:SetValue( 3 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "RNumberWang", "Menu Option Line", PANEL, "DTextEntry" )
