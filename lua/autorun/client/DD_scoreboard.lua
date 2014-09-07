


function scoreboard_menu()
local frame = vgui.Create("GMenu")
frame:SetDragable( false )
frame:SetTitle( "[Scoreboard Creator] 0.0.1")
frame:SetPos(637,329)
frame:SetSize(526,544) 
 frame:MakePopup()


				
 local xpos = vgui.Create("RTextEntry",frame)
						 xpos:SetPos(0.11596958174905*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 xpos:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 xpos:SetText(0)
				
 local ypos = vgui.Create("RTextEntry",frame)
						 ypos:SetPos(0.60836501901141*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 ypos:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 ypos:SetText(0)
 local e = vgui.Create("RLabel",frame)
						 e:SetPos(0.015209125475285*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("          X")
				
 local e = vgui.Create("RLabel",frame)
						 e:SetPos(0.50950570342205*frame:GetWide() ,0.42463235294118*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("          Y")

 local width = vgui.Create("RTextEntry",frame)
						 width:SetPos(0.60836501901141*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 width:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 width:SetText(0.5)
				
 local height = vgui.Create("RTextEntry",frame)
						 height:SetPos(0.11596958174905*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 height:SetSize(0.38022813688213*frame:GetWide(),0.045955882352941*frame:GetTall())
						 height:SetText(0.5)
 local e = vgui.Create("RLabel",frame)
						 e:SetPos(0.50950570342205*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						  e:SetText("          W")
 local e = vgui.Create("RLabel",frame)
						 e:SetPos(0.015209125475285*frame:GetWide() ,0.49816176470588*frame:GetTall())
						 e:SetSize(0.10266159695817*frame:GetWide(),0.045955882352941*frame:GetTall())
						 e:SetText("           H")
 local mixer = vgui.Create("RColorMixer",frame)
						 mixer:SetPos(0.015209125475285*frame:GetWide() ,0.56801470588235*frame:GetTall())
						 mixer:SetSize(0.38022813688213*frame:GetWide(),0.42279411764706*frame:GetTall())
				
 local e = vgui.Create("RButton",frame)
						 e:SetPos(0.42395437262357*frame:GetWide() ,0.56433823529412*frame:GetTall())
						 e:SetSize(0.56463878326996*frame:GetWide(),0.040441176470588*frame:GetTall())
				
 local e = vgui.Create("RPanel",frame)
						 e:SetPos(0.42395437262357*frame:GetWide() ,0.61213235294118*frame:GetTall())
						 e:SetSize(0.56463878326996*frame:GetWide(),0.37867647058824*frame:GetTall())


 local e = vgui.Create("RImage",frame)
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
