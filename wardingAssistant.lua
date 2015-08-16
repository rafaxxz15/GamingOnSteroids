
PrintChat("Warding Assistant v0.1 Alpha Initialized!");

Config = scriptConfig("Warding Assistant", "Warding Assistant")
Config.addParam("Enabled", "Script Enabled", SCRIPT_PARAM_ONOFF, true)
Config.addParam("AutoWard", "AutoWard Key", SCRIPT_PARAM_KEYDOWN, string.byte("Z"))
Config.addParam("Nearby", "Only when nearby", SCRIPT_PARAM_ONOFF, true)
Config.addParam("Scanner", "Scanner mode", SCRIPT_PARAM_ONOFF, false)

class "Point" -- {
  function Point:__init(x, y, z)
    local pos = GetOrigin(x) or type(x) ~= "number" and x or nil
    self.x = pos and pos.x or x
    self.y = pos and pos.y or y
    self.z = pos and pos.z or z
  end

local wardSpots = {

	-----------------------
	--# PurpleTeam Base #--
	-----------------------
	
	-- Defensive Wards --
	{12083,52,9407}, -- Blue Jungle Entrance
	
	--------------------------------
	--# PurpleTeam - Blue Jungle #--
	--------------------------------
	
	{11645,51,7035}, -- Blue Entrance Bush
	{11939,52,7434}, -- Blue Entrance Crossroad
	{11890,51,6964}, -- Blue/Frog Base Entrance
	{11703,50,6054}, -- Blue/Frog River Entrance
	{12684,51,5202}, -- Bottom Lane Jungle Bush Entrance
	{10046,48,6575}, -- Middle Lane River Entrance Bush (Top)
	{9752,-37,6288}, -- Middle Lane River Entrance Bush (Bot)
	{10701,63,8975}, -- Middle Lane Wolves Entrance
	{10140,51,7703}, -- Middle Lane Bush Crossroad
	
	-------------------------------
	--# PurpleTeam - Red Jungle #--
	-------------------------------
	
    {7097,54,11353}, -- Red Bush (Right)
	{6750,53,11529}, -- Red Bush (Center)
	{6415,56,11356}, -- Red Bush (Left)
	{6343,54,10054}, -- River Crossroad Bush
	{4269,51,11752}, -- Tribush
	
	---------------------
	--# BlueTeam Base #--
	---------------------
	
	-- Defensive Wards --
	{4956,51,2834}, -- Red Jungle Entrance - Defensive Ward
	
	-- Agressive Wards --
	{3041,95,3068}, -- Middle Lane Inhibitor Ward
	
	-----------------------------
	--# BlueTeam - Red Jungle #--
	-----------------------------
	{8347,53,3534}, -- Red Bush Right
	{8108,51,3392}, -- Red Bush Center
	{7802,52,3541}, -- Red Bush Left
	{6550,50,3088}, -- Red Crossroad Left
	{6861,52,2985}, -- Red Crossroad Center
	{7143,52,3076}, -- Red Crossroad Right
	{6689,48,4718}, -- Raptors Bush - Middle Lane Entrance
	{8117,53,5314}, -- River Crossroad Bush
	
	-- Raptors River Entrance --
	{8490,52,4926}, -- Raptors Jungle Entrance from River
	
	-- Base Jungle Entrance --
	{5835,51,3578}, -- Jungle-side bush ward
	{5404,51,3469}, -- Base-side bush ward
	
	
	--# River and meeting points #--
	{9339,72,5727},  -- Dragon River Bush
	
	{10188,63,5269}, -- Dragon Entrance Ward (Mid Jungle Entrance)
  {10546,60,5019}, -- Dragon Entrance Ward (Blue Entrance)
	
	{4102,-72,9857}, -- Baron Entrance Ward
	{4684,-72,10050},-- Baron Den Ward
	{5104,-72,9152}, -- Baron Bush
	
	{6457,-72,8430}, -- Middle Lane Bush - Top Side
	{8483,-72,6384}, -- Middle Lane Bush - Bot Side
	
	{2694,52,13546}, -- Top Lane 3rd Bush - Right
	{2252,52,13254}, -- Top Lane 3rd Bush - Left
	{1893,52,13003}, -- Top Lane 2nd Bush - Right
	{1602,52,12790}, -- Top Lane 2nd Bush - Left
	{1392,52,12464}, -- Top Lane 1st Bush - Right
	{1216,52,12044}, -- Top Lane 1st Bush - Left
	{3193,-66,10760},-- Top Lane River Bush
	
	{11127,-71,3810},-- Bottom Lane River Entrance Bush
	{11701,71,4050}, -- Bottom Lane River Entrances Ward
	{11011,-71,5292},-- Purple Jungle Dragon Entrance
	
	{13453,51,2820}, -- Bottom Lane Purple Bush - Top
	{13004,51,2216}, -- Bottom Lane Purple Bush - Bot
	{12773,52,1876}, -- Bottom Lane Blue Bush - Top
	{12103,51,1328}, -- Bottom Lane Blue Bush - Bot
	
	
	
  	-- Truszczańskie koordynaty --
  	
  {5648,52,12829} -- Krzaki golemów top (linia)
  {5808,52,12640} -- Krzaki golemów top (Jungle)
   
  {6978,52,14046} -- Top Tower Krzaki (lewy)
  {7343,52,14038} -- Top Tower Krzaki (prawy)
   
  {7701,53,11759} -- Skrzyżowanie top lewy
  {5298,56,11882} -- skrzyżowanie top prawa
  {7969,56,11931} -- skrzyżowanie top środek
   
  {8976,55,11344}, -- krzak wejście fiolet jungle (red)
  {9445,52,11436}, -- krzak wejście fiolet Baza (red)
   
  {9753,52,12071}, -- ward def mur top
   
  {8156,49,10270}, -- krzaki raptor (lewa)
  {8392,50,10205}, -- krzaki raptor (prawa)
   
  {6742,54,9621}, -- skrzyżowanie (bez krzaków)
   
   
  ------------------------------------------------------------------
   
  {14001,52,7127}, -- Bot Line krzak purpurowych góra
  {14005,52,6786}, -- Bot Line krzak purpurowych dół
   
  ------------------------------------------------------------------
  --Blu NIesiescy
   
  {3222,51,7879}, -- krzaki blu
   
  {2822,51,7443}, -- skrzyżowanie blu
   
  {4649,50,7247}, -- skrzyżowanie krzaki
   
  {5211,-59,8583}, -- wejście do jungle (mid)
   
  {2281,54,10124}, -- tri bush (def ward)
   
  {2153,59,9703}, -- tri bush (agr ward)
   
  {3443,50,8656}, -- wejście blu rzeka
   
  {896,52,7930}, -- krzak skrajnie lewy (dolny)
   
  {887,52,8341}, -- krzak skrajnie lewy (góra)
   
  {2697,52,5280}, -- mór niebieski (def)
   
  ---------------------------------------------------------------
   
  --Niebiescy RED
   
  {7629,49,830}, -- skrajnie dolny (lewa)
  {7996,49,842}, -- skrajnie dolny (prawy)
   
  {9211,50,2281}, -- krzaki golemów
   
  {10610,48,3105}, -- tibush bot od rzeki
};

OnLoop(function(myHero)
	if Config.Enabled then

		local i = 1;
		
		-- 
		local wardSlot = GetItemSlot(myHero,3340); -- Warding Totem (Trinket)
		if wardSlot == 0 then -- If player does not posses the Trinket, check for...
			wardSlot = GetItemSlot(myHero,2044); -- Stealth Ward
			if wardSlot == 0 then
				wardSlot = GetItemSlot(myHero,2045); -- Ruby Sightstone
				if wardSlot == 0 then
					wardSlot = GetItemSlot(myHero,2049); -- Sightstone
				end;
			 end;
		 end;
		
		-- Don't show warding circles if player have no wards.
		if wardSlot ~= 0 then
			
			-- Check all warding spots
			while wardSpots[i] do
			
				-- Get the warding spot...
				local wardPosition = Point(wardSpots[i][1],wardSpots[i][2],wardSpots[i][3]);
			
				-- Don't show warding circles if hero is too far away
				if Config.Nearby ~= true -- Except when player disabled this option...
				or GetDistanceSqr(wardPosition,GetOrigin(myHero)) < 1000000
				then
					Circle:__init(wardPosition,30);
					if Circle:contains(GetMousePos()) then
						Circle:draw(0xffff0000);
						
						if Config.AutoWard then
							CastSkillShot(wardSlot,wardPosition);
						end;
					else Circle:draw(0xffffffff); end;
					
				end;
				i = i + 1;			-- Let's move out to next spot...
			end;
		end;
		
		-- Position scanner. Im using this to get my warding spots...
		if Option.Scanner ~= true then
			local origin = GetOrigin(myHero);
			local mousepos = GetMousePos();
			local myscreenpos = WorldToScreen(1,origin.x,origin.y,origin.z);
			DrawText(math.floor(mousepos.x) .. " " .. math.floor(mousepos.y) .. " " .. math.floor(mousepos.z),24,myscreenpos.x,myscreenpos.y-20,0xff00ff00); 
		end; 
	end;
end)