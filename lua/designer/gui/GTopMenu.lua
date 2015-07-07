--[[   _                                

					|Royal|
--]]

PANEL = {}

--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()

	self.tabs = {}
	self.panel = {}

	self.count = 1
	self.selectede = {}
	self.parent = nil
	self.color = Color(29,29,29,255)

end

function PANEL:GetParent( pnl )

	self.parent = pnl

end

function PANEL:SetColor( color )

	self.color = color

end
--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(29,29,29,255)
	surface.DrawRect(0,0,w,h)

end

function PANEL:AddTab( name ) 

	
	self.tabs[self.count] = vgui.Create("GButton", self )
	self.tabs[self.count]:SetPos( 20+(140*(self.count-1)), 0)
	self.tabs[self.count]:SetSize(120,self:GetTall())
	self.tabs[self.count]:SetText( name )
	self.tabs[self.count]:SetColor( self.color )

	self.panel[self.count] = vgui.Create("DPanel", self.parent )
	self.panel[self.count]:SetPos( self.x, self.y+self:GetTall())
	self.panel[self.count]:SetSize(self:GetWide()-1,self.parent:GetTall()-(self.y+self:GetTall()+5))
	self.panel[self.count]:SetBackgroundColor( Color(255,255,255,255) )

	self.count = self.count + 1
end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:AddItem( item , value )



		item:SetParent( self.panel[value]  )

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )


end//SetVisible

function PANEL:OverWrite()


end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()
	for k,v in ipairs( self.tabs ) do
	
		if( v:IsSelected() ) then
			if( table.HasValue( self.selectede, v ) ) then
			else
				if( #self.selectede > 0 ) then
					self.selectede[1]:SetSelected(false)
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
end



--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	if( #self.tabs > 0 ) then
		self.tabs[1]:SetSelected( true )
	end




end

--[[---------------------------------------------------------
NAME: Close()
desc: 
-----------------------------------------------------------]]
function PANEL:Close()

	self:Remove()

end

--[[---------------------------------------------------------
NAME: IsActive()
desc: 
-----------------------------------------------------------]]
function PANEL:IsActive()

	if ( self:HasFocus() ) then return true end
	if ( vgui.FocusedHasParent( self ) ) then return true end
	
	return false

end

derma.DefineControl( "GTab", "A Menu App", PANEL, "DPanel" )


