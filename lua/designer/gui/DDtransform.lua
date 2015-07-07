
PANEL = {}
AccessorFunc( PANEL, "m_stext", 			"Text" )
AccessorFunc( PANEL, "m_layer", 			"Layer" )
AccessorFunc( PANEL, "m_minW", 			"MinW" )
AccessorFunc( PANEL, "m_minH", 			"MinH" )
AccessorFunc( PANEL, "m_tcolor", 			"Color" )
AccessorFunc( PANEL, "m_pPanel", 			"TPanel" )
AccessorFunc( PANEL, "m_igap", 			"Gap" )


--[[---------------------------------------------------------
NAME: Init( void )
-----------------------------------------------------------]]
function PANEL:Init()

	self.buttons = {}

	
	for i=1,9 do
		self.buttons[i] = vgui.Create( "DButton", self )
		self.buttons[i].parent = self
		self.buttons[i]:SetText("")
		self.buttons[i].OnMousePressed = function( self, mcode ) self:GetParent():OnMousePress( mcode ) DLabel.OnMousePressed( self, mcode )  end
	end

	self.mouse = {0,0}
	self.pmouse = {0,0}
	self:SetMinW( 15 )
	self:SetMinH( 15 )
	self:SetColor( Color( 0, 0, 0, 255 ) )
	self:SetTPanel( nil )
	self:SetGap( 25 )
	

end

--[[---------------------------------------------------------
   Name: 
-----------------------------------------------------------]]
function PANEL:OnMousePress( mcode )
local x,y = self:LocalCursorPos()
if( mcode == MOUSE_LEFT ) then
	self.pmouse = { x, y }

end


end

--[[---------------------------------------------------------
NAME: Think( void )
-----------------------------------------------------------]]
function PANEL:Think( )

local backup = { x = self.x, y = self.y, w = self:GetWide(), h = self:GetTall() }

	if( self:GetTPanel() != nil ) then
		if( !self:GetTPanel():IsValid() ) then
			self:Remove()
		end
	end

	for k,v in ipairs( self.buttons ) do

		if( v:IsDown() ) then
			if( DDP.frame != nil ) then
				if( IsValid(DDP.frame) ) then
					if( self.m_pPanel != nil ) then
						if( self.m_pPanel:IsValid() ) then
							table.Empty( DDP.selected )
							table.insert( DDP.selected, self.m_pPanel )
						end
					end
				end
			end
			local mx,my = self:LocalCursorPos()
			local x,y = mx - v.x, my - v.y

				if( k == 1 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self.x = self.x + x
						self:SetWide( self:GetWide() - x )
						self.mouse[1] = x
					end

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self.y= self.y + y
						self:SetTall( self:GetTall() - y )
						self.mouse[2] = y

					end
				elseif( k == 2 ) then

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self.y = self.y + y
						self:SetTall( self:GetTall() - y )
						self.mouse[2] = y

					end
				elseif( k == 3 ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
					if( self.mouse[1] != x ) then
						self:SetWide( self:GetWide() + x )
						self.mouse[1] = x
					end

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self.y= self.y + y
						self:SetTall( self:GetTall() - y )
						self.mouse[2] = y

					end
				elseif( k == 4 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self.x = self.x + x
						self:SetWide( self:GetWide() - x )
						self.mouse[1] = x
					end
				elseif( k == 5 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self.x = self.x + x
						self:SetWide( self:GetWide() - x )
						self.mouse[1] = x
					end

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self:SetTall( self:GetTall() + y )
						self.mouse[2] = y

					end
				elseif( k == 6 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self:SetWide( self:GetWide() + x )
						self.mouse[1] = x
					end
				elseif( k == 7 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self:SetWide( self:GetWide() + x )
						self.mouse[1] = x
					end

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self:SetTall( self:GetTall() + y )
						self.mouse[2] = y

					end
				elseif( k == 8 ) then
					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self:SetTall( self:GetTall() + y )
						self.mouse[2] = y

					end
				elseif( k == 9 ) then
					if( self.mouse[1] != x ) then
						if( self:GetTPanel().horizontal ) then
							if( self.pmouse[1] - mx  < self.m_igap and self.pmouse[1] - mx >= 0   ) then
							  x = 0
							 elseif( self.pmouse[1] - mx  > -self.m_igap and self.pmouse[1] - mx  < self.m_igap  ) then
							 x = 0
							 end
						end
						self.x = self.x + x
						self.mouse[1] = x
					end

					if( self.mouse[2] != y ) then
						if( self:GetTPanel().vertical ) then
							if( self.pmouse[2] - my  < self.m_igap and self.pmouse[2] - my >= 0  ) then
							y = 0
							elseif( self.pmouse[2] - my  > -self.m_igap and self.pmouse[2] - my  < self.m_igap  ) then
							y = 0
							end
						end
						self.y= self.y + y
						self.mouse[2] = y

					end
					
				end

		else

		end


	end
	
		if( self:GetTall() < self.m_minH or self:GetWide() < self.m_minW ) then

			self:SetPos( backup.x, backup.y )
			self:SetSize( backup.w, backup.h )

		end

		if( self:GetTPanel() != nil and self:GetTPanel():IsValid() ) then

			self:GetTPanel():SetPos( self.x, self.y )
			self:GetTPanel():SetSize( self:GetWide(), self:GetTall() )

		end


end

--[[---------------------------------------------------------
NAME: PerformLayout( number, number )
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )



		self.buttons[1]:SetPos( 0,  0 )
		self.buttons[1]:SetSize( 5,5 )
		self.buttons[1]:SetCursor( "sizenwse")

		self.buttons[2]:SetPos( w * .5 - 2.5, 0 )
		self.buttons[2]:SetSize( 5,5 )
		self.buttons[2]:SetCursor( "sizens")

		self.buttons[3]:SetPos( w - 5, 0 )
		self.buttons[3]:SetSize( 5,5 )
		self.buttons[3]:SetCursor( "sizenesw")

		self.buttons[4]:SetPos( 0, h * .5 - 2.5 )
		self.buttons[4]:SetSize( 5,5 )
		self.buttons[4]:SetCursor( "sizewe")

		self.buttons[5]:SetPos( 0, h-5 )
		self.buttons[5]:SetSize( 5,5 )
		self.buttons[5]:SetCursor( "sizenesw")

		self.buttons[6]:SetPos( w -5 , h * .5 - 2.5 )
		self.buttons[6]:SetSize( 5,5 )
		self.buttons[6]:SetCursor( "sizewe")

		self.buttons[7]:SetPos( w - 5, h - 5 )
		self.buttons[7]:SetSize( 5,5 )
		self.buttons[7]:SetCursor( "sizenwse")

		self.buttons[8]:SetPos( w*.5 - 2.5, h - 5 )
		self.buttons[8]:SetSize( 5,5 )
		self.buttons[8]:SetCursor( "sizens")

		self.buttons[9]:SetPos( w*.5 - 2.5, h*.5 -2.5 )
		self.buttons[9]:SetSize( 5,5 )
		self.buttons[9]:SetCursor( "sizeall")

		
		if(   self.x != self:GetTPanel().x ) then
			self.x = self:GetTPanel().x 
		end

		if( self.y != self:GetTPanel().y ) then
			self.y = self:GetTPanel().y
		end
		self:SetZPos( 4000 )
		for k,v in ipairs( self.buttons ) do

			v:SetZPos( 4000 )

		end
end


--[[---------------------------------------------------------
NAME: Paint( number, number )
-----------------------------------------------------------]]
function PANEL:Paint( w, h )


	surface.SetDrawColor( self.m_tcolor )
	surface.DrawOutlinedRect( 0,0,w,h)
	
end

--[[---------------------------------------------------------
NAME: PaintOver( number, number )
-----------------------------------------------------------]]
function PaintOver( w, h )



end


derma.DefineControl( "DDTransform", "A standard Button", PANEL, "DPanel" )