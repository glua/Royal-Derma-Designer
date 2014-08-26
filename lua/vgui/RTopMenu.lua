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

end

function PANEL:GetParent( pnl )

	self.parent = pnl

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



	self.count = self.count + 1
end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:AddItem( item , value )





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

					table.Empty( self.selectede )
				end 
				table.insert( self.selectede, v )

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

derma.DefineControl( "RTab", "A Menu App", PANEL, "DPanel" )


