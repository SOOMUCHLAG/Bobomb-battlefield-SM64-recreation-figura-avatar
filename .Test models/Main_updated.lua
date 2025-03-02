width =130
height =130
texture = textures["blockss.texture"]
local yaw = 90
--models.model:setVisible(false)
local pitch = 0
local function multMatrix(vec3d,mat)
  local multvec = mat * vec(vec3d.x,vec3d.y,vec3d.z,1)
  local w = multvec.w
  if multvec.w ~= 0 then
  return vec(multvec.x,multvec.y,multvec.z)/multvec.w,w
  else 
  return vec(multvec.x,multvec.y,multvec.z)
  end



end
local function pointAtMatrix(pos,target,up)
local newForward = (target - pos):normalized()

local a = newForward * up:dot(newForward)
local newUp = (up-a):normalized()

local newRight = newUp:crossed(newForward)

local tranMat = matrices.mat4()
tranMat[1] = vec(newRight.x,newRight.y,newRight.z,0)
tranMat[2] = vec(newUp.x,newUp.y,newUp.z,0)
tranMat[3] = vec(newForward.x,newForward.y,newForward.z,0)
tranMat[4] = vec(pos.x,pos.y,pos.z,1)
return tranMat
end  
local function QuickInverse(mat)
local traslation = vec(mat[4].x,mat[4].y,mat[4].z)
local A = vec(mat[1].x,mat[1].y,mat[1].z)
local B = vec(mat[2].x,mat[2].y,mat[2].z)
local C = vec(mat[3].x,mat[3].y,mat[3].z)
local newMat = matrices.mat4()
newMat[1] = vec(mat[1].x,mat[2].x,mat[3].x,0)
newMat[2] = vec(mat[1].y,mat[2].y,mat[3].y,0)
newMat[3] = vec(mat[1].z,mat[2].z,mat[3].z,0)
newMat[4] = vec((-traslation):dot(A),(-traslation):dot(B),(-traslation):dot(C),1)
return newMat
end

local function dist(planeNormal,planePoint,p)
p:normalize()
  return (planeNormal.x * p.x + planeNormal.y * p.y + planeNormal.z * p.z - planeNormal:dot(planePoint))
end


local function Vector_IntersectPlane(planePoint, planeNormal, lineStart, lineEnd)

  planeNormal = planeNormal:normalize()
  local plane_d = -planeNormal:dot(planePoint)
  local ad = lineStart:dot(planeNormal)
  local bd = lineEnd:dot(planeNormal)
  local t = (-plane_d - ad) / (bd - ad)
  local lineStartToEnd = lineEnd - lineStart
  local lineToIntersect = lineStartToEnd * t
  return (lineStart + lineToIntersect),t
end

local function triClipAgainstPlane(planePoint,planeNormal,triangle)
planeNormal = planeNormal:normalize()

local insidePoints = {}
local outsidePoints = {}
local insideCount = 0
local outsideCount = 0
local insideTexes = {}
local outsideTexes = {}
local insideTexCount = 0
local outsideTexCount = 0



local d0 = dist(planeNormal,planePoint,triangle[1])
local d1 = dist(planeNormal,planePoint,triangle[2])
local d2 = dist(planeNormal,planePoint,triangle[3])
--6-8
if d0 >= 0 then
  insideCount = insideCount + 1
  insideTexCount = insideTexCount + 1
  table.insert(insidePoints,triangle[1])
  table.insert(insideTexes,triangle[6])
else
  outsideCount = outsideCount + 1
  outsideTexCount = outsideTexCount + 1
  table.insert(outsidePoints,triangle[1])
  table.insert(outsideTexes,triangle[6])
end

if d1 >= 0 then
  insideCount = insideCount + 1
  insideTexCount = insideTexCount + 1
  table.insert(insidePoints,triangle[2])
  table.insert(insideTexes,triangle[7])
else
  outsideCount = outsideCount + 1
  outsideTexCount = outsideTexCount + 1
  table.insert(outsidePoints,triangle[2])
  table.insert(outsideTexes,triangle[7])
end

if d2 >= 0 then
  insideCount = insideCount + 1
  insideTexCount = insideTexCount + 1
  table.insert(insidePoints,triangle[3])
  table.insert(insideTexes,triangle[8])
else
  outsideCount = outsideCount + 1
  outsideTexCount = outsideTexCount + 1
  table.insert(outsidePoints,triangle[3])
  table.insert(outsideTexes,triangle[8])
end

if insideCount == 0 then
return 0
end 

if insideCount == 3 then
 
return 1, triangle
end

if insideCount == 1 and outsideCount == 2 then

  local outTriangle = {}

  outTriangle[4] = vec(0,0,1)--triangle[4]
  outTriangle[5] = triangle[5]

  outTriangle[1] = insidePoints[1]
  outTriangle[6] = insideTexes[1]
local t
outTriangle[7] = vec(0,0,0)
  outTriangle[2],t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[1])
  outTriangle[7].x = t * (outsideTexes[1].x-insideTexes[1].x) + insideTexes[1].x
  outTriangle[7].y = t * (outsideTexes[1].y-insideTexes[1].y) + insideTexes[1].y
  outTriangle[7].z = t * (outsideTexes[1].z-insideTexes[1].z) + insideTexes[1].z

  outTriangle[8] = vec(0,0,0)
  outTriangle[3],t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[2])
  outTriangle[8].x = t * (outsideTexes[2].x-insideTexes[1].x) + insideTexes[1].x
  outTriangle[8].y = t * (outsideTexes[2].y-insideTexes[1].y) + insideTexes[1].y
  outTriangle[8].z = t * (outsideTexes[2].z-insideTexes[1].z) + insideTexes[1].z



  return 1,outTriangle
end

if insideCount == 2 and outsideCount == 1 then
  local outTriangle1 = {}
  local outTriangle2 = {}
local t
  outTriangle1[4] = vec(1,0,0)--triangle[4]
  outTriangle1[5] = triangle[5]
  
  outTriangle2[4] = vec(0,1,0)--triangle[4]
  outTriangle2[5] = triangle[5]

  outTriangle1[1] = insidePoints[1]
  outTriangle1[6] = insideTexes[1]
  outTriangle1[2] = insidePoints[2]
  outTriangle1[7] = insideTexes[2]
  outTriangle1[8] = vec(0,0,0)
  outTriangle1[3],t = Vector_IntersectPlane(planePoint, planeNormal, insidePoints[2], outsidePoints[1])
 
  outTriangle1[8].x = t * (outsideTexes[1].x - insideTexes[2].x) + insideTexes[2].x
  outTriangle1[8].y = t * (outsideTexes[1].y - insideTexes[2].y) + insideTexes[2].y
  outTriangle1[8].z = t * (outsideTexes[1].z - insideTexes[2].z) + insideTexes[2].z

  outTriangle2[3] = insidePoints[1]
  outTriangle2[8] = insideTexes[1]
  outTriangle2[2] = outTriangle1[3]
  outTriangle2[7] = outTriangle1[8]
  outTriangle2[6] = vec(0,0,0)
  outTriangle2[1],t =Vector_IntersectPlane(planePoint, planeNormal, insidePoints[1], outsidePoints[1])
  outTriangle2[6].x = t * (outsideTexes[1].x - insideTexes[1].x) + insideTexes[1].x
  outTriangle2[6].y = t * (outsideTexes[1].y - insideTexes[1].y) + insideTexes[1].y
  outTriangle2[6].z = t * (outsideTexes[1].z - insideTexes[1].z) + insideTexes[1].z

  return 2,outTriangle1,outTriangle2
end
end
--[[
local function clipTriangleAgainstAllPlanes(triangles)
    local clippedTriangles = {}
    
    -- Define the clipping planes
    local screenPlanes = {
      {planePoint = vec(0, -0.65, 0), planeNormal = vec(0, 1, 0)},  -- Top
        {planePoint = vec(0, 0.65, 0), planeNormal = vec(0, -1, 0)},  -- Bottom
        {planePoint = vec(-0.65, 0, 0), planeNormal = vec(1, 0, 0)},  -- Left
        {planePoint = vec(0.65, 0, 0), planeNormal = vec(-1, 0, 0)}  -- Right
    }

    -- Add initial triangles to the queue
    local queue = {}
    for _, tri in ipairs(triangles) do
        table.insert(queue, tri)
    end

    -- Iterate through each plane for clipping
    for i, plane in ipairs(screenPlanes) do
        local newTriangles = {}

        -- Process each triangle currently in the queue
        while #queue > 0 do
            local testTriangle = table.remove(queue, 1)

            -- Clip against the current plane
            local numClipped, clippedTri1, clippedTri2 = triClipAgainstPlane(plane.planePoint, plane.planeNormal, testTriangle)
          log(clippedTri1,clippedTri2,"tris",i,#queue)
            -- Add the clipped triangles to the list
            if numClipped == 1 then
                table.insert(newTriangles, clippedTri1)
            elseif numClipped == 2 then
                table.insert(newTriangles, clippedTri1)
                table.insert(newTriangles, clippedTri2)
            end
        end

        -- Update the queue with the newly clipped triangles
        queue = newTriangles
    end
 
    return queue  -- Return all the triangles clipped against all planes
end
]]


local function clipTriangleAgainstAllPlanes(triangles)
  -- Clipping planes definition
  local screenPlanes = {
    {planePoint = vec(0, -0.68, 0), planeNormal = vec(0, 1, 0)},  -- Top
      {planePoint = vec(0, 0.68, 0), planeNormal = vec(0, -1, 0)},  -- Bottom
      {planePoint = vec(-0.68, 0, 0), planeNormal = vec(1, 0, 0)},  -- Left
      {planePoint = vec(0.68, 0, 0), planeNormal = vec(-1, 0, 0)}  -- Right
  }

  -- Copy the initial triangles
  local queue = {}
  for _, tri in ipairs(triangles) do
      table.insert(queue, tri)
  end

  -- Iterate through each clipping plane
  for i, plane in ipairs(screenPlanes) do
      local newTriangles = {}

      -- Process each triangle in the queue
      while #queue > 0 do
          local testTriangle = table.remove(queue, 1)

          -- Clip against the current plane
          local numClipped, clippedTri1, clippedTri2 = triClipAgainstPlane(plane.planePoint, plane.planeNormal, testTriangle)
          
          -- Add the valid clipped triangles to the list
          if numClipped == 1  then
              table.insert(newTriangles, clippedTri1)
          elseif numClipped == 2 then
         
                  table.insert(newTriangles, clippedTri1)
        
                  table.insert(newTriangles, clippedTri2)
     
          end
      end

      -- Update the queue with newly clipped triangles for the next plane
      queue = newTriangles
  end

  -- Return all triangles after clipping against all planes
  return queue
end








function events.entity_init()
  createScreen(player:getPos(),nil,width,height)

  local vertices = {}
  for i = 1, #avatar:getNBT().models.chld[1].chld[1].mesh_data.vtx , 3 do
    table.insert(vertices,vec(avatar:getNBT().models.chld[1].chld[1].mesh_data.vtx[i],avatar:getNBT().models.chld[1].chld[1].mesh_data.vtx[i+1],avatar:getNBT().models.chld[1].chld[1].mesh_data.vtx[i+2]))
  end

  local fac = avatar:getNBT().models.chld[1].chld[1].mesh_data.fac
  local curMesh = {}
  local num =1 
  local uv = avatar:getNBT().models.chld[1].chld[1].mesh_data.uvs
  for i , tex in pairs(avatar:getNBT().models.chld[1].chld[1].mesh_data.tex) do

    if tex == 20 then

      local tri = {}
 
        tri[3] = vertices[math.abs(fac[num]%255+1)]/16
        tri[8] = vec(uv[2*num-1],uv[2*num],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
   
        tri[1] = vertices[math.abs(fac[num+1]%255+1)]/16
        tri[6] = vec(uv[2*num+1],uv[2*num+2],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
    
        tri[2] = vertices[math.abs(fac[num+2]%255+1)]/16
        tri[7] = vec(uv[2*num+3],uv[2*num+4],1):div(texture:getDimensions().x,texture:getDimensions().y,1)

   
      table.insert(curMesh,tri)
      local tri = {}
      tri[1] = vertices[fac[num+3]%255+1]/16
      tri[6] = vec(uv[2*num+5],uv[2*num+6],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[2] = vertices[fac[num]%255+1]/16
      tri[7] = vec(uv[2*num-1],uv[2*num],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      tri[3] = vertices[fac[num+2]%255+1]/16
      tri[8] = vec(uv[2*num+3],uv[2*num+4],1):div(texture:getDimensions().x,texture:getDimensions().y,1)
      table.insert(curMesh,tri)
      num = num +4
    end
    if tex == 19 then

      local tri = {}
      tri[3] = vertices[fac[num]%255+1]/16
      tri[1] = vertices[fac[num+1]%255+1]/16
      tri[2] = vertices[fac[num+2]%255+1]/16
      tri[6] = vec(0,0)
      tri[7] = vec(0,0)
      tri[8] = vec(0,0)
  
      table.insert(curMesh,tri)

      num = num +3
    end
  end
  for i , tex in pairs(avatar:getNBT().models.chld[1].chld[1].mesh_data.tex) do

    if tex == 4 then

      local tri = {}
 
        tri[3] = vertices[math.abs(fac[num]%255+1)]/16
   
   
        tri[1] = vertices[math.abs(fac[num+1]%255+1)]/16
   
    
        tri[2] = vertices[math.abs(fac[num+2]%255+1)]/16
        tri[6] = vec(0,0)
        tri[7] = vec(0,0)
        tri[8] = vec(0,0)
      table.insert(curMesh,tri)
      local tri = {}
      tri[1] = vertices[fac[num+3]%255+1]/16
      tri[2] = vertices[fac[num]%255+1]/16
      tri[3] = vertices[fac[num+2]%255+1]/16
      tri[6] = vec(0,0)
      tri[7] = vec(0,0)
      tri[8] = vec(0,0)
      table.insert(curMesh,tri)
      num = num +4
    end
    if tex == 3 then

      local tri = {}
      tri[3] = vertices[fac[num]%255+1]/16
      tri[1] = vertices[fac[num+1]%255+1]/16
      tri[2] = vertices[fac[num+2]%255+1]/16
      tri[6] = vec(0,0)
      tri[7] = vec(0,0)
      tri[8] = vec(0,0)
      table.insert(curMesh,tri)

      num = num +3
    end
  end
table.insert(mesh,curMesh)



end
--Fov = field of view
local fov = 90
local fovRad = 1/math.tan(math.rad(fov)*0.5)
--aspect ratio
local aspectRatio = width/height
--Near = near clipping plane
local near = 0.1
--Far = far clipping plane
local far = 1000
--Projection Matrix
projectionMatrix = matrices.mat4()
projectionMatrix[1] = vec(aspectRatio*fovRad,0,0,0)
projectionMatrix[2] = vec(0,fovRad,0,0)
projectionMatrix[3] = vec(0,0,far/(far-near),1)
projectionMatrix[4] = vec(0,0,(-far*near)/(far-near),0)
s = 0


--[[
aspectRatio*fovRad 0 0 0
0 fovRad 0 0
0 0 far/(far-near) 1
0 0 (-far*near)/(far-near) 0
]]
local RotMat = matrices.mat4()

local timer = 180
local timer2 = 0

local cameraPos = vec(0,0.1,0)
local lookDir = vec(0,0,1)

--rendering code
function events.tick()
  
  local triToRasterz = {}
local triToRaster = {}
local triProjectedtbl = {}
local triToRasterSortz = {}
timer2 = timer2 + 1
 clearScreen()
 local scale = 1

RotMat:rotate(vec(timer,0,0))
timer = 0

for i, tbl in pairs(mesh) do
  for j, triangle in pairs(tbl) do
 
  local triTranslated = {}
  local triRotatedX = {}
  local triViewed1 = {}
--rotation
  triRotatedX[1] = multMatrix(triangle[1],RotMat)
  triRotatedX[2] = multMatrix(triangle[2],RotMat)
  triRotatedX[3] = multMatrix(triangle[3],RotMat)

--translation
  triTranslated[1] = (triRotatedX[1])*scale + vec(-0.7,-0.5,1+i*10)
  triTranslated[2] = (triRotatedX[2])*scale + vec(-0.7,-0.5,1+i*10)
  triTranslated[3] = (triRotatedX[3])*scale + vec(-0.7,-0.5,1+i*10)

  triTranslated[1] = triTranslated[1]
  triTranslated[2] = triTranslated[2]
  triTranslated[3] = triTranslated[3]
  --face normals
  --triangle cross product
  local line1 = triTranslated[2] - triTranslated[1]
  local line2 = triTranslated[3] - triTranslated[1]
  local normal = line1:crossed(line2)
--illumination
  local lightDirection = vec(-1,-2,-3):normalize()*0.6
  local illumination
  illumination = normal:dot(lightDirection)
  if illumination < 0.1 then
    illumination = 0.2
  end
  if illumination > 1 then
illumination = 1
  end  
  triViewed1[5] = illumination
  
  
  local up = vec(0,1,0)
  local target = vec(0,0,1)
  updateCameraOrientation(yaw, pitch)
  target = cameraPos+lookDir
  camMat = pointAtMatrix(cameraPos,target,up)
  viewMat = QuickInverse(camMat)


  triViewed1[1] = multMatrix(triTranslated[1],viewMat)
  triViewed1[2] = multMatrix(triTranslated[2],viewMat)
  triViewed1[3] = multMatrix(triTranslated[3],viewMat)

  triViewed1[6] = triangle[6]
  triViewed1[7] = triangle[7]
  triViewed1[8] = triangle[8]

  local clippedTriangles = {}
  local numClipped, clipped1, clipped2 = triClipAgainstPlane(vec(0, 0, 0.2), vec(0, 0, 1), triViewed1)
  if numClipped > 0 then
      table.insert(clippedTriangles, clipped1)
      if numClipped == 2 then
          table.insert(clippedTriangles, clipped2)
      end
  end
  

              local clippedAndScreenClipped = clipTriangleAgainstAllPlanes(clippedTriangles)
--projection
--if normal.z < 0 then
for i, tri in pairs(clippedAndScreenClipped) do
  local triProjected = {}
if normal:dot(triTranslated[1]-cameraPos) < 0 then
  triProjected[1],w1 = multMatrix(tri[1],projectionMatrix)
  triProjected[2],w2 = multMatrix(tri[2],projectionMatrix)
  triProjected[3],w3 = multMatrix(tri[3],projectionMatrix)
  triProjected[4] = tri[4]
  triProjected[5]= tri[5]
  triProjected[6] = tri[6]
  triProjected[7] = tri[7]
  triProjected[8] = tri[8]
  

  triProjected[6].x = triProjected[6].x--/w1
  triProjected[7].x = triProjected[7].x--/w2
  triProjected[8].x = triProjected[8].x--/w3

  triProjected[6].y = triProjected[6].y--/w1
  triProjected[7].y = triProjected[7].y--/w2
  triProjected[8].y = triProjected[8].y--/w3

  triProjected[6].z = 1/w1
  triProjected[7].z = 1/w2
  triProjected[8].z = 1/w3

  triProjected[1].x = triProjected[1].x + 1
  triProjected[2].x = triProjected[2].x + 1
  triProjected[3].x = triProjected[3].x + 1
  triProjected[1].y = triProjected[1].y + 1
  triProjected[2].y = triProjected[2].y + 1
  triProjected[3].y = triProjected[3].y + 1

  triProjected[1].x = triProjected[1].x * 0.5 * width
  triProjected[1].y = triProjected[1].y * 0.5 * height
  triProjected[2].x = triProjected[2].x * 0.5 * width
  triProjected[2].y = triProjected[2].y * 0.5 * height
  triProjected[3].x = triProjected[3].x * 0.5 * width
  triProjected[3].y = triProjected[3].y * 0.5 * height
 table.insert(triProjectedtbl,triProjected)
 table.insert(triToRasterz,(triProjected[1].z + triProjected[2].z +triProjected[3].z)/3)
 triToRasterSortz = table.pack(table.unpack(triToRasterz))
 triToRasterSortz.n = nil

end
end
end
--ordering the triangles
table.sort(triToRasterSortz)
for i=0,#triToRasterSortz-1 do
  for j, zvalue2 in pairs(triToRasterz) do
  
    if triToRasterSortz[#triToRasterSortz-i] == zvalue2 then
      table.insert(triToRaster,triProjectedtbl[j])
      
    end
  end
end




if s < 99999 then
  s = s + 1
for i, triProjectedDraw in pairs(triToRaster) do
  
--drawTriangle(triProjectedDraw[1].xy,triProjectedDraw[2].xy,triProjectedDraw[3].xy,vectors.hsvToRGB(vectors.rgbToHSV(triProjectedDraw[4])+vec(0,0,triProjectedDraw[5])))

drawTexturedTriangle(triProjectedDraw[1].xy:ceil(),triProjectedDraw[2].xy:ceil(),triProjectedDraw[3].xy:ceil(),triProjectedDraw[6],triProjectedDraw[7],triProjectedDraw[8],texture,vec(0,0,triProjectedDraw[5]))


--drawLine(triProjectedDraw[1],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
--drawLine(triProjectedDraw[3],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
--drawLine(triProjectedDraw[1],triProjectedDraw[3],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))

--drawPix(triProjectedDraw[1],vec(0,0,1))
--drawPix(triProjectedDraw[2],vec(0,0,1))
--drawPix(triProjectedDraw[3],vec(0,0,1))
Screens[1].screenText:update()  
end
end

end
end




mesh = {--[[{
  --cube
--south
{vec(0,0,0),vec(0,1,0),vec(1,1,0),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(0,0,0),vec(1,1,0),vec(1,0,0),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
--east
{vec(1,0,0),vec(1,1,0),vec(1,1,1),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(1,0,0),vec(1,1,1),vec(1,0,1),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
--north
{vec(1,0,1),vec(1,1,1),vec(0,1,1),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(1,0,1),vec(0,1,1),vec(0,0,1),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
--west
{vec(0,0,1),vec(0,1,1),vec(0,1,0),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(0,0,1),vec(0,1,0),vec(0,0,0),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
--top
{vec(0,1,0),vec(0,1,1),vec(1,1,1),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(0,1,0),vec(1,1,1),vec(1,1,0),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
--bottom
{vec(1,0,1),vec(0,0,1),vec(0,0,0),vec(1,1,1),0,vec(0,1,1),vec(0,0,1),vec(1,0,1)},
{vec(1,0,1),vec(0,0,0),vec(1,0,0),vec(1,1,1),0,vec(0,1,1),vec(1,0,1),vec(1,1,1)},
},]]
--[[
{
--pyramid
{vec(0,0,1),vec(0.5,1,0.5),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0.5,1,0.5),vec(0,0,1),vec(1,1,1)},
{vec(1,0,0),vec(0.5,1,0.5),vec(1,0,1),vec(1,1,1)},
{vec(0,0,0),vec(0.5,1,0.5),vec(1,0,0),vec(1,1,1)},
{vec(1,0,0),vec(0,0,1),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0,0,1),vec(1,0,0),vec(1,1,1)},
},
{
--pyramid
{vec(0,0,1),vec(0.5,1,0.5),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0.5,1,0.5),vec(0,0,1),vec(1,1,1)},
{vec(1,0,0),vec(0.5,1,0.5),vec(1,0,1),vec(1,1,1)},
{vec(0,0,0),vec(0.5,1,0.5),vec(1,0,0),vec(1,1,1)},
{vec(1,0,0),vec(0,0,1),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0,0,1),vec(1,0,0),vec(1,1,1)},
},
{
--pyramid
{vec(0,0,1),vec(0.5,1,0.5),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0.5,1,0.5),vec(0,0,1),vec(1,1,1)},
{vec(1,0,0),vec(0.5,1,0.5),vec(1,0,1),vec(1,1,1)},
{vec(0,0,0),vec(0.5,1,0.5),vec(1,0,0),vec(1,1,1)},
{vec(1,0,0),vec(0,0,1),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0,0,1),vec(1,0,0),vec(1,1,1)},
},
{
  --cube
--south
{vec(0,0,0),vec(0,1,0),vec(1,1,0),vec(1,1,1)},
{vec(0,0,0),vec(1,1,0),vec(1,0,0),vec(1,1,1)},
--east
{vec(1,0,0),vec(1,1,0),vec(1,1,1),vec(1,1,1)},
{vec(1,0,0),vec(1,1,1),vec(1,0,1),vec(1,1,1)},
--north
{vec(1,0,1),vec(1,1,1),vec(0,1,1),vec(1,1,1)},
{vec(1,0,1),vec(0,1,1),vec(0,0,1),vec(1,1,1)},
--west
{vec(0,0,1),vec(0,1,1),vec(0,1,0),vec(1,1,1)},
{vec(0,0,1),vec(0,1,0),vec(0,0,0),vec(1,1,1)},
--top
{vec(0,1,0),vec(0,1,1),vec(1,1,1),vec(1,1,1)},
{vec(0,1,0),vec(1,1,1),vec(1,1,0),vec(1,1,1)},
--bottom
{vec(1,0,1),vec(0,0,1),vec(0,0,0),vec(1,1,1)},
{vec(1,0,1),vec(0,0,0),vec(1,0,0),vec(1,1,1)},
},
   ]] 
}





local keybindStatew = false
-- Here the keybindState is true, meaning the first press will swap it to false
-- If you wish the first press to swap to false, change the true to false above
local w = keybinds:newKeybind("Keybind Name", "key.keyboard.i")
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
cameraPos = cameraPos + lookDir*0.2*width/100
end  
if keybindStates then
  cameraPos = cameraPos - lookDir*0.2*width/100
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





function updateCameraOrientation(yaw, pitch)
    local direction = vec(0, 0, 0)

    -- Calculate the forward direction based on yaw and pitch
    direction.x = math.cos(math.rad(yaw)) * math.cos(math.rad(pitch))
    direction.y = math.sin(math.rad(pitch))
    direction.z = math.sin(math.rad(yaw)) * math.cos(math.rad(pitch))

    -- Normalize the direction vector
    direction:normalize()

    -- Update camera orientation here, using your graphics engine's functions
    lookDir = direction
end