local options = {
  x = 0.10,
  y = 0.30,
  width = 0.2,
  height = 0.04,
  scale = 0.4,
  font = 0,
  menu_title = "Gère ton véhicule ici !",
  color_r = 0,
  color_g = 0,
  color_b = 0,
}

local elements = {}
local startmenu = false
local isInVehicle = false
local moteur = true
local limiteur = false
speed = 0
local regulateur = 50

Citizen.CreateThread(function()
while true do
  Citizen.Wait(0)
  if IsControlJustPressed(1, 303) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
          MainMenu()
          Menu.hidden = not Menu.hidden
          startmenu = not startmenu
     end
      Menu.renderGUI(options)
  end
end)

function Notify(text)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(text)
  DrawNotification(false, false)
end

-- Menu selection pour séléctionner dans le menu categorie
function MainMenu()
  options.menu_subtitle = "Choisir une option pour ton véhicule !"  
  ClearMenu()
  Menu.addButton("Démarrer / Eteindre moteur", "onoffengine", nil)
  Menu.addButton("Limiteur / Regulateur de vitesse", "ControlAll", nil)
  Menu.addButton("Ouverture / Fermeture porte", "DoorMenu", nil)
  Menu.addButton("", "null", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end
-- Menu des portes/coffre/capot pour les ouvrir / fermer function en bas ↓
function DoorMenu()
  options.menu_subtitle = "Menu ouverture / fermeture véhicule !"  
  ClearMenu()
  Menu.addButton("Ouvrir/Fermer tout le véhicule", "toute", nil)   
  Menu.addButton("Ouvrir/Fermer porte avant/arrière", "arravvport", nil)   
  Menu.addButton("", "null", nil) 
  Menu.addButton("Ouvrir / Fermer capot", "capot", nil)
  Menu.addButton("Ouvrir / Fermer coffre", "coffre", nil)
  Menu.addButton("Ouvrir / Fermer porte avant", "avant", nil)    
  Menu.addButton("Ouvrir / Fermer porte arrière", "arriere", nil)
  Menu.addButton("", "null", nil)
  Menu.addButton("Retour menu de départ", "MainMenu", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

function avant()
  options.menu_subtitle = "Menu porte avant véhicule !"  
  ClearMenu()
  Menu.addButton("Ouvrir / Fermer gauche/droite", "gaudroitavan", nil)
  Menu.addButton("Ouvrir / Fermer porte gauche", "avantgauche", nil)
  Menu.addButton("Ouvrir / Fermer porte droite", "avantdroite", nil)
  Menu.addButton("", "null", nil)
  Menu.addButton("Retour menu de départ", "MainMenu", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

function arriere()
  options.menu_subtitle = "Menu porte arrière véhicule !"  
  ClearMenu()
  Menu.addButton("Ouvrir / Fermer gauche/droite", "gaudroitarr", nil)
  Menu.addButton("Ouvrir / Fermer gauche", "arrieregauche", nil)
  Menu.addButton("Ouvrir / Fermer droite", "arrieredroite", nil)
  Menu.addButton("", "null", nil)
  Menu.addButton("Retour menu de départ", "MainMenu", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

---Temporairement le temps de corriger une fail et un soucis :

function ControlReg()
options.menu_subtitle = "Régulateur de vitesse !"
ClearMenu()
Menu.addButton("Régulateur bientôt dispo", "null", nil)
Menu.addButton("", "null", nil)
Menu.addButton("Retour menu de départ", "MainMenu", nil)
Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

Citizen.CreateThread(function()
  while true do
      local playerPed = GetPlayerPed(-1)
      if IsPedSittingInAnyVehicle then
          local playerVeh = GetVehiclePedIsIn(playerPed, false)
          if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then
              Notify('~r~Attention !\nVotre coffre est ouvert !')
          end
          if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then
              Notify('~r~Attention !\nVotre capot est ouvert !')
          end
          if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then
              Notify('~r~Attention !\nVotre porte arrière droite est ouverte !')
          end
          if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then
              Notify('~r~Attention !\nVotre porte arrière gauche est ouverte !')
          end
          if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then
              Notify('~r~Attention !\nVotre porte avant droite est ouverte !')
          end
          if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then
              Notify('~r~Attention !\nVotre porte avant gauche est ouverte !')
          end
      end
      Wait(0)
  end
end)

function ControlAll()
  options.menu_subtitle = "Gestion - Limiteur véhicule !"
  ClearMenu()
  Menu.addButton("Limiteur de vitesse", "ControlLim", nil)
  Menu.addButton("Regulateur de vitesse", "ControlReg", nil)
  Menu.addButton("", "null", nil)
  Menu.addButton("Retour menu de départ", "MainMenu", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

function ControlLim()
  options.menu_subtitle = "Gestion - Limiteur véhicule !"
  ClearMenu()
  Menu.addButton("Désactiver le limiteur", "limiter", "350000")
  Menu.addButton("", "null", nil)
  Menu.addButton("~h~Limiter la vitesse à 30Km/h", "limiter", "29.8")
  Menu.addButton("~h~Limiter la vitesse à 50Km/h", "limiter", "49.8")
  Menu.addButton("~h~Limiter la vitesse à 70Km/h", "limiter", "69.8")
  Menu.addButton("~h~Limiter la vitesse à 90Km/h", "limiter", "89.8")
  Menu.addButton("~h~Limiter la vitesse à 110Km/h", "limiter", "109.8")
  Menu.addButton("~h~Limiter la vitesse à 130Km/h", "limiter", "129.8")
  Menu.addButton("", "null", nil)
  Menu.addButton("Retour menu de départ", "MainMenu", nil)
  Menu.addButton("Retourner sur RedLine", "closemenu", nil)
end

function capot()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 4, false)
     else
       SetVehicleDoorOpen(playerVeh, 4, false)
       frontleft = true        
    end
 end
end

function coffre()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 5, false)
     else
       SetVehicleDoorOpen(playerVeh, 5, false)
       frontleft = true        
    end
 end
end

function maxspeed()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 enableCruise = not enableCruise -- inverts bool
 cruiseSpeed = GetEntitySpeed(veh)  
 GetEntitySpeed(playerVeh, 10)
end

function avantgauche()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 0, false)
     else
       SetVehicleDoorOpen(playerVeh, 0, false)
       frontleft = true        
    end
 end
end

function MyPed()
 return GetPlayerPed(-1)
end


function avantdroite()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 1, false)
     else
       SetVehicleDoorOpen(playerVeh, 1, false)
       frontleft = true   
    end
  end
end

function arrieredroite()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 3, false)
     else
       SetVehicleDoorOpen(playerVeh, 3, false)
       frontleft = true        
    end
  end
end 

function arravvport()
local playerPed = GetPlayerPed(-1)
local playerVeh = GetVehiclePedIsIn(playerPed, false)
if ( IsPedSittingInAnyVehicle( playerPed ) ) then
   if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
      SetVehicleDoorShut(playerVeh, 3, false)
      SetVehicleDoorShut(playerVeh, 2, false)   
      SetVehicleDoorShut(playerVeh, 1, false)
      SetVehicleDoorShut(playerVeh, 0, false)    
    else
      SetVehicleDoorOpen(playerVeh, 3, false)
      SetVehicleDoorOpen(playerVeh, 2, false)
      SetVehicleDoorOpen(playerVeh, 1, false)
      SetVehicleDoorOpen(playerVeh, 0, false) 
      frontleft = true        
   end
end
end

function gaudroitarr()
local playerPed = GetPlayerPed(-1)
local playerVeh = GetVehiclePedIsIn(playerPed, false)
if ( IsPedSittingInAnyVehicle( playerPed ) ) then
   if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
      SetVehicleDoorShut(playerVeh, 3, false)
      SetVehicleDoorShut(playerVeh, 2, false)      
    else
      SetVehicleDoorOpen(playerVeh, 3, false)
      SetVehicleDoorOpen(playerVeh, 2, false)
      frontleft = true        
   end
end
end

function toute()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 5, false)        
       SetVehicleDoorShut(playerVeh, 4, false)
       SetVehicleDoorShut(playerVeh, 3, false)
       SetVehicleDoorShut(playerVeh, 2, false)
       SetVehicleDoorShut(playerVeh, 1, false)
       SetVehicleDoorShut(playerVeh, 0, false)         
     else
       SetVehicleDoorOpen(playerVeh, 5, false)        
       SetVehicleDoorOpen(playerVeh, 4, false)
       SetVehicleDoorOpen(playerVeh, 3, false)
       SetVehicleDoorOpen(playerVeh, 2, false)
       SetVehicleDoorOpen(playerVeh, 1, false)
       SetVehicleDoorOpen(playerVeh, 0, false)  
       frontleft = true        
    end
 end
end

function gaudroitavan()
local playerPed = GetPlayerPed(-1)
local playerVeh = GetVehiclePedIsIn(playerPed, false)
if ( IsPedSittingInAnyVehicle( playerPed ) ) then
   if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then
      SetVehicleDoorShut(playerVeh, 1, false)
      SetVehicleDoorShut(playerVeh, 0, false)         
    else
      SetVehicleDoorOpen(playerVeh, 1, false)
      SetVehicleDoorOpen(playerVeh, 0, false)  
      frontleft = true        
   end
end
end

function arrieregauche()
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 if ( IsPedSittingInAnyVehicle( playerPed ) ) then
    if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
       SetVehicleDoorShut(playerVeh, 2, false)
     else
       SetVehicleDoorOpen(playerVeh, 2, false)
       frontleft = true        
    end
 end
end

function limiter(vit)
  speed = vit/3.6
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)
 
  local vehicleModel = GetEntityModel(vehicle)
  local float Max = GetVehicleMaxSpeed(vehicleModel)
 
  if (vit == 0) then
  SetEntityMaxSpeed(vehicle, Max)
  Notify("~b~~h~Vous venez de désactiver le limiteur !")
  else
  SetEntityMaxSpeed(vehicle, speed)
  Notify("~g~~h~Vous venez d'activer le limiteur !")
  MainMenu()
  end
end

function speedo(vit)
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)  
  local currSpeed = GetEntitySpeed(vehicle)*3.6
  speed = vit/3.62
 
  local vehicleModel = GetEntityModel(vehicle)
  local float Max = GetVehicleMaxSpeed(vehicleModel)  
  if (vit == 0) then
  SetEntityMaxSpeed(vehicle, Max)
  end      
if currSpeed > vit then
else
 
  if (vit == 0) then
  SetEntityMaxSpeed(vehicle, Max)
  else
  if vit == 0 and currSpeed < 5 then  
  else
    SetEntityMaxSpeed(vehicle, speed)
end
  end
end
end

function onoffengine()
if moteur then
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)    
 moteur = false
else
 local playerPed = GetPlayerPed(-1)
 local playerVeh = GetVehiclePedIsIn(playerPed, false)
 SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false)   
 moteur = true 
end
end

Citizen.CreateThread(function()
while true do
  Citizen.Wait(0)
      if not moteur then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)     
     end
  end
end)

function closemenu()
  Menu.hidden = not Menu.hidden
  startmenu = not startmenu
end

function null()
startmenu = not startmenu
end


Citizen.CreateThread(function()
while true do
  Citizen.Wait(0)
  if IsControlJustPressed(1, 177) and startmenu then
          closemenu()
     end
  end
end)