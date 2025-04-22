local line = require("Bresenham")
local Y90degRotMat= matrices.yRotation3(90)
require("Main")
local math_abs = math.abs 
local math_min = math.min
local math_max = math.max
local math_floor = math.floor
local math_ceil = math.ceil
local math_clamp = math.clamp
local nullVector = vec(0,0,0)
local function cross2D (vec1a,vec2a)
return vec1a.x*vec2a.y -vec1a.y*vec2a.x
end  
local function dirToAngle(dir)
  return vec(-math.deg(math.atan2(dir.y, math.sqrt(dir.x * dir.x + dir.z * dir.z))), math.deg(math.atan2(dir.x, dir.z)), 0)
end
Screen = {}
local screenPart = models:newPart("Screen", "WORLD")
--Creates a screen
--- @param pos Vec3 Position of the screen
--- @param rot Vec3 Rotation of the screen
--- @param width Integer Width of the screen(pixels)
--- @param height Integer Height of the screen(pixels)
function createScreen(pos,rot,width,height)
local screenText = textures:newTexture("screenText",width , height)
local sprite = screenPart:newSprite("Screen"):setPos(pos*16 + vec(0,100,0) + vec(0,player:getEyeHeight(),0)*16 + player:getLookDir()*120 + player:getLookDir()*Y90degRotMat*100 or vec(0,height,0)):setRot(rot or vec(0,0,0)):setTexture(screenText,200,200):setRot(dirToAngle(player:getLookDir()))
local sprite2 = screenPart:newSprite("Screen2"):setPos(pos*16 + vec(0,100,0) + vec(0,player:getEyeHeight(),0)*16 + player:getLookDir()*121 + player:getLookDir()*Y90degRotMat*100 or vec(0,height,0)):setRot(rot or vec(0,0,0)):setTexture(textures["bobthebetter.bck"],200,200):setRegion(354/8,242/2):setRot(dirToAngle(player:getLookDir()))
Screen = {sprite = sprite, screenText = screenText,width=width,height= height,sprite2=sprite2}
end
--Clears the screen
function clearScreen()


    Screen.sprite2:setUV(-yaw/360,0.22+pitch/180)
    Screen.screenText:fill(0,0,Screen.width,Screen.height,0, 165/255, 201/255,0)

end
--Draws a pixel if its inside of the screen
--- @param pos Vec2 Position of the pixel
--- @param rgb Vec3 Color of the pixel
function drawPix(pos,rgb)
  if pos.x >= 0 and pos.x <= width - 2 and pos.y >= 0 and pos.y <= height-2 then
  Screen.screenText:setPixel(pos.x,pos.y,rgb)
  end
end
--I think this calculates the areas of triangles created from a point but idk ai wrote this
function calculateBarycentric(p, a, b, c)

  local denominator = ((b.y - c.y) * (a.x - c.x) + (c.x - b.x) * (a.y - c.y))
  if denominator == 0 then
      return nil, nil, nil 
  end
  local lambda1 = ((b.y - c.y) * (p.x - c.x) + (c.x - b.x) * (p.y - c.y)) / denominator
  local lambda2 = ((c.y - a.y) * (p.x - c.x) + (a.x - c.x) * (p.y - c.y)) / denominator
  local lambda3 = 1 - lambda1 - lambda2

  return lambda1, lambda2, lambda3
end

--Draws a textureless triangle 
--- @param pos1 Vec2 Triangle vertex
--- @param pos2 Vec2 Triangle vertex
--- @param pos3 Vec2 Triangle vertex
--- @param color Vec3 Triangle color
function drawTriangle(pos1, pos2, pos3, color)

  local xMin = math_floor(math_min(pos1.x, pos2.x, pos3.x))
  local xMax = math_ceil(math_max(pos1.x, pos2.x, pos3.x))
  local yMin = math_floor(math_min(pos1.y, pos2.y, pos3.y))
  local yMax = math_ceil(math_max(pos1.y, pos2.y, pos3.y))

  xMin = math_max(0, xMin)
  xMax = math_min(width - 1, xMax)
  yMin = math_max(0, yMin)
  yMax = math_min(height - 1, yMax)

  for y = yMin, yMax do
    for x = xMin, xMax do
      local lambda1, lambda2, lambda3 = calculateBarycentric(vec(x, y), pos1, pos2, pos3)
      if lambda1 and lambda2 and lambda3 and lambda1 >= 0 and lambda2 >= 0 and lambda3 >= 0 then
        Screen.screenText:setPixel(x, y, color)
      end
    end
  end
end
--Draws a line
--- @param pos1 Vec2 Line start
--- @param pos2 Vec2 Line end
--- @param color Vec3 Line color
function drawLine(pos1,pos2,color)
  line.line( math_floor(pos1.x), math_floor(pos1.y), math_floor(pos2.x), math_floor(pos2.y), 
  function( x, y, counter )
    if x >= 1 and x <= width - 2 and y >= 1 and y <= height-2 then
      Screen.screenText:setPixel(x,y,color)
    end
      return true
  end)
end  



--- @param pos1 Vec2 Triangle vertex
--- @param pos2 Vec2 Triangle vertex
--- @param pos3 Vec2 Triangle vertex
--- @param uv1 Vec2 Triangle uv
--- @param uv2 Vec2 Triangle uv
--- @param uv3 Vec2 Triangle uv
--- @param tex String Texture name
--- @param brightness Number Brightness of the triangle
function drawTexturedTriangle(pos1, pos2, pos3, uv1, uv2, uv3, tex,brightness)

  if uv1.z+0.015 >= depthBuffer[pos1.y][pos1.x] or uv2.z+0.015 >= depthBuffer[pos2.y][pos2.x] or uv3.z+0.015 >= depthBuffer[pos3.y][pos3.x] then
  if (pos1 - pos2):length() >= 1 and (pos1 - pos3):length() >= 1 then

  local sctext = Screen.screenText
  local OptimizedTexture = OptimizedTextures[tex]
  local dimensionxminus2= OptimizedTexture.dimx2
  local clampedBrightness = math_clamp(brightness/1.5,0.3,1)
  if pos2.y < pos1.y then
      pos1,pos2 = pos2,pos1
      uv1,uv2 = uv2,uv1
  end  

  if pos3.y < pos1.y then
      pos1,pos3 = pos3,pos1
      uv1,uv3 = uv3,uv1
  end  

  if pos3.y < pos2.y then
      pos2,pos3 = pos3,pos2
      uv2,uv3 = uv3,uv2
  end  
  local uv1x,uv1y,uv1z = uv1.x,uv1.y,uv1.z
  local uv2x,uv2y,uv2z = uv2.x,uv2.y,uv2.z
  local uv3x,uv3y,uv3z = uv3.x,uv3.y,uv3.z
  local pos1x,pos1y = pos1.x,pos1.y
  local pos2x,pos2y = pos2.x,pos2.y
  local pos3x,pos3y = pos3.x,pos3.y
  -- Compute delta values for the upper half of the triangle
  local dy1 = pos2y - pos1y
  local dx1 = pos2x - pos1x
  local du1 = uv2x - uv1x
  local dv1 = uv2y - uv1y
  local dw1 = uv2z - uv1z

  local dy2 = pos3y - pos1y
  local dx2 = pos3x - pos1x
  local du2 = uv3x - uv1x
  local dv2 = uv3y - uv1y
  local dw2 = uv3z - uv1z

  -- Initialize variables for interpolation



  local  dbxStep = dx2 / dy2 
  local  du2Step = du2 / dy2 
  local  dv2Step = dv2 / dy2 
  local  dw2Step = dw2 / dy2 


  -- Render the upper part of the triangle
  if dy1 ~= 0 then

    local daxStep = dx1 / dy1
    local du1Step = du1 / dy1
    local dv1Step = dv1 / dy1
    local dw1Step = dw1 / dy1
    for i = pos1y, pos2y do
      local iminuspos1doty = (i - pos1y)

      local ax = math_ceil(pos1x + iminuspos1doty * daxStep)
      local bx = math_ceil(pos1x + iminuspos1doty * dbxStep)
      local texSU
      local texSV
      local texSW
      local texEU
      local texEW
      local texEV
      if ax > bx then
        ax,bx=bx,ax
        texEU = uv1x + iminuspos1doty * du1Step
        texEV = uv1y + iminuspos1doty * dv1Step
        texEW = uv1z + iminuspos1doty * dw1Step
  
        texSU = uv1x + iminuspos1doty * du2Step
        texSV = uv1y + iminuspos1doty * dv2Step
        texSW = uv1z + iminuspos1doty * dw2Step

      else
        texSU = uv1x + iminuspos1doty * du1Step
        texSV = uv1y + iminuspos1doty * dv1Step
        texSW = uv1z + iminuspos1doty * dw1Step
  
        texEU = uv1x + iminuspos1doty * du2Step
        texEV = uv1y + iminuspos1doty * dv2Step
        texEW = uv1z + iminuspos1doty * dw2Step
      end




      local texEUminusTexSU = texEU-texSU
      local texEVminusTexSV = texEV-texSV
      local texEWminusTexSW = texEW-texSW

      local texSUPrecomputed = texSU * dimensionxminus2
      local texSVPrecomputed = texSV * dimensionxminus2

      local tStep = 1 / (bx - ax)
      local t = 0


      local depthBufferIndexI = depthBuffer[i]
      for j = ax, bx do
        local texW = texSW + t*texEWminusTexSW
          
        if texW > depthBufferIndexI[j] then
          local tPrecomputed = t*dimensionxminus2

          local color = OptimizedTexture[math_ceil(((texSUPrecomputed + tPrecomputed*texEUminusTexSU)/texW) )][math_ceil(((texSVPrecomputed + tPrecomputed*texEVminusTexSV)/texW ))]
          if color then
          sctext:setPixel(j, i, color*clampedBrightness)
          depthBufferIndexI[j] = texW
          end
          
        end

        t = t + tStep

      end

    end

  end  

  -- Compute new delta values for the lower half of the triangle
  dy1 = pos3y - pos2y







  -- Render the lower part of the triangle
  if dy1 ~= 0 then
    dx1 = pos3x - pos2x
    du1 = uv3x - uv2x
    dv1 = uv3y - uv2y
    dw1 = uv3z - uv2z
    local daxStep = dx1 / dy1
    local du1Step = du1 / dy1
    local dv1Step = dv1 / dy1
    local dw1Step = dw1 / dy1
    for i = pos2y, pos3y do

      local iminuspos2doty = (i - pos2y)
      local iminuspos1doty = (i - pos1y)
      local ax = math_ceil(pos2x + iminuspos2doty * daxStep)
      local bx = math_ceil(pos1x + iminuspos1doty * dbxStep)



      local texSU
      local texSV
      local texSW
      local texEU
      local texEW
      local texEV
      if ax > bx then
        ax,bx=bx,ax
        texEU = uv2x + iminuspos2doty * du1Step
        texEV = uv2y + iminuspos2doty * dv1Step
        texEW = uv2z + iminuspos2doty * dw1Step
  
        texSU = uv1x + iminuspos1doty * du2Step
        texSV = uv1y + iminuspos1doty * dv2Step
        texSW = uv1z + iminuspos1doty * dw2Step

      else
        texSU = uv2x + iminuspos2doty * du1Step
        texSV = uv2y + iminuspos2doty * dv1Step
        texSW = uv2z + iminuspos2doty * dw1Step
  
        texEU = uv1x + iminuspos1doty * du2Step
        texEV = uv1y + iminuspos1doty * dv2Step
        texEW = uv1z + iminuspos1doty * dw2Step
      end


      local texEUminusTexSU = texEU-texSU
      local texEVminusTexSV = texEV-texSV
      local texEWminusTexSW = texEW-texSW
      local texSUPrecomputed = texSU * dimensionxminus2
      local texSVPrecomputed = texSV * dimensionxminus2
      local tStep = 1 / (bx - ax)
      local t = 0
      local depthBufferIndexI = depthBuffer[i]
      for j = ax, bx do
        local texW = texSW + t*texEWminusTexSW

        if texW > depthBufferIndexI[j] then
          local tPrecomputed = t*dimensionxminus2


          local color = OptimizedTexture[math_ceil(((texSUPrecomputed + tPrecomputed*texEUminusTexSU)/texW) )][math_ceil(((texSVPrecomputed + tPrecomputed*texEVminusTexSV)/texW ))]
          if color then
          sctext:setPixel(j, i, color*clampedBrightness)
          depthBufferIndexI[j] = texW
          end

 
        end
        t = t + tStep
      end
    end
  end 
end
end
end
