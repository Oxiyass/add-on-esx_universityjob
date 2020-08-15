print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^0 ^5Oxiyass^7")
print("^0[^3Version^0] ^7:^0 ^01.0^7")
print("^0======================================================================^7")



local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX = nil 




Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)

	end



	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(10)

	end



	PlayerData = ESX.GetPlayerData()

end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

	PlayerData.job = job

end)


_menuPool = NativeUI.CreatePool()
policevMenu = NativeUI.CreateMenu("Garage Universite", "Liste des véhicules Universite", nil, nil, "shopui_title_ie_modgarage", "shopui_title_ie_modgarage")
_menuPool:Add(policevMenu)



spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, -1660.23, 76.06, 63.40, 90.94, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, " UNVTE ")
  

end







function AddPolicevMenu(menu)

    local voituremenu = _menuPool:AddSubMenu(menu, "Voiture", nil, nil, "", "")
    voituremenu.Item:SetRightBadge(BadgeStyle.None)


    






    local p5008 = NativeUI.CreateItem("Police Cruiser", "Appuyer sur ENTRER pour sortir ce véhicule")
    voituremenu.SubMenu:AddItem(p5008)
    p5008:SetRightBadge(BadgeStyle.Car)

    local espace3 = NativeUI.CreateItem("Dodge", "Appuyer sur ENTRER pour sortir ce véhicule")
    voituremenu.SubMenu:AddItem(espace3)
    espace3:SetRightBadge(BadgeStyle.Car)

    voituremenu.SubMenu.OnItemSelect = function(menu, item)
        if item == p5008 then 
            ESX.ShowAdvancedNotification("Professeur", "ACtions Effectué", "Le Véhicule Ce Trouve Juste Derrière Toi ! Bonne Route", "CHAR_CARSITE", 1)
            Citizen.Wait(1)
            spawnCar("5008")
            _menuPool:CloseAllMenus(true)
        elseif item == espace3 then
            ESX.ShowAdvancedNotification("Professeur", "ACtions Effectué", "Le Véhicule Ce Trouve Juste Derrière Toi ! Bonne Route", "CHAR_CARSITE", 1)
            Citizen.Wait(1)
            spawnCar("espace3")
            _menuPool:CloseAllMenus(true)

        end


    end



end

AddPolicevMenu(policevMenu)
_menuPool:RefreshIndex()



local policev = {
    {x = 457.83, y = -1017.33, z = 28.29},

}





Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(policev) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, policev[k].x, policev[k].y, policev[k].z)

            if dist <= 1.2 then
             if PlayerData.job ~= nil and PlayerData.job.name == 'police' then 
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec ~b~Tony")
                if IsControlJustPressed(1,51) then 
                    latestPoint = policev[k].type 
                    policevMenu:Visible(not policevMenu:Visible())
                end
            end
                
            end
        end
    end
end)






local v1 = vector3(459.08, -1017.21, 29.15)   -- Le nom au dessus du PNJ


function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.30)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 40

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x,v1.y,v1.z, "Tony")
		end
	end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_y_business_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "a_m_y_business_02", 459.08, -1017.21, 27.15, 90.58, false, true) --Emplacement du PEDS
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)



