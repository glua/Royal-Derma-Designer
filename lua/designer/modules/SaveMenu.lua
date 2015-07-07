
--[[---------------------------------------------------------
   Name: Filter
-----------------------------------------------------------]]
local function Filter( tab, text )

	for k,v in ipairs( tab ) do

	 text = string.Replace( text, v, "" )

	end

	return text
end

--[[---------------------------------------------------------
   Name: SaveTheFile
-----------------------------------------------------------]]
function SaveTheFile()
if( saveframe != nil ) then saveframe:Remove() saveframe = nil end
		saveframe = vgui.Create("GMenu")
	     saveframe:SetPos(368,316)
		 saveframe:SetSize(435,341) 
		 saveframe:SetTitle("Save projectfile")
		 saveframe:SetDragable( false )
		 saveframe:MakePopup()


local filename = vgui.Create("DTextEntry",saveframe)
	     filename:SetPos(0.0091533180778032*saveframe:GetWide() ,0.91202346041056*saveframe:GetTall())
		 filename:SetSize(0.64302059496568*saveframe:GetWide(),0.073313782991202*saveframe:GetTall())
		 filename:SetEditable(true)
		 
local e = vgui.Create("DButton",saveframe)
	     e:SetPos(0.67276887871854*saveframe:GetWide() ,0.91202346041056*saveframe:GetTall())
		 e:SetSize(0.31350114416476*saveframe:GetWide(),0.073313782991202*saveframe:GetTall())
		 e:SetText("Save")
		 e.DoClick = function()
	
		CreateProjectFile( Filter({"!"," ","/",".","?","*","#","+","<",">","|","°","^","]","[","}","{","§","$","%","&","(",")",[["]],"=",[[']],"-"},filename:GetText()) )
		DDP.Name = Filter({"!"," ","/",".","?","*","#","+","<",">","|","°","^","]","[","}","{","§","$","%","&","(",")",[["]],"=",[[']],"-"},filename:GetText())
		saveframe:Remove()
		saveframe = nil
	

		 end
		 
local e = vgui.Create("DListView",saveframe)
	     e:SetPos(0.0091533180778032*saveframe:GetWide() ,0.087976539589443*saveframe:GetTall())
		 e:SetSize(0.97711670480549*saveframe:GetWide(),0.80645161290323*saveframe:GetTall())
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
   Name: LoadTheFile
-----------------------------------------------------------]]
 function LoadTheFile()

 if( loadframe != nil ) then loadframe:Remove() loadframe = nil end
         loadframe = vgui.Create("GMenu")
	     loadframe:SetPos(368,316)
		 loadframe:SetSize(435,341) 
		 loadframe:SetTitle("Load projectfile")
		 loadframe:SetDragable( false )
		 loadframe:MakePopup()

		 
		local filename = vgui.Create("DTextEntry",loadframe)
	     filename:SetPos(0.0091533180778032*loadframe:GetWide() ,0.91202346041056*loadframe:GetTall())
		 filename:SetSize(0.64302059496568*loadframe:GetWide(),0.073313782991202*loadframe:GetTall())


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
		if( string.find(string.lower(v), "lua", 0 ) ) then

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
		 DDP.Name = listview:GetSelected()[1]:GetColumnText(1)
		 // check TextEntry text not listview
			LoadProjectFile( listview:GetSelected()[1]:GetColumnText(1) )	
			loadframe:Remove()
			loadframe = nil
			
		 end
		 
 end
