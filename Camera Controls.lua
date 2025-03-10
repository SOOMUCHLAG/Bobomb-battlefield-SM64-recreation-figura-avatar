local math_abs = math.abs 
local math_min = math.min
local math_max = math.max
local math_floor = math.floor
local math_ceil = math.ceil
local math_clamp = math.clamp
local isCrouching = false
--old controls
--[[local w = keybinds:newKeybind("Keybind Name", "key.keyboard.i")
w.press = function()
  pings.state(1,true)
end
w.release = function()
  pings.state(1,false)
end
local s = keybinds:newKeybind("Keybind Name", "key.keyboard.k")
s.press = function()
  pings.state(2,true)
end
s.release = function()
  pings.state(2,false)
end

local a = keybinds:newKeybind("Keybind Name", "key.keyboard.l")
a.press = function()
  pings.state(3,true)
end
a.release = function()
  pings.state(3,false)
end
local d = keybinds:newKeybind("Keybind Name", "key.keyboard.j")
d.press = function()
  pings.state(4,true)
end
d.release = function()
  pings.state(4,false)
end

local up1 = keybinds:newKeybind("Keybind Name", "key.keyboard.z")
up1.press = function()
  pings.state(5,true)
--  takeDebug = true
end
up1.release = function()
  pings.state(5,false)
end
local down = keybinds:newKeybind("Keybind Name", "key.keyboard.x")
down.press = function()
  pings.state(6,true)
end
down.release = function()
  pings.state(6,false)
end

local rot1 = keybinds:newKeybind("Keybind Name", "key.keyboard.m")
rot1.press = function()
  pings.state(7,true)
end
rot1.release = function()
  pings.state(7,false)
end
local rot2 = keybinds:newKeybind("Keybind Name", "key.keyboard.n")
rot2.press = function()
  pings.state(8,true)
end
rot2.release = function()
  pings.state(8,false)
end

local rot3 = keybinds:newKeybind("Keybind Name", "key.keyboard.b")
rot3.press = function()
  pings.state(9,true)
end
rot3.release = function()
  pings.state(9,false)
end
local down = keybinds:newKeybind("Keybind Name", "key.keyboard.v")
down.press = function()
  pings.state(10,true)
end
down.release = function()
  pings.state(10,false)
end
local down = keybinds:newKeybind("Keybind Name", "key.keyboard.u")
down.press = function()
pings.state(11)
end

local deg90rotmat = matrices.yRotation3(90)
local pitchLimit = 89 
function events.tick()
if keybindStatew then
cameraPos = cameraPos + lookDir.x_z:normalized()*0.2
end  
if keybindStates then
  cameraPos = cameraPos - lookDir.x_z:normalized()*0.2
end  
if keybindStated then
cameraPos = cameraPos - (vec(lookDir.x,0,lookDir.z):normalized()*0.2*deg90rotmat)
end  
if keybindStatea then
  cameraPos = cameraPos + (vec(lookDir.x,0,lookDir.z):normalized()*0.2*deg90rotmat)
end  
if keybindState1 then
cameraPos:add(0,0.1,0)
end  
if keybindState2 then
  cameraPos:sub(0,0.1,0)
end  
if keybindStaterot1 then
yaw = yaw-4
end
if keybindStaterot2 then
  yaw = yaw+4
  end  
  if keybindStaterot3 then
pitch = pitch-4
end
if keybindStaterot4 then
  pitch = pitch+4
  end 
  pitch = math.max(-pitchLimit, math.min(pitchLimit, pitch))
  updateCameraOrientation(yaw, pitch)
end  


function pings.state(kb,state)
  if kb == 1 then
    keybindStatew = state
  end
  if kb == 2 then
    keybindStates = state
  end
  if kb == 3 then
    keybindStatea = state
  end
  if kb == 4 then
    keybindStated = state
  end
  if kb == 5 then
    keybindState1 = state
  end
  if kb == 6 then
    keybindState2 = state
  end
  if kb == 7 then
    keybindStaterot1 = state
  end
  if kb == 8 then
    keybindStaterot2 = state
  end
  if kb == 9 then
    keybindStaterot3 = state
  end
  if kb == 10 then
    keybindStaterot4 = state
  end
  if kb == 11 then
    pitch = 0
    yaw = 0
  end
end
]]
function VectorToAngles(dir)
  dir:normalize()
    return vec(-math.deg(math.atan2(dir.y, math.sqrt(dir.x * dir.x + dir.z * dir.z))), math.deg(math.atan2(dir.x, dir.z)), 0)
end
slidingTimer = 0
zButton = false
prevGrounded = false
standingOnSeesaw = false
sliding = false
jumpStreak = 0
jumpTimerStreak = 37
jumpTimer = 0
colSphereRadius = 1.5
maxVel = 14
gravity = vec(0,0.2,0)
playerVel = vec(0,0,0)
groundNormal = vec(0,1,0)
acceleration = 0.23
friction = 0.99
grounded=false
movementToggle = true
cameraoffset = vec(0,4,0)
local timer = 0
function updateCameraOrientation(yaw, pitch)
    local direction = vec(0, 0, 0)


    direction.x = math.cos(math.rad(yaw)) * math.cos(math.rad(pitch))
    direction.y = math.sin(math.rad(pitch))
    direction.z = math.sin(math.rad(yaw)) * math.cos(math.rad(pitch))


    direction:normalize()

    lookDir = direction
end


local forward = keybinds:fromVanilla("key.forward")
local right = keybinds:fromVanilla("key.right")
local left = keybinds:fromVanilla("key.left")
local backward = keybinds:fromVanilla("key.back")
local jump= keybinds:fromVanilla("key.jump")
local destroy= keybinds:fromVanilla("key.attack")
local place= keybinds:fromVanilla("key.use")
local sneak= keybinds:fromVanilla("key.sneak")
local z= keybinds:newKeybind("x", "key.keyboard.x")
local b= keybinds:newKeybind("b", "key.keyboard.b")
--entity init event, used for when the avatar entity is loaded for the first time

forward.press = function()

if not movementToggle then
  pings.state(1,true)
  return true
end
end
forward.release = function()
if not movementToggle then
  pings.state(1,false)
  return true
end
end
sneak.press = function()
if not movementToggle then
  pings.state(5,true)
  return true
end
end
sneak.release = function()
if not movementToggle then
  pings.state(5,false)
  return true
end
end
right.press = function()
if not movementToggle then
  pings.state(3,true)
  return true
end
end
right.release = function()
if not movementToggle then
  pings.state(3,false)
  return true
end
end
left.press = function()
if not movementToggle then
  pings.state(4,true)
  return true
end
end
left.release = function()
if not movementToggle then
  pings.state(4,false)
  return true
end
end
backward.press = function()
if not movementToggle then
  pings.state(2,true)
  return true
end
end
backward.release = function()
if not movementToggle then
  pings.state(2,false)
  return true
end
end
jump.press = function()

if not movementToggle then
  pings.state(6,true)
  return true
end
end
jump.release = function()
if not movementToggle then
  pings.state(6,false)
  return true
end
end
destroy.press = function()
if not movementToggle then
 -- pings.destroy()
  return true
end
end
z.press = function()

  if not movementToggle then
    pings.state(8,true)
    return true
  end
  end

z.release = function()
    if not movementToggle then
      pings.state(8,false)
      return true
    end
    end
    b.press = function()
      playerVel = playerVel*10
    end
place.press = function()
if not movementToggle then
--pings.place()
  return true
end
end


--[[
local down = keybinds:newKeybind("Keybind Name", "key.keyboard.x")
down.press = function()
  pings.state(6,true)
end
down.release = function()
  pings.state(6,false)
end
]]
local movement = keybinds:newKeybind("Keybind Name", "key.keyboard.m")
movement.press = function()
  pings.state(7,not movementToggle)
end
--[[]
local place = keybinds:newKeybind("Keybind Name", "key.keyboard.h")
place.press = function()
  pings.place()
--  takeDebug = true
end
local place = keybinds:newKeybind("Keybind Name", "key.keyboard.u")
place.press = function()
  pings.destroy()
--  takeDebug = true
end
]]
grounded3 = 0
local tripleJumpThreshold = 0.7
local velDir = vec(0,0,0)
local longJumpThreshold = 0.45
local playerRot = 70
local deltaRot = vec(0,0,0)
local rotation = vec(0,0,0)
local deg90rotmat = matrices.yRotation3(90)
local pitchLimit = 89 
local bodyrot = 0
local firstCollision = true
function events.tick()
  prevGrounded = grounded
if playerVel:length()> maxVel then
  playerVel = playerVel:normalized()*maxVel
end


  if grounded  then
    if jumpStreak >= 3 then
    jumpStreak = 0
    jumpTimer = 0
    end
    gravity = vec(0,0.2,0)
   end

   

slidingTimer = slidingTimer-1
jumpTimer = jumpTimer - 1
jumpTimerStreak = jumpTimerStreak - 1
  firstCollision = true
timer = timer + 1
if keybindStatew then
  if grounded then
playerVel= playerVel+ lookDir.x_z:normalized()*acceleration
  else
    playerVel= playerVel+ lookDir.x_z:normalized()*acceleration*0.1
  end
end  
if keybindStates then
  if grounded then
  playerVel= playerVel- lookDir.x_z:normalized()*acceleration
else
  playerVel= playerVel- lookDir.x_z:normalized()*acceleration*0.1
end
end  
if keybindStated then
  if grounded then
playerVel= playerVel- (vec(lookDir.x,0,lookDir.z):normalized()*acceleration*deg90rotmat)
else
  playerVel= playerVel- (vec(lookDir.x,0,lookDir.z):normalized()*acceleration*deg90rotmat)*0.1
end
end  
if keybindStatea then
  if grounded then
  playerVel= playerVel+ (vec(lookDir.x,0,lookDir.z):normalized()*acceleration*deg90rotmat)
else
  playerVel= playerVel+ (vec(lookDir.x,0,lookDir.z):normalized()*acceleration*deg90rotmat)*0.1
end
end  
if keybindState1 then
 -- playerVel:add(0,acceleration,0)
end

if zButton and playerVel.x_z:length() < longJumpThreshold  then
  isCrouching = true
else
  isCrouching = false
end

if zButton and keybindState2 and grounded and playerVel.x_z:length() > longJumpThreshold then

  jumpStreak = 4
  jumpTimer = 60
  sounds:playSound("marioHighestJump3", player:getPos())
  playerVel= playerVel+ lookDir.x_z:normalized()*acceleration*2
  playerVel:add(0,-acceleration*4.5,0)
  gravity = vec(0,0.075,0)
elseif keybindState2 then
 if grounded then
  if jumpTimerStreak < 0 then
    jumpStreak = 0
  end

  if jumpStreak == 2 then
    if playerVel.x_z:length() > tripleJumpThreshold then
    jumpStreak = 3
    else
    jumpStreak = 0
    end
  end
  jumpTimerStreak = 26

  if jumpStreak == 0 or jumpStreak == 1 then
  jumpStreak = jumpStreak + 1
  end



  if jumpStreak == 1 then
  playerVel:add(0,-acceleration*7.3,0)
  sounds:playSound("marioJump"..math.random(1,3), player:getPos())
  elseif jumpStreak == 2 then
    sounds:playSound("marioHighJump", player:getPos())
    playerVel:add(0,-acceleration*8.6,0)
  elseif jumpStreak == 3 then
    playerVel:add(0,-acceleration*10,0)
    sounds:playSound("marioHighestJump"..math.random(1,3), player:getPos())
  end
  jumpTimer = 15

  end
end  
if keybindStaterot1 then
yaw = yaw-4
end
if keybindStaterot2 then
  yaw = yaw+4
  end  
  if keybindStaterot3 then
pitch = pitch-4
end
if keybindStaterot4 then
  pitch = pitch+4
  end 
  pitch = math.max(-pitchLimit, math.min(pitchLimit, pitch))

  updateCameraOrientation(yaw, pitch)


  cameraoffset = -lookDir*3.3+ vec(0,-2,0)
  





local sindivedbyonepointfive = math.sin((world.getTime()/1.5))
local sindivedbysevenpointfive = math.sin(world.getTime()/7.5)
local playervelxzlength = math.clamp(playerVel.x_z:length(),0,1)









if playerVel:length() < 0.01 then
  playerVel = vec(0,0,0)
end
if playerVel.x_z:length() > 0.01 then
  velDir = playerVel:normalized()
end
if not standingOnSeesaw then
playerVel = playerVel+gravity
else
  playerVel = playerVel+gravity * 2
end
grounded = false
grounded3 = grounded3 + 1
standingOnSeesaw = false
for i=1, 3 do 
cameraPos = cameraPos + playerVel/3

playerRot = 0

for i, mesh in pairs(colTris) do
  for k, triTranslated in pairs(mesh) do

  cameraPos = sphereTriangleCollision(cameraPos,colSphereRadius,triTranslated[1],triTranslated[2],triTranslated[3],i)
  end
end
firstCollision = false

if cameraPos.y > 200 then
  cameraPos = vec(0,-1,0)
end
end
sliding = slidingTimer>0
deltaRot = rotation:copy()

  for i, mariopart in pairs(mario) do
mariopart.translation = cameraPos:copy()-vec(0,2.5,0)
mariopart.pivot = cameraPos:copy()-vec(0,1,0)
mariopart.lookAtMode = 1
if grounded then
mariopart.lookAt = vec(groundNormal.x,-groundNormal.z,groundNormal.y)
elseif not sliding then
  mariopart.lookAt = vec(0,0,-1)
end
mariopart.up = vec(0,1,0)
if playerVel.x_z:length() ~= 0 then
  rotation = VectorToAngles(-playerVel.x_z:normalized())+vec(playerRot,180,0)

  mariopart.rotation = rotation
  end
  end
  deltaRot = deltaRot - rotation
  if not isCrouching or not grounded then 
    log(isCrouching,grounded,sliding)
  if not sliding then
if jumpTimer < 0 then
  if grounded3 <= 20 and playerVel.x_z:length()>0.15 and jumpTimer <0 then
    if world.getTime()%4 == 0 then
      sounds:playSound("marioStep", player:getPos())
    end
    mario.legL1.rotation.x = (sindivedbyonepointfive*playervelxzlength*45)+playerRot
    mario.legL2.rotation.x = (sindivedbyonepointfive*playervelxzlength*65)+playerRot
    mario.bootL.rotation.x = (sindivedbyonepointfive*playervelxzlength*65)+playerRot


    mario.legR1.rotation.x = (math.sin((world.getTime()/1.5)+math.pi)*playervelxzlength*45)+playerRot
    mario.legR2.rotation.x = (math.sin((world.getTime()/1.5)+math.pi)*playervelxzlength*65)+playerRot
    mario.bootR.rotation.x = (math.sin((world.getTime()/1.5)+math.pi)*playervelxzlength*65)+playerRot


    mario.torso1.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.torso1.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot

    mario.torso2.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.torso2.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot

    mario.head.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.head.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot





    mario.armL1.rotation.y = (sindivedbyonepointfive*playervelxzlength*40)+rotation.y
    mario.armL2.rotation.y = (sindivedbyonepointfive*playervelxzlength*60)+rotation.y
    mario.fistL.rotation.y = (sindivedbyonepointfive*playervelxzlength*60)+rotation.y
    mario.armL1.rotation.x = 40+sindivedbyonepointfive+playerRot
    mario.armL2.rotation.x = 40+sindivedbyonepointfive+playerRot
    mario.fistL.rotation.x = 40+sindivedbyonepointfive+playerRot

    mario.armR1.rotation.y = (sindivedbyonepointfive*playervelxzlength*40)+rotation.y
    mario.armR2.rotation.y = (sindivedbyonepointfive*playervelxzlength*60)+rotation.y
    mario.fistR.rotation.y = (sindivedbyonepointfive*playervelxzlength*60)+rotation.y
    mario.armR1.rotation.x = 40+sindivedbyonepointfive+playerRot
    mario.armR2.rotation.x = 40+sindivedbyonepointfive+playerRot
    mario.fistR.rotation.x = 40+sindivedbyonepointfive+playerRot
    mario.head.translation.y=mario.head.translation.y+math.sin(world.getTime()/1.5)*0.15*playervelxzlength
    mario.torso1.translation.y=mario.torso1.translation.y+math.sin(world.getTime()/1.5)*0.15*playervelxzlength
    mario.torso2.translation.y=mario.torso2.translation.y+math.sin(world.getTime()/1.5)*0.15*playervelxzlength
  end
  if grounded3 <= 20 and playerVel:length()<0.01 then
    mario.legL1.rotation.y = rotation.y
    mario.legL2.rotation.y = rotation.y
    mario.bootL.rotation.y = rotation.y


    mario.legR1.rotation.y = rotation.y
    mario.legR2.rotation.y = rotation.y
    mario.bootR.rotation.y = rotation.y
    mario.head.translation.y=mario.head.translation.y+sindivedbysevenpointfive*0.1
    mario.head.rotation.x=9+sindivedbysevenpointfive*9.5+playerRot
    mario.torso1.translation.y=mario.torso1.translation.y+sindivedbysevenpointfive*0.1
    mario.torso2.translation.y=mario.torso2.translation.y+sindivedbysevenpointfive*0.1

    mario.armR1.translation.y=mario.armR1.translation.y+sindivedbysevenpointfive*0.1
    mario.armR2.translation.y=mario.armR2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistR.translation.y=mario.fistR.translation.y+sindivedbysevenpointfive*0.1
    mario.armR1.rotation.y = 16.5+sindivedbysevenpointfive*16.5+rotation.y
    mario.armR2.rotation.y = 16.5+sindivedbysevenpointfive*16.5+rotation.y
    mario.fistR.rotation.y = 16.5+sindivedbysevenpointfive*16.5+rotation.y

    mario.armL1.translation.y=mario.armL1.translation.y+sindivedbysevenpointfive*0.1
    mario.armL2.translation.y=mario.armL2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistL.translation.y=mario.fistL.translation.y+sindivedbysevenpointfive*0.1
    mario.armL1.rotation.y = -16.5-sindivedbysevenpointfive*16.5+rotation.y
    mario.armL2.rotation.y = -16.5-sindivedbysevenpointfive*16.5+rotation.y
    mario.fistL.rotation.y = -16.5-sindivedbysevenpointfive*16.5+rotation.y



    mario.torso1.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.torso1.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot

    mario.torso2.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.torso2.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot

    mario.head.rotation.z=math.clamp(deltaRot.y*10,-25,25)
    mario.head.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot




    mario.legR1.rotation.x = 0
    mario.legR2.rotation.x = 0
    mario.bootR.rotation.x = 0

    mario.legL1.rotation.x = 0
    mario.legL2.rotation.x = 0
    mario.bootL.rotation.x = 0


    mario.armR1.rotation.x = 0
    mario.armR2.rotation.x = 0
    mario.fistR.rotation.x = 0

    mario.armL1.rotation.x = 0
    mario.armL2.rotation.x = 0
    mario.fistL.rotation.x = 0
  end

else
  if not grounded and jumpStreak == 1 then

    mario.head.translation.y=mario.head.translation.y+sindivedbysevenpointfive*0.1
    mario.head.rotation.x=25
    mario.torso1.translation.y=mario.torso1.translation.y+sindivedbysevenpointfive*0.1
    mario.torso2.translation.y=mario.torso2.translation.y+sindivedbysevenpointfive*0.1
    mario.torso1.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot
    mario.torso2.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot
    mario.armR1.translation.y=mario.armR1.translation.y+sindivedbysevenpointfive*0.1
    mario.armR2.translation.y=mario.armR2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistR.translation.y=mario.fistR.translation.y+sindivedbysevenpointfive*0.1
    mario.armR1.lookAtMode = 0
    mario.armR2.lookAtMode = 0
    mario.fistR.lookAtMode = 0
    mario.armR1.up = vec(0,-1,0)
    mario.armR2.up = vec(0,-1,0)
    mario.fistR.up = vec(0,-1,0)
    mario.armR1.lookAt = vec(0,-0.1,1):normalize()
    mario.armR2.lookAt = vec(0,-0.1,1):normalize()
    mario.fistR.lookAt = vec(0,-0.1,1):normalize()
    mario.armR1.rotation.y = rotation.y+35
    mario.armR2.rotation.y = rotation.y+35
    mario.fistR.rotation.y = rotation.y+35

    mario.armL1.translation.y=mario.armL1.translation.y+sindivedbysevenpointfive*0.1
    mario.armL2.translation.y=mario.armL2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistL.translation.y=mario.fistL.translation.y+sindivedbysevenpointfive*0.1
    mario.armL1.rotation.y = rotation.y+50
    mario.armL2.rotation.y = rotation.y+50
    mario.fistL.rotation.y = rotation.y+50

    mario.legR1.pivot.y = mario.legR1.pivot.y-0.3
    mario.legR2.pivot.y = mario.legR2.pivot.y-0.3
    mario.bootR.pivot.y = mario.bootR.pivot.y-0.3
    mario.legR1.translation.z = mario.legR1.translation.z+1.2
    mario.legR2.translation.z = mario.legR2.translation.z+1.2
    mario.bootR.translation.z = mario.bootR.translation.z+1.2
    mario.legR1.rotation.x = 75
    mario.legR2.rotation.x = 75
    mario.bootR.rotation.x = 75


    mario.legL1.pivot.y = mario.legL1.pivot.y-0.3
    mario.legL2.pivot.y = mario.legL2.pivot.y-0.3
    mario.bootL.pivot.y = mario.bootL.pivot.y-0.3
    mario.legL1.translation.z = mario.legL1.translation.z-1.2
    mario.legL2.translation.z = mario.legL2.translation.z-1.2
    mario.bootL.translation.z = mario.bootL.translation.z-1.2
    mario.legL1.rotation.x = -75
    mario.legL2.rotation.x = -75
    mario.bootL.rotation.x = -75
  end
  if not grounded and jumpStreak == 2 then
    mario.head.translation.y=mario.head.translation.y+sindivedbysevenpointfive*0.1
    mario.head.rotation.x=9+sindivedbysevenpointfive*9.5+playerRot
    mario.torso1.translation.y=mario.torso1.translation.y+sindivedbysevenpointfive*0.1
    mario.torso2.translation.y=mario.torso2.translation.y+sindivedbysevenpointfive*0.1
    mario.torso1.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot
    mario.torso2.rotation.x=math.clamp(deltaRot.y*0,-40,40)+playerRot
    mario.armR1.translation.y=mario.armR1.translation.y+sindivedbysevenpointfive*0.1
    mario.armR2.translation.y=mario.armR2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistR.translation.y=mario.fistR.translation.y+sindivedbysevenpointfive*0.1
    mario.armR1.rotation.y = rotation.y-10
    mario.armR2.rotation.y = rotation.y-10
    mario.fistR.rotation.y = rotation.y-10

    mario.armL1.translation.y=mario.armL1.translation.y+sindivedbysevenpointfive*0.1
    mario.armL2.translation.y=mario.armL2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistL.translation.y=mario.fistL.translation.y+sindivedbysevenpointfive*0.1
    mario.armL1.rotation.y = rotation.y+10
    mario.armL2.rotation.y = rotation.y+10
    mario.fistL.rotation.y = rotation.y+10


    mario.legR1.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24
    mario.legR2.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24
    mario.bootR.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24

    mario.legL1.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24
    mario.legL2.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24
    mario.bootL.rotation.x = math.sin((world.getTime()+8.5)/3.5)*24


  end
  if not grounded and jumpStreak == 3 then
    mario.head.translation.y=mario.head.translation.y+sindivedbysevenpointfive*0.1
    mario.head.rotation.x=9+sindivedbysevenpointfive*9.5+playerRot
    mario.torso1.translation.y=mario.torso1.translation.y+sindivedbysevenpointfive*0.1
    mario.torso2.translation.y=mario.torso2.translation.y+sindivedbysevenpointfive*0.1

    

    mario.armR1.translation.y=mario.armR1.translation.y+sindivedbysevenpointfive*0.1
    mario.armR2.translation.y=mario.armR2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistR.translation.y=mario.fistR.translation.y+sindivedbysevenpointfive*0.1
    mario.armR1.rotation.y = rotation.y-10
    mario.armR2.rotation.y = rotation.y-10
    mario.fistR.rotation.y = rotation.y-10

    mario.armL1.translation.y=mario.armL1.translation.y+sindivedbysevenpointfive*0.1
    mario.armL2.translation.y=mario.armL2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistL.translation.y=mario.fistL.translation.y+sindivedbysevenpointfive*0.1
    mario.armL1.rotation.y = rotation.y+10
    mario.armL2.rotation.y = rotation.y+10
    mario.fistL.rotation.y = rotation.y+10


    mario.legR1.rotation.x = 54*(20-jumpTimer)
    mario.legR2.rotation.x = 54*(20-jumpTimer)
    mario.bootR.rotation.x = 54*(20-jumpTimer)

    mario.legL1.rotation.x = 54*(20-jumpTimer)
    mario.legL2.rotation.x = 54*(20-jumpTimer)
    mario.bootL.rotation.x = 54*(20-jumpTimer)

    mario.armR1.rotation.x = 54*(20-jumpTimer)
    mario.armR2.rotation.x = 54*(20-jumpTimer)
    mario.fistR.rotation.x = 54*(20-jumpTimer)

    mario.armL1.rotation.x = 54*(20-jumpTimer)
    mario.armL2.rotation.x = 54*(20-jumpTimer)
    mario.fistL.rotation.x = 54*(20-jumpTimer)

    mario.head.rotation.x = 54*(20-jumpTimer)
    mario.torso1.rotation.x = 54*(20-jumpTimer)
    mario.torso2.rotation.x = 54*(20-jumpTimer)
  end
  if not grounded and jumpStreak == 4 then
    mario.head.translation.y=mario.head.translation.y+sindivedbysevenpointfive*0.1
    mario.head.rotation.x=9+sindivedbysevenpointfive*9.5+playerRot
    mario.torso1.translation.y=mario.torso1.translation.y+sindivedbysevenpointfive*0.1
    mario.torso2.translation.y=mario.torso2.translation.y+sindivedbysevenpointfive*0.1

    

    mario.armR1.translation.y=mario.armR1.translation.y+sindivedbysevenpointfive*0.1
    mario.armR2.translation.y=mario.armR2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistR.translation.y=mario.fistR.translation.y+sindivedbysevenpointfive*0.1
    mario.armR1.rotation.y = rotation.y-35
    mario.armR2.rotation.y = rotation.y-35
    mario.fistR.rotation.y = rotation.y-35

    mario.armL1.translation.y=mario.armL1.translation.y+sindivedbysevenpointfive*0.1
    mario.armL2.translation.y=mario.armL2.translation.y+sindivedbysevenpointfive*0.1
    mario.fistL.translation.y=mario.fistL.translation.y+sindivedbysevenpointfive*0.1
    mario.armL1.rotation.y = rotation.y+35
    mario.armL2.rotation.y = rotation.y+35
    mario.fistL.rotation.y = rotation.y+35

    mario.legR1.pivot.y = mario.legR1.pivot.y-0.5
    mario.legR2.pivot.y = mario.legR2.pivot.y-0.5
    mario.bootR.pivot.y = mario.bootR.pivot.y-0.5
    mario.legR1.translation.z = mario.legR1.translation.z-1
    mario.legR2.translation.z = mario.legR2.translation.z-1
    mario.bootR.translation.z = mario.bootR.translation.z-1
    mario.legR1.rotation.x = -75
    mario.legR2.rotation.x = -75
    mario.bootR.rotation.x = -75

    mario.legL1.pivot.y = mario.legL1.pivot.y-0.5
    mario.legL2.pivot.y = mario.legL2.pivot.y-0.5
    mario.bootL.pivot.y = mario.bootL.pivot.y-0.5
    mario.legL1.translation.z = mario.legL1.translation.z-1
    mario.legL2.translation.z = mario.legL2.translation.z-1
    mario.bootL.translation.z = mario.bootL.translation.z-1
    mario.legL1.rotation.x = -75
    mario.legL2.rotation.x = -75
    mario.bootL.rotation.x = -75


  end
end
else

  sounds:playSound("slide"..math.random(1,7), player:getPos(),0.1)
  mario.legR1.rotation.x = 90
  mario.legR2.rotation.x = 90
  mario.bootR.rotation.x = 90
  mario.legL1.rotation.x = 90
  mario.legL2.rotation.x = 90
  mario.bootL.rotation.x = 90
  mario.armR1.rotation.x = 90
  mario.armR2.rotation.x = 90
  mario.fistR.rotation.x = 90
  mario.armL1.rotation.x = 90
  mario.armL2.rotation.x = 90
  mario.fistL.rotation.x = 90
  mario.head.rotation.x =  90
  mario.torso1.rotation.x =90
  mario.torso2.rotation.x =90


  mario.armL1.rotation.y = rotation.y+20
  mario.armL2.rotation.y = rotation.y+20
  mario.fistL.rotation.y = rotation.y+20
  mario.armR1.rotation.y = rotation.y-20
  mario.armR2.rotation.y = rotation.y-20
  mario.fistR.rotation.y = rotation.y-20

  mario.head.rotation.x = 15


jumpStreak = 0

jumpTimer = 0

  
end
else
  log(grounded,prevGrounded)
if not prevGrounded and grounded then

  playerVel = (velDir.x_z):normalized()*0.025
end
if grounded then
  for i, mariopart in pairs(mario) do
    mariopart.translation = cameraPos:copy()-vec(0,2.5,0)
    mariopart.pivot = cameraPos:copy()-vec(0,1,0)
    mariopart.lookAtMode = 1
    mariopart.up = vec(0,1,0)
mariopart.lookAt = vec(0,0,-1)

  end

  mario.head.translation.y=mario.head.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.head.pivot.y=mario.head.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.head.rotation.x=9+sindivedbysevenpointfive*9.5+playerRot+40
  mario.torso1.translation.y=mario.torso1.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.torso1.pivot.y=mario.torso1.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.torso1.rotation.x = 40
  mario.torso2.translation.y=mario.torso2.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.torso2.pivot.y=mario.torso2.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.torso2.rotation.x = 40

  

  mario.armR1.translation.y=mario.armR1.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.armR2.translation.y=mario.armR2.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.fistR.translation.y=mario.fistR.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.armR1.pivot.y=mario.armR1.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.armR2.pivot.y=mario.armR2.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.fistR.pivot.y=mario.fistR.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.armR1.rotation.x = 180+40
  mario.armR2.rotation.x = 180+40
  mario.fistR.rotation.x = 180+40

  mario.armL1.translation.y=mario.armL1.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.armL2.translation.y=mario.armL2.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.fistL.translation.y=mario.fistL.translation.y+0.500+sindivedbysevenpointfive*0.1
  mario.armL1.pivot.y=mario.armL1.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.armL2.pivot.y=mario.armL2.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.fistL.pivot.y=mario.fistL.pivot.y+0.500+sindivedbysevenpointfive*0.1
  mario.armL1.rotation.x = 180+40
  mario.armL2.rotation.x = 180+40
  mario.fistL.rotation.x = 180+40


  mario.legR1.rotation.x = -90
  mario.legR1.rotation.y =   rotation.y-25
  mario.legR1.pivot = mario.legR1.pivot + velDir.x_z*-0.4+ vec(0,0.89+sindivedbysevenpointfive*0.05,0)
  mario.legR1.translation = mario.legR1.translation + velDir.x_z*-0.4+ vec(0,0.89+sindivedbysevenpointfive*0.05,0)


  mario.legL1.rotation.x = -90
  mario.legL1.rotation.y =   rotation.y+25
  mario.legL1.pivot = mario.legL1.pivot + velDir.x_z*-0.4 + vec(0,0.89+sindivedbysevenpointfive*0.05,0)
  mario.legL1.translation = mario.legL1.translation + velDir.x_z*-0.4+ vec(0,0.89+sindivedbysevenpointfive*0.05,0)

  mario.legL2.pivot = mario.legL2.pivot + velDir.x_z*0.45 + vec(-velDir.z,velDir.y,velDir.x)*0.9
  mario.legL2.translation = mario.legL2.translation + velDir.x_z*0.45 + vec(-velDir.z,velDir.y,velDir.x)*0.9

  mario.legR2.pivot = mario.legR2.pivot + velDir.x_z*0.45 - vec(-velDir.z,velDir.y,velDir.x)*0.9
  mario.legR2.translation = mario.legR2.translation + velDir.x_z*0.45 - vec(-velDir.z,velDir.y,velDir.x)*0.9

  mario.bootL.pivot = mario.bootL.pivot + velDir.x_z*0.45 + vec(-velDir.z,velDir.y,velDir.x)*0.9
  mario.bootL.translation = mario.bootL.translation + velDir.x_z*0.45 + vec(-velDir.z,velDir.y,velDir.x)*0.9

  mario.bootR.pivot = mario.bootR.pivot + velDir.x_z*0.45 - vec(-velDir.z,velDir.y,velDir.x)*0.9
  mario.bootR.translation = mario.bootR.translation + velDir.x_z*0.45 - vec(-velDir.z,velDir.y,velDir.x)*0.9
end
end


if grounded then
playerVel:mul(friction-0.24,friction,friction-0.24)
elseif sliding then
  playerVel:mul(friction-0.04,friction,friction-0.04)
else
  playerVel:mul(friction-0.025,friction,friction-0.025)
end

end  

function pings.sync(pos,dir)
lookDir = dir
colSpherePos = pos
end


function pings.state(kb,state)

    if kb == 1 then
      keybindStatew = state
    end
    if kb == 2 then
      keybindStates = state
    end
    if kb == 3 then
      keybindStatea = state
    end
    if kb == 4 then
      keybindStated = state
    end
    if kb == 5 then
      keybindState1 = state
    end
    if kb == 6 then
      keybindState2 = state
    end
    if kb == 7 then
      movementToggle = state
    end
    if kb == 8 then
      zButton = state
    end
  end




  function events.mouse_move(x, y)
    if player:isLoaded() and not movementToggle then
      
      yaw = yaw-x/4
  
      pitch = pitch+y/4
      
      if pitch > 89 then 
        pitch = 89
      end
      if pitch < -10 then 
        pitch = -10
      end
      return true
    end
  end



local onevector = vec(0,1,0)

-- Check if a point is inside a triangle using barycentric coordinates
local function pointInTriangle(point, v0, v1, v2)
  local v0v1 = v1 - v0
  local v0v2 = v2 - v0
  local v0p = point - v0

  local d00 = v0v1:dot(v0v1)
  local d01 = v0v1:dot(v0v2)
  local d11 = v0v2:dot( v0v2)
  local d20 = v0p:dot( v0v1)
  local d21 = v0p:dot( v0v2)

  local denom = d00 * d11 - d01 * d01
  local v = (d11 * d20 - d01 * d21) / denom
  local w = (d00 * d21 - d01 * d20) / denom
  local u = 1 - v - w

  return u >= 0 and v >= 0 and w >= 0
end

  local function projectPointOntoPlane(point, planeNormal, planePoint)

    return (point- planeNormal* (point - planePoint):dot(planeNormal))
  end
  local seesawspeed = 130
  local seesawRotationLimit = 50
local seesawRotation = 0
local seesawDir = vectors.angleToDir(0,43)

function sphereTriangleCollision(sphereCenter, sphereRadius, v0, v1, v2,i)


  local triangleNormal = (v1 - v0):crossed(v2 - v0):normalize()

  if pointInTriangle( (sphereCenter- triangleNormal* (sphereCenter - v0):dot(triangleNormal)), v0, v1, v2) then

      local distanceToPlane = (sphereCenter- v0):dot(triangleNormal)

      if math_abs(distanceToPlane) < sphereRadius then

          local moveDirection = triangleNormal* (sphereRadius - math_abs(distanceToPlane))


          if i == 7 then
            
            sphereCenter = sphereCenter+ moveDirection._y_ * 1.75
            playerVel.y = 1
          playerVel = playerVel + gravity-(gravity:dot(triangleNormal))*triangleNormal
          slidingTimer = 17
          groundNormal = triangleNormal
          else
            sphereCenter = sphereCenter+ moveDirection._y_
          if math.deg(math.acos(triangleNormal:dot(vec(0,-1,0))))<72 then  
          groundNormal = triangleNormal
          if slidingTimer <= 0 then
            grounded = true
            grounded3 = 0
          end
            playerVel.y = 0

            if i == "seesaw" and firstCollision then
              standingOnSeesaw = true
              local rotvec = -BBmodelToMesh.seesaw.translation+cameraPos
              seesawRotation = seesawRotation + ((rotvec):length()/seesawspeed)*seesawDir:dot(rotvec)
              seesawRotation = math_clamp(seesawRotation,-seesawRotationLimit,seesawRotationLimit)
              sphereCenter = sphereCenter+ moveDirection.x_z
              if math.abs(seesawRotation) > 35 then
                playerVel = playerVel + gravity-(gravity:dot(triangleNormal))*triangleNormal
                slidingTimer = 17
              end
              BBmodelToMesh.seesaw.rotation = vec(seesawRotation,133,1)
            end

    --        local rot = math.clamp(-math.deg(math.acos(triangleNormal:dot(-onevector))),-13,20)
         --   if  rot < playerRot then
      --      playerRot = rot
        --    end

          else

            sphereCenter = sphereCenter+ moveDirection.x_z
          end
          if (i ~= "seesaw" or not grounded)  and firstCollision then
            seesawRotation = seesawRotation-math.sign(seesawRotation)*0.66
            if seesawRotation < 0.4 and seesawRotation > -0.4 then
              seesawRotation = 0
            end
            BBmodelToMesh.seesaw.rotation = vec(seesawRotation,133,0)
          end

        end
      end
  end

  return sphereCenter
end



