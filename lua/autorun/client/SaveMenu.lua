
--[[---------------------------------------------------------
   Name: GetMethods
-----------------------------------------------------------]]
local function Filter( tab, text )

	for k,v in ipairs( tab ) do

	 text = string.Replace( text, v, "" )

	end

	return text
end

--[[---------------------------------------------------------
   Name: GetMethods
-----------------------------------------------------------]]
function SaveTheFile()
local frame = vgui.Create("DFrame")
	     frame:SetPos(368,316)
		 frame:SetSize(435,341) 
		 frame:MakePopup()

local filename = vgui.Create("RTextEntry",frame)
	     filename:SetPos(0.0091533180778032*frame:GetWide() ,0.91202346041056*frame:GetTall())
		 filename:SetSize(0.64302059496568*frame:GetWide(),0.073313782991202*frame:GetTall())
		 
local e = vgui.Create("DButton",frame)
	     e:SetPos(0.67276887871854*frame:GetWide() ,0.91202346041056*frame:GetTall())
		 e:SetSize(0.31350114416476*frame:GetWide(),0.073313782991202*frame:GetTall())
		 e:SetText("Save")
		 e.DoClick = function()
	
		CreateProjectFile( Filter({"!"," ","/",".","?","*","#","+","<",">","|","°","^","]","[","}","{","§","$","%","&","(",")",[["]],"=",[[']],"-"},filename:GetText()) )
			
		 end
		 
local e = vgui.Create("DListView",frame)
	     e:SetPos(0.0091533180778032*frame:GetWide() ,0.087976539589443*frame:GetTall())
		 e:SetSize(0.97711670480549*frame:GetWide(),0.80645161290323*frame:GetTall())
		 e:SetMultiSelect( false )
	 	 e:AddColumn( "Name" )
	 	 e:AddColumn( "Author" )
		 e:AddColumn( "VGUI" )

	 	local files, dir = file.Find( "ride/projects/*.txt", "DATA", "nameasc" )

		for k,v in ipairs( files ) do
		local f = string.Explode("_",v)
			if(#f > 1 ) then
			else
				local tab = util.JSONToTable( file.Read("ride/projects/" .. v .. "", "DATA") )
				e:AddLine( tab.name, tab.author, #tab.elemente )
			end

		end
 end

 --[[---------------------------------------------------------
   Name: GetMethods
-----------------------------------------------------------]]
 function LoadTheFile()

 if( loadframe != nil ) then loadframe:Remove() loadframe = nil end
         loadframe = vgui.Create("DFrame")
	     loadframe:SetPos(368,316)
		 loadframe:SetSize(435,341) 
		 loadframe:MakePopup()

		 
		local filename = vgui.Create("RTextEntry",loadframe)
	     filename:SetPos(0.0091533180778032*loadframe:GetWide() ,0.91202346041056*loadframe:GetTall())
		 filename:SetSize(0.64302059496568*loadframe:GetWide(),0.073313782991202*loadframe:GetTall())
		 function filename:OnChange(  )
		 end

local listview = vgui.Create("DListView",loadframe)
	     listview:SetPos(0.0091533180778032*loadframe:GetWide() ,0.087976539589443*loadframe:GetTall())
		 listview:SetSize(0.97711670480549*loadframe:GetWide(),0.80645161290323*loadframe:GetTall())
		listview:SetMultiSelect( false )
	 	 listview:AddColumn( "Name" )
	 	 listview:AddColumn( "Author" )
		 listview:AddColumn( "VGUI" )
		 function listview:OnRowSelected( LineID, Line ) 

		filename:SetText( Line:GetColumnText( 1 ) )
		 end

	 	local files, dir = file.Find( "ride/projects/*.txt", "DATA", "nameasc" )

		for k,v in ipairs( files ) do

		local f = string.Explode("_",v)
			if(#f > 1 ) then

			else
				local tab = util.JSONToTable( file.Read("ride/projects/" .. v .. "", "DATA") )
				listview:AddLine( tab.name, tab.author, #tab.elemente )
			end

		end
		 local e = vgui.Create("DButton",loadframe)
	     e:SetPos(0.67276887871854*loadframe:GetWide() ,0.91202346041056*loadframe:GetTall())
		 e:SetSize(0.31350114416476*loadframe:GetWide(),0.073313782991202*loadframe:GetTall())
		 e:SetText("Load")
		 e.DoClick = function()

		 // check TextEntry text not listview
			LoadProjectFile( listview:GetSelected()[1]:GetColumnText(1) )	
		 end
		 
 end
--[[---------------------------------------------------------
   Name: GetMethods
-----------------------------------------------------------]]
 function DebugTheFile()

 local frame = vgui.Create("DFrame")
	     frame:SetPos(368,316)
		 frame:SetSize(435,341) 
		 frame:MakePopup()

local filename = vgui.Create("RTextEntry",frame)
	     filename:SetPos(0.0091533180778032*frame:GetWide() ,0.91202346041056*frame:GetTall())
		 filename:SetSize(0.64302059496568*frame:GetWide(),0.073313782991202*frame:GetTall())
		 
local e = vgui.Create("DButton",frame)
	     e:SetPos(0.67276887871854*frame:GetWide() ,0.91202346041056*frame:GetTall())
		 e:SetSize(0.31350114416476*frame:GetWide(),0.073313782991202*frame:GetTall())
		 e:SetText("Run")
		 e.DoClick = function()
	
		CreateFrameFile( Filter({"!"," ","/",".","?","*","#","+","<",">","|","°","^","]","[","}","{","§","$","%","&","(",")",[["]],"=",[[']],"-"},filename:GetText()) )
			
		 end
		 
local e = vgui.Create("DListView",frame)
	     e:SetPos(0.0091533180778032*frame:GetWide() ,0.087976539589443*frame:GetTall())
		 e:SetSize(0.97711670480549*frame:GetWide(),0.80645161290323*frame:GetTall())
		 e:SetMultiSelect( false )
	 	 e:AddColumn( "Name" )
	 	 e:AddColumn( "Author" )
		 e:AddColumn( "VGUI" )

	 	local files, dir = file.Find( "ride/projects/*.txt", "DATA", "nameasc" )

		for k,v in ipairs( files ) do
		local f = string.Explode("_",v)
			if(#f > 1 ) then
			else
				local tab = util.JSONToTable( file.Read("ride/projects/" .. v .. "", "DATA") )
				e:AddLine( tab.name, tab.author, #tab.elemente )
			end

		end
		function e:OnRowSelected( LineID, Line ) 

		filename:SetText( Line:GetColumnText( 1 ) )
		 end

 end