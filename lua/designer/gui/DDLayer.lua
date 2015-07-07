
PANEL = {}
AccessorFunc( PANEL, "m_stext", 			"Text" )
AccessorFunc( PANEL, "m_iID", 			"ID" )
AccessorFunc( PANEL, "m_bselect", 		"Select", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_tData", 		"Data", 		FORCE_BOOL )
--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetText("")
	self.draw = {}
	self:SetSelect(false)
	self.root = {}
	self.check = vgui.Create("DCheckBox",self)
	

	self.preview = vgui.Create( "DPanel", self )

	self.preview.Parent = self
	self.preview.Paint = function( self, w, h ) self.Parent:PaintLayer( w, h ) end


	self:SetData( {} )
	self:Droppable("layer")
	self.b = true
	self.b1 = true
end



--[[---------------------------------------------------------
   Name: tab = { typ = "", parent = p, data = {} }
-----------------------------------------------------------]]
function PANEL:SetPreView( tab )
if( #self.draw > 0 ) then table.Empty( self.draw ) end
self.rrot = table.Copy(tab)
self:SetData( tab )


	if( tab.typ == "poly" ) then
		local t = {}
		for k,v in ipairs( tab.data ) do
			
			local xr,yr = v.x  / tab.parent:GetWide(), v.y / tab.parent:GetTall()

			table.insert( t, { x = xr , y = yr  } )
			end
		table.insert( self.draw, { typ = tab.typ, data = table.Copy(t) } )

	elseif( tab.typ == "rect" ) then
		local t = {}
			local xr,yr = tab.data.x / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			table.insert( t, { x = xr , y = yr  } )
			local width, height = tab.data.w / tab.parent:GetWide(), tab.data.h / tab.parent:GetTall() 
			table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = width, h = height } )

	elseif( tab.typ == "orect" ) then
		local t = {}
	
			local xr,yr = tab.data.x / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			table.insert( t, { x = xr   , y = yr } )
			local width, height = tab.data.w / tab.parent:GetWide() , tab.data.h / tab.parent:GetTall() 
			table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = width, h = height } )
	elseif( tab.typ == "circle" ) then
		local t = {}
		
			local xr,yr = tab.data.x  / tab.parent:GetWide(), tab.data.y / tab.parent:GetTall()
			local rad = (tab.data.w / tab.parent:GetWide() ) 
			table.insert( t, { x = xr, y = yr  } )
		
		table.insert( self.draw, { typ = tab.typ, x = t[1].x, y = t[1].y, w = rad } )

	elseif( tab.typ == "4poly" ) then
		local t = {}
		for k,v in ipairs( tab.data ) do
			local xr,yr = v.x  / tab.parent:GetWide(), v.y / tab.parent:GetTall()
			table.insert( t, { x = xr, y = yr  } )

		end
		table.insert( self.draw, { typ = tab.typ, data = table.Copy(t) } )

	elseif( tab.typ == "texture" ) then
		local t = {}
	end


end




--[[---------------------------------------------------------

-----------------------------------------------------------]]


--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Think()

	if(input.IsMouseDown( 108 )) then
	
		if( self.b ) then
			self.b = false
			local parent = self:GetParent():GetParent()
		local menu = DermaMenu() 
		menu:AddOption( "delete", function()  
		local layer = designer.layer
		table.remove( layer, self.m_iID )
		--parent:RemoveItem( self.m_iID )
		self:Remove() end )
		menu:Open()
	
		end
	else
		self.b = true
	end

	if(input.IsMouseDown( 107 )) then

		if( self.b1 ) then
			self.b1 = false
			if( self:IsHovered() ) then
				if( !self.m_bselect ) then
					self:SetSelect( true ) 
				else
					self:SetSelect(false)
				end
			end
		end
	else
		self.b1 = true
	end


/*	if( mousecode == MOUSE_LEFT ) then
		if( !self.m_bselect ) then
			self:SetSelect( true ) 
		else
			self:SetSelect(false)
		end
	end

	if( mousecode == MOUSE_RIGHT ) then


	end*/

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	self.check:SetPos(1,h*0.5 - h*0.125)
	self.check:SetSize(w/11 - 2,h*.25)
	self.check:SetChecked(true)
	self.check:SetValue( designer.layer[self:GetID()].visible )
	function self.check:OnChange( b )
	
		designer.layer[self:GetParent().m_iID].visible = b

	end

	self.preview:SetPos(w/11+2,2)
	self.preview:SetSize(w*0.37,h-4 )
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(214,214,214,255)
	surface.DrawRect(0,0,w,h)

	if( self.m_bselect ) then
		surface.SetDrawColor(12,160,245,255)
		surface.DrawRect(w/11,0,w-w/11,h)
	end

	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(0,0,w,1)
	surface.DrawRect(0,h-1,w,1)
	surface.DrawRect(w/11,0,1,h)
	

	


	// overlay to make sure correct the bounds
end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PaintLayer( w, h )


	surface.SetDrawColor( 42, 42, 42, 255 )
	surface.DrawRect( 0,0,w,h )
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h )

	for k,v in ipairs( self.draw ) do

		if( v.typ == "poly" ) then
			surface.SetDrawColor( 225,0,0,255 )
			surface.SetTexture(-1)
			for a,b in ipairs( v.data ) do

				b.x = b.x * w
				b.y = b.y * h

			end
			surface.DrawPoly( v.data )
		elseif(v.typ == "rect" ) then
			surface.SetDrawColor( Color( 255, 0, 0, 255 )  ) -- changeable after drawn must be changed add it to table
			surface.DrawRect( v.x * w, v.y * h, v.w * w, v.h * h)
		elseif( v.typ == "orect" ) then
			surface.SetDrawColor( Color( 255, 0, 0, 255 )  ) -- changeable after drawn must be changed add it to table
			surface.DrawOutlinedRect( v.x * w, v.y * h, v.w * w, v.h * h)
		elseif( v.typ == "circle" ) then
			surface.DrawCircle( v.x * w, v.y * h, v.w * w, Color( 255, 0, 0, 255 ) )
		elseif( v.typ == "4poly" ) then
			surface.SetDrawColor( 225,0,0,255 )
			surface.SetTexture(-1)
			for a,b in ipairs( v.data ) do

				b.x = b.x * w
				b.y = b.y * h

			end
			surface.DrawPoly( v.data )
		elseif( v.typ == "texture" ) then

		end

	end

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )



end


derma.DefineControl( "DDLayer", "A standard Button", PANEL, "DPanel" )