--[[---------------------------------------------------------
 ## NAME: FlatUI Tabmenu ##
-----------------------------------------------------------]]
local PANEL = {}
AccessorFunc( PANEL, "m_cbackground", 			"Background" )

--[[---------------------------------------------------------
NAME: Init( void )
desc: 
-----------------------------------------------------------]]
function PANEL:Init()

	self.tabs = {}
	self.panel = {}
	
	self.count = 0
	self.selectede = {}
	self:SetBackground( Color( 52, 73, 94, 255 ) )

end

--[[---------------------------------------------------------
NAME: Paint( number, number )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h ) --tabcolor

	surface.SetDrawColor( self.m_cbackground )
	surface.DrawRect(0,0,w,h)

	surface.SetDrawColor( 44, 61, 79, 255 )
	surface.DrawRect( 0, h-1, w, 1 )
	
end

--[[---------------------------------------------------------
NAME: AddTab( string )
desc: 
-----------------------------------------------------------]]
function PANEL:AddTab( name ) 

	self.count = self.count + 1

	self.tabs[self.count] = vgui.Create("FlatButton", self )
	self.tabs[self.count]:SetAlign(0)
	self.tabs[self.count]:SetPos( 0, ( self.count - 1 ) * self:GetTall() / 8 )
	self.tabs[self.count]:SetSize(self:GetWide(),self:GetTall() / 8)
	self.tabs[self.count]:SetText( name )
	self.tabs[self.count]:SetBackground( Color( 42, 42, 42, 255 ) )
	self.tabs[self.count].Paint = function( self, w, h )

	col = self:GetBackground()

	surface.SetDrawColor( col ) 
	surface.DrawRect( 0,0,w,h)

	if ( self.m_bselect )	then
		surface.SetDrawColor( Color( math.floor( col.r * .815 ) ,math.floor( col.g * 1.3 ) ,math.floor(col.b * 2.21), 255 ) )
		surface.DrawRect(0,0,w,h)
	end

		if( self:IsHovered() ) then
		surface.SetDrawColor( Color( math.floor( col.r * .815 ) ,math.floor( col.g * 1.3 ) ,math.floor(col.b * 2.21), 255 ) ) 
		surface.DrawRect( 0,0,w,h)
		surface.SetDrawColor( math.floor( col.r * .975 ), math.floor( col.g * 1.3 ), math.floor( col.b * 2.623 ), 255 )
		surface.DrawRect( 0, 0, w, 1 )
		surface.SetDrawColor( math.floor( col.r * .5695 ), math.floor( col.g * .8435 ), math.floor( col.b * 1.3115 ), 255 )
		surface.DrawRect( 0, h-1, w, 1 )
		
	else


		surface.SetDrawColor( math.floor( col.r * 1.02315 ), math.floor( col.g * 1.122 ), math.floor(col.b * 1.344 ), 255 )
		surface.DrawRect( 0, 0, w, 1 )
	
		surface.SetDrawColor( math.floor( col.r * .829) , math.floor( col.g * .66087 ), math.floor( col.b * .574 ), 255 )
		surface.DrawRect( 0, h-1, w, 1 )
	end

	end

	self.panel[self.count] = vgui.Create("DPanel", self:GetParent() )
	self.panel[self.count]:SetPos( self:GetWide(), self.y)
	self.panel[self.count]:SetSize( self:GetParent():GetWide() - self:GetWide(), self:GetParent():GetTall()-30)
	
	self.panel[self.count]:SetBackgroundColor(  Color( math.floor( 42 * .815 ) ,math.floor( 42 * 1.3 ) ,math.floor(42 * 2.21), 255 ) )
	
end

--[[---------------------------------------------------------
NAME: Paint( number, number )
desc: 
-----------------------------------------------------------]]
function PANEL:AddItem( item , value )

	if( istable( item ) ) then
		for k,v in ipairs( item ) do
			v:SetParent( self.panel[value]  )
		end
	else
		item:SetParent( self.panel[value]  )
	end
end


--[[---------------------------------------------------------
NAME: SelectByIndex( number )
desc: 
-----------------------------------------------------------]]
function PANEL:SelectByIndex( index )

	self.tabs[ index ]:SetSelect( true )

end

--[[---------------------------------------------------------
NAME: Overwrite( void )
desc: 
-----------------------------------------------------------]]
function PANEL:OverWrite()

end

--[[---------------------------------------------------------
NAME: Think( void )
desc: 
-----------------------------------------------------------]]
function PANEL:Think()
	for k,v in ipairs( self.tabs ) do
	
		if( v:GetSelect() ) then
			if( table.HasValue( self.selectede, v ) ) then
			else
				if( #self.selectede > 0 ) then
					self.selectede[1]:SetSelect(false)
					self.panel[k]:SetVisible(false)
					self.panel[k]:SetZPos( 100 )
					table.Empty( self.selectede )
				end 
				table.insert( self.selectede, v )
				self.panel[k]:SetVisible(true)
				self.panel[k]:SetZPos( 1 )
			end
		end
	end
self:OverWrite()

	for k,v in ipairs( self.panel ) do

		if( k != table.KeyFromValue( self.tabs, self.selectede[1] ) ) then

			for a,b in ipairs( v:GetChildren() ) do

				b:SetVisible(false)

			end
		else
			for a,b in ipairs( v:GetChildren() ) do

				b:SetVisible(true)

			end
		end

	end

end

--[[---------------------------------------------------------
NAME: PerformLayout( number, number )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	if( #self.tabs > 0 ) then
		self.tabs[1]:SetSelected( true )
	end

end

--[[---------------------------------------------------------
NAME: Close( void )
desc: 
-----------------------------------------------------------]]
function PANEL:Close( )

	self:Remove( )

end

derma.DefineControl( "FlatDashTab", "A Menu App", PANEL, "DPanel" )