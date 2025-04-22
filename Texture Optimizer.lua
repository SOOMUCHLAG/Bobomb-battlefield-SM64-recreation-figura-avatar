OptimizedTextures = {}
local nullVector = vec(0,0,0)
function optimizeTextures()
for i , bbmodelMesh in pairs(BBmodelToMesh) do
  if not OptimizedTextures[BBmodelToMesh.textureName] then
  OptimizedTextures[bbmodelMesh.textureName] = {}
  local text = textures[bbmodelMesh.textureName]
  for x = 0, text:getDimensions().x-1 do
    OptimizedTextures[bbmodelMesh.textureName][x] = OptimizedTextures[bbmodelMesh.textureName][x] or {}
    local bbmodopttexx =     OptimizedTextures[bbmodelMesh.textureName][x]
    for y = 0, text:getDimensions().y-1 do
      local col = text:getPixel(x,y).xyz
      if col ~= nullVector then
        bbmodopttexx[y] = col
      end
      
    end
  end
  OptimizedTextures[bbmodelMesh.textureName].dimx2 = text:getDimensions().x-3
  OptimizedTextures[bbmodelMesh.textureName].dimy2 = text:getDimensions().x-3
end
end
end






