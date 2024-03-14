
 function CreateMessageBox( message, t , func, func2 ) 

 local frame = vgui.Create("GMenu")
frame:SetPos(t.x,t.y)
frame:SetSize(t.w,t.h)
frame:SetDraggable( false )
 frame:MakePopup()

 local e = vgui.Create("DButton",frame)
						 e:SetPos(0.058823529411765*frame:GetWide() ,0.72955974842767*frame:GetTall())
						 e:SetSize(0.37950664136622*frame:GetWide(),0.13836477987421*frame:GetTall())
						 e:SetText( "yes" )
						 e.DoClick = function( self )

							func()
							self:GetParent():Remove()

						 end

 local e = vgui.Create("DButton",frame)
						 e:SetPos(0.56356736242884*frame:GetWide() ,0.72955974842767*frame:GetTall())
						 e:SetSize(0.37950664136622*frame:GetWide(),0.13836477987421*frame:GetTall())
						 e:SetText( "no" )
						 e.DoClick = function( self )

							func2()
							self:GetParent():Remove()
						 end
 local e = vgui.Create("DLabel",frame)
						 e:SetPos(0.30929791271347*frame:GetWide() ,0.34591194968553*frame:GetTall())
						 e:SetSize(frame:GetWide(),0.12578616352201*frame:GetTall())
						 e:SetText( message )


 end
 
 function Options()
 local frame = vgui.Create("GMenu")
frame:SetPos(ScrW()*.125,ScrH()*.125)
frame:SetSize(ScrW() * .5,ScrH() * .5) 
frame:SetDraggable( false )
 frame:MakePopup()

 local selectedm = ""
 local changes = false


 	local board = vgui.Create( "FlatDashTab",frame )
	board:SetPos(1,30)
	board:SetSize(frame:GetWide()*.25,frame:GetTall()-30)
	board:AddTab( "Settings" )
--	board:AddTab( "Color Theme" )
	board:AddTab( "VGUI ELements" )
--	board:AddTab( "GUI-Designer" )
--	board:AddTab( "VGUI Debug" )
--	board:AddTab( "Scoreboard-Creator" )
--	board:AddTab( "Projects" )
--	board:AddTab( "Stats" )


	local panel = vgui.Create( "DPanelList")
	panel:SetSize(  board.panel[2]:GetWide()*.3, board.panel[2]:GetTall()*.6)
	panel:SetPos( board.panel[2]:GetWide() - board.panel[2]:GetWide()*.3, 0 )
	panel:EnableVerticalScrollbar()

	panel.VBar.btnUp:SetVisible(false)
	panel.VBar.btnDown:SetVisible(false)
	panel.VBar.btnGrip:SetVisible(false)
	function panel.VBar:Paint(w,h)
	 	  surface.SetDrawColor(0,0,0,0)
	 	  surface.DrawRect(0,0,w,h)
		 return true
	end
		 
		board:AddItem(panel,2)

	local panel2 = vgui.Create( "DPanel")
	panel2:SetSize(  board.panel[2]:GetWide()*.3, board.panel[2]:GetTall()*.4)
	panel2:SetPos( board.panel[2]:GetWide() - board.panel[2]:GetWide()*.3, board.panel[2]:GetTall()*.6 )




	function panel2:Paint( w, h )
	 	  surface.SetDrawColor(42,42,42,255)
	 	  surface.DrawRect(0,0,w,h)
		  surface.SetDrawColor(0,0,0,255)
		  surface.DrawOutlinedRect(0,0,w,h)

	end


	local Type = vgui.Create( "DComboBox" ,panel2)
	Type:SetPos( 0, panel2:GetTall() * .2 )
	Type:SetSize( panel2:GetWide(), 20 )	
	Type:SetValue( "string" )
	Type:AddChoice( "vector" )
	Type:AddChoice( "string" )
	Type:AddChoice( "number" )
	Type:AddChoice( "boolean" )
	Type:AddChoice( "table" )
	Type:AddChoice( "color" )
	Type:AddChoice( "function" )
	Type.OnSelect = function( panel, index, value )
	print( value .." was selected!" )
end

	local Method = vgui.Create( "DTextEntry", panel2 )	-- create the form as a child of frame
	Method:SetPos( 0, panel2:GetTall() * .1 )
	Method:SetSize( panel2:GetWide(), 20 )
	Method:SetText( "SetText" )
	Method.OnEnter = function( self )
	
end

	local AppList = vgui.Create( "DListView" )
	AppList:SetMultiSelect( false )
	AppList:SetSize(  board.panel[2]:GetWide()*.7, board.panel[2]:GetTall())
	AppList:SetPos(0,0 )
	AppList:SetDrawBackground(false)
	AppList:AddColumn( "Methods" )
	AppList:AddColumn( "Typ" )


	function AppList:OnRowRightClick( LineID, Line )

	if( !Line:IsValid() ) then return end
		print( LineID .. " " .. tostring(Line:GetColumnText(1)) .. " " .. "right clicked!" )
	
	--table.remove( DDP.vgui[selectedm],LineID ) Line:RemoveLine( LineID )

	local Menu = DermaMenu() 	
	local r = Menu:AddOption( "remove", function(  ) table.remove( DDP.vgui[selectedm], LineID ) AppList:RemoveLine( LineID ) changes = true end ) 	
	r:SetIcon("icon16/cross.png" )
	Menu:Open()


	end

	function AppList:OnRowSelected( LineID, Line )

		--Method
		--Type
		if( !Line:IsValid() ) then return end
		Method:SetText( Line:GetColumnText(1) )
		Type:SetValue(Line.Columns[2]:GetValue())
	
		--ChooseOptionID

	end

	function AppList:Paint( w, h )

		surface.SetDrawColor( 99,184,255, 200 )
		surface.DrawRect(0,0,w,h)
	end

	board:AddItem(AppList,2)



		  table.SortByMember( DDP.toolbox, "count" )
		  for k,v in ipairs( DDP.toolbox ) do
			local DDListButtom = vgui.Create( "DDListButtom" )
			DDListButtom:SetPos( 25, 50 ) 
			DDListButtom:SetImage("dd/icons/default.png")
			DDListButtom:Droppable("ele")
			DDListButtom:SetText( v.classname)                             // Set position
			DDListButtom:SetSize( panel:GetWide(), 25 )     
			function DDListButtom:DoClick() 
				
				if( changes ) then
					CreateMessageBox( "You didn't save your changes! Do you want to save them?", { x = frame:GetWide() * .5 , y = frame:GetTall() * .5 , w = frame:GetWide() * .5 , h = frame:GetTall() * .5 } , function() file.Write( "dd/db/vgui.txt", util.TableToJSON( DDP.vgui, true ) ) changes = false end , function() print("no") changes = false end ) 
				end
				AppList:Clear()
				selectedm = self:GetText()
				if( DDP.vgui[self:GetText()] == nil ) then DDP.vgui[self:GetText()] = {} end
				for k,v in ipairs( DDP.vgui[self:GetText()] ) do

					AppList:AddLine( v.name, v.typ )

				end
			 end 
			DDListButtom:SizeToContents()                  
			panel:AddItem( DDListButtom) 
		end








	local Save = vgui.Create( "DButton", panel2 )
	Save:SetPos(panel2:GetWide() * .5 - panel2:GetWide() * .25, panel2:GetTall() * .5)
	Save:SetSize(panel2:GetWide() * .5, 20)
	Save:SetText("save")
	Save.DoClick = function( self )

	if( Method:GetText() == "" ) then return end
	if( string.sub( Method:GetText(), 1, 3) != "Set" ) then return end
	for k,v in ipairs( DDP.vgui[selectedm] ) do

		print( v.name )
		if( string.lower( tostring(v.name) ) ==  string.lower(Method:GetText()) ) then
			return
		end

	end
	AppList:AddLine( Method:GetText(), Type:GetValue() )
	table.insert( DDP.vgui[selectedm], { name = Method:GetText(), typ = Type:GetValue() } )
		
	 file.Write( "dd/db/vgui.txt", util.TableToJSON( DDP.vgui ) )
	end

	board:AddItem(panel2,2)

end



--[[---------------------------------------------------------

	Dia = vgui.Create("Info_line")
	Dia:SetSize( frame:GetWide() * .75, frame:GetTall() - 35)
	Dia:SetPos( 5,5  )
	for k=1,20 do
	Dia:AddLine( "JAPAN", { color = Color( 0,200,20,255 ), pos = { k , k * 100  + math.random( 1,4) * 50 } } )
	Dia:AddLine( "AMERICA", { color = Color( 255,0,30,255 ), pos = { k , k * 60  + math.random( 1,4) * 50 } } )
	Dia:AddLine( "GERMANY", { color = Color( 200,200,20,255 ), pos = { k , k * 30  + math.random( 1,4) * 50 } } )
	Dia:AddLine( "CHINA", { color = Color( 0,80,210,255 ), pos = { k , k * 80  + math.random( 1,4) * 50 } } )
	Dia:AddLine( "RUSSIA", { color = Color( 40,200,100,255 ), pos = { k , k * 25  + math.random( 1,4) * 50 } } )
	end

	board:AddItem( Dia, 1 )
-----------------------------------------------------------]]


function TestProperty()


local frame = vgui.Create( "DFrame" )
frame:SetSize( 500, 300 )
frame:Center()
frame:MakePopup()

local sheet = vgui.Create( "DPropertySheet", frame )
sheet:Dock( FILL )

local panel1 = vgui.Create( "DPanel", sheet )

sheet:AddSheet( "test", panel1, "icon16/cross.png" )


local mp = vgui.Create("DModelPanel",panel1)
mp:SetPos( 15,15)
mp:SetSize( 200,200)


local panel2 = vgui.Create( "DPanel", sheet )

sheet:AddSheet( "test 2", panel2, "icon16/tick.png" )

local mp = vgui.Create("DModelPanel",panel2)
mp:SetPos( 15,50)
mp:SetSize( 200,200)

end

