 function scoreboard_menu()
 local frame = vgui.Create("GMenu")
frame:SetPos(ScrW()*.125,ScrH()*.125)
frame:SetSize(ScrW() * .5,ScrH() * .5) 
frame:SetDragable( false )
 frame:MakePopup()

 local selectedm = ""
 local changes = false
 local scoreboard = { x = 0.25, y = .25, w = 0.5, h = 0.5, color = Color( 0,0,0,255 )}

 	local board = vgui.Create( "FlatDashTab",frame )
	board:SetPos(1,30)
	board:SetSize(frame:GetWide()*.25,frame:GetTall()-30)
	board:AddTab( "Background" )
	board:AddTab( "Header" )
	board:AddTab( "Infobox" )
	board:AddTab( "PlayerFrame" )
	board:AddTab( "Bottom" )

	 local image_back = vgui.Create("DImage")
	 image_back:SetPos(0,0)
	 image_back:SetSize(board.panel[1]:GetWide(),board.panel[1]:GetTall() * .5)
	 image_back:SetImage("DD/gui/scoreboard.png")
	 image_back.PaintOver = function( self, w, h )
	 
		surface.SetDrawColor( scoreboard.color )
		surface.DrawRect( scoreboard.x * w, scoreboard.y * h, w * scoreboard.w, h * scoreboard.h )

	 end
	 board:AddItem( image_back, 1 )

	  local ypos = vgui.Create("DTextEntry" )
	  ypos:SetPos(board.panel[1]:GetWide() * .05 ,board.panel[1]:GetTall() * .52)
	  ypos:SetSize(board.panel[1]:GetWide() * .3,20)
	  ypos:SetText(0)
	  ypos.OnChange = function( self )
	
		scoreboard.y = tonumber( self:GetText() ) 

	  end
	  board:AddItem( ypos, 1 )

	  local xpos = vgui.Create("DTextEntry" )
	  xpos:SetPos(board.panel[1]:GetWide() * .05 ,board.panel[1]:GetTall() * .56)
	  xpos:SetSize(board.panel[1]:GetWide() * .3,20)
	  xpos:SetText(0)
	  xpos.OnChange = function( self )
		if( isnumber( self:GetText() ) ) then

		scoreboard.x = tonumber( self:GetText() ) 
		end
	  end
	  board:AddItem( xpos, 1 )

	  	  local width = vgui.Create("DTextEntry" )
	  width:SetPos(board.panel[1]:GetWide() * .05 ,board.panel[1]:GetTall() * .6)
	  width:SetSize(board.panel[1]:GetWide() * .3,20)
	  width:SetText(0)
	  width.OnChange = function( self )
	  
		scoreboard.w = tonumber( self:GetText() ) 

	  end
	  board:AddItem( width, 1 )

	  	  local height = vgui.Create("DTextEntry" )
	  height:SetPos(board.panel[1]:GetWide() * .05 ,board.panel[1]:GetTall() * .64)
	  height:SetSize(board.panel[1]:GetWide() * .3,20)
	  height:SetText(0)
	  height.OnChange = function( self )

	

		scoreboard.h = tonumber( self:GetText() ) 

	  end
	  board:AddItem( height, 1 )



	 local image_header = vgui.Create("DImage")
	 image_header:SetPos(0,0)
	 image_header:SetSize(board.panel[1]:GetWide(),board.panel[1]:GetTall() * .5)
	 image_header:SetImage("DD/gui/scoreboard.png")
	 board:AddItem( image_header, 2 )


	 local image_infobox = vgui.Create("DImage")
	 image_infobox:SetPos(0,0)
	 image_infobox:SetSize(board.panel[1]:GetWide(),board.panel[1]:GetTall() * .5)
	 image_infobox:SetImage("DD/gui/scoreboard.png")
	 board:AddItem( image_infobox, 3 )


	 local image_pframe = vgui.Create("DImage")
	 image_pframe:SetPos(0,0)
	 image_pframe:SetSize(board.panel[1]:GetWide(),board.panel[1]:GetTall() * .5)
	 image_pframe:SetImage("DD/gui/scoreboard.png")
	 board:AddItem( image_pframe, 4 )


	 local image_bottom = vgui.Create("DImage")
	 image_bottom:SetPos(0,0)
	 image_bottom:SetSize(board.panel[1]:GetWide(),board.panel[1]:GetTall() * .5)
	 image_bottom:SetImage("DD/gui/scoreboard.png")
	 board:AddItem( image_bottom, 5 )
	end

/*
function scoreboard_menu()
local frame = vgui.Create("GMenu")
frame:SetDragable( false )
frame:SetTitle( "[Scoreboard Creator] 0.0.1")
frame:SetPos(637,329)
frame:SetSize(526,544) 
 frame:MakePopup()


				
 local xpos = vgui.Create("DTextEntry",frame)
						 xpos:SetPos(0.11596958174905*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 xpos:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 xpos:SetText(0)
				
 local ypos = vgui.Create("DTextEntry",frame)
						 ypos:SetPos(0.60836501901141*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 ypos:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 ypos:SetText(0)
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.015209125475285*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("          X")
				
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.50950570342205*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("          Y")

 local width = vgui.Create("DTextEntry",frame)
						 width:SetPos(0.60836501901141*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 width:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 width:SetText(0.5)
				
 local height = vgui.Create("DTextEntry",frame)
						 height:SetPos(0.11596958174905*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 height:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 height:SetText(0.5)
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.50950570342205*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						  e:SetText("          W")
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.015209125475285*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("           H")
 local mixer = vgui.Create("DColorMixer",frame)
						 mixer:SetPos(0.015209125475285*frame:GetWide() ,0.56801470588235*frame:GetTall())
						 mixer:SetSize(0.38022813688213*frame:GetWide(),0.42279411764706*frame:GetTall())
				
 local e = vgui.Create("DButton",frame)
						 e:SetPos(0.42395437262357*frame:GetWide() ,0.56433823529412*frame:GetTall())
						 e:SetSize(0.56463878326996*frame:GetWide(),0.040441176470588*frame:GetTall())
				
 local e = vgui.Create("DPanel",frame)
						 e:SetPos(0.42395437262357*frame:GetWide() ,0.61213235294118*frame:GetTall())
						 e:SetSize(0.56463878326996*frame:GetWide(),0.37867647058824*frame:GetTall())


 local e = vgui.Create("DImage",frame)
						 e:SetPos(0.015209125475285*frame:GetWide() ,0.058823529411765*frame:GetTall())
						 e:SetSize(0.97338403041825*frame:GetWide(),0.35845588235294*frame:GetTall())
						 e:SetImage("DD/gui/scoreboard.png")
						 function e:PaintOver( w, h )
						 local wp,hp = tonumber(width:GetText()) or 0,tonumber(height:GetText()) or 0
						 local x,y = tonumber(xpos:GetText()) or 0 ,tonumber(ypos:GetText()) or 0
							surface.SetDrawColor(mixer:GetColor())
							surface.DrawRect( w * x, h * y, w * wp, h * hp)

						 end
				
 end

 */