mesh = {
}
colTris = {}



--width + height of the screen
width = 90
height =90
--initializing the depth buffer
depthBuffer = {}
--setting the camera pos(as the y lowers the camera height increases)
cameraPos = vec(-128.57074, 50.20699, -128.74618) 
lookDir = vec(0,0,1)

--seting the camera direction
yaw = 0
pitch = 0



--Used for camera stuff
--- @param pos Vec3 Position
--- @param target Vec3 Target
--- @param up Vec3 Up vector
--- @return Matrix4 pointAtMatrix 
local function pointAtMatrix(pos,target,up)
local newForward = (target - pos):normalize()
local newUp = (up-(newForward * up:dot(newForward))):normalize()
local newRight = newUp:crossed(newForward)
return matrices.mat4(
  vec(newRight.x,newRight.y,newRight.z,0),
  vec(newUp.x,newUp.y,newUp.z,0),
  vec(newForward.x,newForward.y,newForward.z,0),
  vec(pos.x,pos.y,pos.z,1))



end  



--Used for camera stuff(not the actual inverse of any matrix)
--- @param mat Matrix4 Matrix to inverse
--- @return Matrix4 inverseMatrix Inversed matrix
local function QuickInverse(mat)
local traslation = -mat[4].xyz
return matrices.mat4( vec(mat[1].x,mat[2].x,mat[3].x,0),
vec(mat[1].y,mat[2].y,mat[3].y,0),
vec(mat[1].z,mat[2].z,mat[3].z,0),
vec(traslation:dot(mat[1].xyz),traslation:dot(mat[2].xyz),traslation:dot(mat[3].xyz),1))
end



--Vector plane intersection
--- @param planePoint Vec3 Point on a plane
--- @param planeNormal Vec3 Plane normal
--- @param lineStart Vec3 Line to check against the plane
--- @param lineEnd Vec3 Line to check against the plane
--- @return Vec3 interpolatedEdge Interpolated edge of a triangle
--- @return Number t Value used for interpolating UV
local function VectorIntersectPlane(planePoint, planeNormal, lineStart, lineEnd)
  local ad = lineStart:dot(planeNormal)
  local t = (planeNormal:dot(planePoint) - ad) / ((lineEnd:dot(planeNormal)) - ad)
  return (lineStart + (lineEnd - lineStart) * t), t
end

--Triangle clipping function
--- @param planePoint Vec3 Point on a plane
--- @param planeNormal Vec3 Plane normal
--- @param triangle Vec3 Triangle to clip
--- @return Number NumberOfTriangles Value used for interpolating UV
--- @return Triangle outTriangle1 Clipped Triangle
--- @return Triangle outTriangle2 Clipped Triangle
local function triClipAgainstPlane(planePoint, planeNormal, triangle)


  local insidePoints, outsidePoints = {}, {}
  local insideTexes, outsideTexes = {}, {}
  local tri1hewee = triangle[1]
  local tri2hewee = triangle[2]
  local tri3hewee = triangle[3]
  local planeNormalDottedWithPlanePoint=planeNormal:dot(planePoint) 

  if planeNormal:dot(tri1hewee) - planeNormalDottedWithPlanePoint >= 0 then
                insidePoints[#insidePoints+1] =  tri1hewee
                insideTexes[#insideTexes+1] = triangle[6]
  else
                outsidePoints[#outsidePoints+1] = tri1hewee
                outsideTexes[#outsideTexes+1] = triangle[6]
  end

  if planeNormal:dot(tri2hewee) - planeNormalDottedWithPlanePoint >= 0 then
    insidePoints[#insidePoints+1] =  tri2hewee
    insideTexes[#insideTexes+1] = triangle[7]
  else
    outsidePoints[#outsidePoints+1] = tri2hewee
    outsideTexes[#outsideTexes+1] = triangle[7]
  end

  if planeNormal:dot(tri3hewee) - planeNormalDottedWithPlanePoint >= 0 then
    insidePoints[#insidePoints+1] =  tri3hewee
    insideTexes[#insideTexes+1] = triangle[8]
  else
    outsidePoints[#outsidePoints+1] = tri3hewee
    outsideTexes[#outsideTexes+1] = triangle[8]
  end


  if #insidePoints == 0 then
    return 
  end
  
  if #insidePoints == 3 then
    return 1, triangle  
  end

  if #insidePoints == 1 and #outsidePoints == 2 then
    local outTriangle = {}
    local insideTex1 = insideTexes[1]
    local insidePoint = insidePoints[1]
    outTriangle[1] = insidePoints[1]
    outTriangle[6] = insideTex1


    outTriangle[5] = triangle[5]
    local t
    outTriangle[2], t = VectorIntersectPlane(planePoint, planeNormal, insidePoint, outsidePoints[1])
    outTriangle[7] = t*(outsideTexes[1]-insideTex1)+insideTex1
    

    outTriangle[3], t = VectorIntersectPlane(planePoint, planeNormal, insidePoint, outsidePoints[2])
    outTriangle[8] = t*(outsideTexes[2]-insideTex1)+insideTex1

    return 1, outTriangle
  end





  if #insidePoints == 2 and #outsidePoints == 1 then
    local outTriangle1, outTriangle2 = {}, {}
    local t
    local insideTex1 = insideTexes[1]
    local insideTex2 = insideTexes[2]
    local outsideTex = outsideTexes[1]
    local outsidePoint = outsidePoints[1]
    local insidePoint1 = insidePoints[1]

    local triangle5 = triangle[5]

    outTriangle1[5] = triangle5
    outTriangle1[1] = insidePoint1
    outTriangle1[6] = insideTex1
    outTriangle1[2] = insidePoints[2]
    outTriangle1[7] = insideTex2
    outTriangle1[3], t = VectorIntersectPlane(planePoint, planeNormal, insidePoints[2], outsidePoint)
    outTriangle1[8] = t*(outsideTex-insideTex2)+insideTex2

    --vertex pos
    outTriangle2[1] = insidePoint1
    outTriangle2[2] = outTriangle1[3]
    outTriangle2[3], t = VectorIntersectPlane(planePoint, planeNormal, insidePoint1, outsidePoint)

    outTriangle2[5] = triangle5
    --uv
    outTriangle2[6] = insideTex1
    outTriangle2[7] = outTriangle1[8]
    outTriangle2[8] = t*(outsideTex-insideTex1)+insideTex1

    return 2, outTriangle1, outTriangle2
  end
end






local screenPlanes = {
  {planePoint = vec(0, 1, 0), planeNormal = vec(0, 1, 0)}, --top
  {planePoint = vec(1, 0, 0), planeNormal = vec(1, 0, 0)}, --left
  {planePoint = vec(0, height-2.3, 0), planeNormal = vec(0, -1, 0)}, --bottom
  {planePoint = vec(width-2.3, 0, 0), planeNormal = vec(-1, 0, 0)}, --right
}
--Clips all projected triangles against the sides of the screen
--- @param triangles Table all triangles to clip
--- @return Table clippedTriangles clipped triangles
local function clipTriangleAgainstAllPlanes(triangles)



  local queue = table.pack(table.unpack(triangles))


  for i, plane in ipairs(screenPlanes) do
    local newTriangles = {}

    while #queue > 0 do

      local numClipped, clippedTri1, clippedTri2 = triClipAgainstPlane(plane.planePoint, plane.planeNormal,table.remove(queue))

      if numClipped == 1  then
        newTriangles[#newTriangles+1] =  clippedTri1
      elseif numClipped == 2 then
        newTriangles[#newTriangles+1] =  clippedTri1
        newTriangles[#newTriangles+1] =  clippedTri2
      end
    end
    queue = newTriangles
  end

  return queue
end










function events.entity_init()
  --creating a screed
  createScreen(player:getPos(),nil,width,height)
  --initializing the depth buffer
  for i = 1, height do
    depthBuffer[i] = {}
    for j = 1, width do
      depthBuffer[i][j] = 0
    end
  end

  --converting bbmodels to meshes
  for i, meshData in pairs(BBmodelToMesh) do
    convertBBmodelToMesh(meshData.modelpart,i,meshData.textureName,meshData.facNums)
  end
  for i, tbl in pairs(mesh) do
    colTris[i] = {}
  end
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

--[[
projectionMatrix = matrices.mat4()
projectionMatrix[1] = vec(aspectRatio*fovRad,0,0,0)
projectionMatrix[2] = vec(0,fovRad,0,0)
projectionMatrix[3] = vec(0,0,far/(far-near),1)
projectionMatrix[4] = vec(0,0,(-far*near)/(far-near),0)
]]
local aspectTimesFov = aspectRatio*fovRad
local zeropoint3vec = vec(0, 0, 0.3)
local onevec = vec(0, 0, 1)
local lightDirection = vec(-1,-2,-3):normalize()
local up = vec(0,1,0)
local colthreshold = 75
local renderthreshold = 145
cameraPosWithOffset = vec(0,0,0)
staticMeshes = {}
--calculates the vertices for a static mesh 
--- @param index Number|String
--- @param triangles Table Triangles of the mesh to statify
--- @param pivot Vec3 Pivot of the mesh
--- @param translation Vec3 Translation of the mesh
--- @param RotMat Matrix3 Rotation matrix for the mesh
--- @param Scale Vec3 Scale of the mesh
local function calculateStaticMesh(index,triangles,pivot,translation,RotMat,scale)
  local meshData = {}
  local tranminuspivot= translation-pivot
  for j, triangle in pairs(triangles) do
    local triTranslated = {}

    local trimult1 = (triangle[1]*scale)+tranminuspivot
    local trimult2 = (triangle[2]*scale)+tranminuspivot
    local trimult3 = (triangle[3]*scale)+tranminuspivot

    triTranslated[1] = (RotMat * trimult1)+pivot
    triTranslated[2] = (RotMat * trimult2)+pivot
    triTranslated[3] = (RotMat * trimult3)+pivot

    triTranslated[4]= (triTranslated[2] - triTranslated[1]):crossed(triTranslated[3] - triTranslated[1]):normalize()
    triTranslated[5]= triTranslated[4]:dot(lightDirection)

    meshData[j] = triTranslated
  end
  staticMeshes[index] = meshData
end


function lookAtModel(direction,up)
local right = up:crossed(direction)
if right:length() < 0.0001 then
  right = vec(1,0,0)
else
right:normalize()
end
local newUp = direction:crossed(right):normalized()
return matrices.mat3(right,newUp,direction)
end




--rendering code
function events.tick()
  updateCameraOrientation(yaw, pitch)
  clearScreen()
colTris = {}
  local halfwidthheightvec = vec(width,height,1)*0.5
  local viewMat = QuickInverse(pointAtMatrix(cameraPosWithOffset,cameraPosWithOffset+lookDir,up))
  cameraPosWithOffset = cameraPos+cameraoffset
  for i, meshthing in pairs(mesh) do
    if BBmodelToMesh[i].collision then
    colTris[i]= {}
    end
  end
--clearing the screen


--Drawing every mesh
for i, tbl in pairs(mesh) do
  local triToRaster = {}

  local RotMat = matrices.rotation3(vec(180+BBmodelToMesh[i].rotation.x,BBmodelToMesh[i].rotation.y,BBmodelToMesh[i].rotation.z))
  local lookAt = BBmodelToMesh[i].lookAt
  local lookAtMode = BBmodelToMesh[i].lookAtMode
  local modelUp = BBmodelToMesh[i].up
  local translation = BBmodelToMesh[i].translation
  local scale = BBmodelToMesh[i].scale
  local pivot = BBmodelToMesh[i].pivot
  local tranminuspivot= translation-pivot
  local static = BBmodelToMesh[i].static
  local textureName = BBmodelToMesh[i].textureName
  local noLighting = BBmodelToMesh[i].noLighting
  local collision = BBmodelToMesh[i].collision

  if staticMeshes[i]==nil and static then
    calculateStaticMesh(i,tbl,pivot,translation,RotMat,scale)
  end
  for j, triangle in pairs(tbl) do
    local normal
    local triga
    

    local triViewed1 = {}
    triViewed1=table.pack(table.unpack(triangle))
    

  
    local illumination 
    local  trimult2
    local  trimult3
    if not static then
      if lookAt then
        if lookAtMode == 0 then
          triga = (RotMat * (((triangle[1]*scale)+tranminuspivot)*lookAtModel(lookAt,modelUp)))+pivot
          trimult2 = (RotMat * (((triangle[2]*scale)+tranminuspivot)*lookAtModel(lookAt,modelUp)))+pivot
          trimult3 = (RotMat * (((triangle[3]*scale)+tranminuspivot)*lookAtModel(lookAt,modelUp)))+pivot
        else
          triga = (RotMat * (((triangle[1]*scale)+tranminuspivot)))*lookAtModel(lookAt,modelUp)+pivot
          trimult2 = (RotMat * (((triangle[2]*scale)+tranminuspivot)))*lookAtModel(lookAt,modelUp)+pivot
          trimult3 = (RotMat * (((triangle[3]*scale)+tranminuspivot)))*lookAtModel(lookAt,modelUp)+pivot
        end
      else
        triga = (RotMat * (((triangle[1]*scale)+tranminuspivot)))+pivot
        trimult2 = (RotMat * (((triangle[2]*scale)+tranminuspivot)))+pivot
        trimult3 = (RotMat * (((triangle[3]*scale)+tranminuspivot)))+pivot
      end





      normal = (trimult2 - triga):crossed(trimult3 - triga):normalize()
      illumination = normal:dot(lightDirection)
    else 
      local staticTriangle = staticMeshes[i][j]

      triga = staticTriangle[1]
      trimult2 = staticTriangle[2]
      trimult3 = staticTriangle[3]

      normal = staticTriangle[4]
      illumination = staticTriangle[5]


    end




    local averagedist = (((triga+trimult2+trimult3)*0.33333333)-cameraPosWithOffset):length()


if averagedist<renderthreshold then

  if  collision and  averagedist<colthreshold then
    local coltrii = colTris[i]
    coltrii[#coltrii+1] = {triga,trimult2,trimult3}
    end
if noLighting then
  illumination = 2
  end
    triViewed1[1] = (viewMat * vec(triga.x,triga.y,triga.z,1)).xyz
    triViewed1[2] = (viewMat * vec(trimult2.x,trimult2.y,trimult2.z,1)).xyz
    triViewed1[3] = (viewMat * vec(trimult3.x,trimult3.y,trimult3.z,1)).xyz




    if normal:dot(triga-cameraPosWithOffset) < 0 then
      local clippedTriangles = {}
  
      numClipped, clippedTriangles[1] , clippedTriangles[2] = triClipAgainstPlane(zeropoint3vec, onevec, triViewed1)

      for k, tri in pairs(clippedTriangles) do
        local triProjected = {}

      local trimult1 = tri[1]
      local trimult2 = tri[2]
      local trimult3 = tri[3]
      local w1,w2,w3 = trimult1.z,trimult2.z,trimult3.z
  
      triProjected[1] = (((vec(trimult1.x*aspectTimesFov,trimult1.y*fovRad,0))/w1)+1)*halfwidthheightvec
      triProjected[2] = (((vec(trimult2.x*aspectTimesFov,trimult2.y*fovRad,0))/w2)+1)*halfwidthheightvec
      triProjected[3] = (((vec(trimult3.x*aspectTimesFov,trimult3.y*fovRad,0))/w3)+1)*halfwidthheightvec
        
      triProjected[5] = illumination

      triProjected[6] = tri[6]/w1
      triProjected[7] = tri[7]/w2
      triProjected[8] = tri[8]/w3

      triToRaster[#triToRaster+1] = triProjected
      end
    end
  end
  end
 
  triToRaster = clipTriangleAgainstAllPlanes(triToRaster)

  for k, triProjectedDraw in pairs(triToRaster) do

  drawTexturedTriangle(triProjectedDraw[1]:ceil(),triProjectedDraw[2]:ceil(),triProjectedDraw[3]:ceil(),triProjectedDraw[6],triProjectedDraw[7],triProjectedDraw[8],textureName,triProjectedDraw[5]*2)

--Wireframe NO DEPTH BUFFER
--[[
drawLine(triProjectedDraw[1],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
drawLine(triProjectedDraw[3],triProjectedDraw[2],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
drawLine(triProjectedDraw[1],triProjectedDraw[3],vectors.hsvToRGB(vectors.rgbToHSV(1,0,0)+vec(0,0,triProjectedDraw[5])))
]]

--Draws a pixel at every vertex
--[[
drawPix(triProjectedDraw[1],vec(0,0,1))
drawPix(triProjectedDraw[2],vec(0,0,1))
drawPix(triProjectedDraw[3],vec(0,0,1))
]]

  end
end
--DEPTH BUFFER VISUALIZATION
--[[
for i = 1, width do

  for j = 1, height do
    Screen.screenText:setPixel(i-1,j-1,vectors.hsvToRGB(0,0,1-depthBuffer[i][j]/1.5))
    end
  end]]

Screen.screenText:update()  

  for i = 1, height do
    local iInDepthBuffer = depthBuffer[i]
    for j = 1, width do
    iInDepthBuffer[j] = 0
    end
  end
end
