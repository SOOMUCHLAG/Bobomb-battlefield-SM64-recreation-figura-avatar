--[[
Example of a new mesh to create 
{
    modelpart = modelpart,
    translation = vec(posx,posy,posz), --the lower the y the higher the model will appear
    rotation = vec(rotx,roty,rotz),
    scale = vec(scalex,scaley,scalez),
    pivot = vec(pivotx,pivoty,pivotz),
    facNums = vec(trianglenumber,quadnumber),
    texture = textures["put your texture here"]
},

]]
local math_abs = math.abs 
local math_min = math.min
local math_max = math.max
local math_floor = math.floor
local math_ceil = math.ceil
local math_clamp = math.clamp
local function polarToCartesian(radius, angleInDegrees)
    -- Convert angle from degrees to radians
    local angleInRadians = math.rad(angleInDegrees)

    -- Calculate Cartesian coordinates
    local x = radius * math.cos(angleInRadians)
    local y = radius * math.sin(angleInRadians)

    return vec(x,0,y)
end
coins = 0
lives = 4
health = 8
stars = 0
BBmodelToMesh = {
[1]={
    modelpart = models.bobthebetter.bobomb_battlefeild,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4,
    pivot = vec(0,100,0),
    facNums = vec(19,20),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.Baked3",
    collision = true,
    static = true

},
[7]={
    modelpart = models.bobthebetter.bobomb_battlefeild_slide,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4,
    pivot = vec(0,100,0),
    facNums = vec(19,20),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.Baked3",
    collision = true,
    static = true

},
marioTorso1 = {
    modelpart = models.bobthebetter.marianTorso1,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioTorso2 = {
    modelpart = models.bobthebetter.marianTorso2,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioLegL1 = {
    modelpart = models.bobthebetter.marianLegL1,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioLegL2 = {
    modelpart = models.bobthebetter.marianLegL2,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioBootL = {
    modelpart = models.bobthebetter.marianBootL,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioLegR1 = {
    modelpart = models.bobthebetter.marianLegR1,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioLegR2 = {
    modelpart = models.bobthebetter.marianLegR2,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioBootR = {
    modelpart = models.bobthebetter.marianBootR,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioHead = {
    modelpart = models.bobthebetter.marianHead,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioArmL1 = {
    modelpart = models.bobthebetter.marianArmL1,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioArmL2 = {
    modelpart = models.bobthebetter.marianArmL2,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioFistL = {
    modelpart = models.bobthebetter.marianFistL,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioArmR1 = {
    modelpart = models.bobthebetter.marianArmR1,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioArmR2 = {
    modelpart = models.bobthebetter.marianArmR2,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
marioFistR = {
    modelpart = models.bobthebetter.marianFistR,
    translation = vec(0,100,0),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.65,
    pivot = vec(0,0,0),
    facNums = vec(51,36),
    texture = textures["bobthebetter.Baked3"],
    textureName = "bobthebetter.maribake2"
},
tree1 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-89.48885, 55.72649, -98.15059),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-89.48885, 55.72649, -98.15059),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree2 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-53.81478, 62.74687, -101.9815) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-53.81478, 62.74687, -101.9815) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree3 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(107.60824, 49.51744, -127.5465)  -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(107.60824, 49.51744, -127.5465)  -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree4 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(62.35984, 50.13174, -133.02077) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(62.35984, 50.13174, -133.02077) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree5 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-90.60043, 50.41055, -76.90715) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-90.60043, 50.41055, -76.90715) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree6 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-65.88844, 50.42228, -57.86143) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-65.88844, 50.42228, -57.86143) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree7 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-69.89624, 50.46641, -38.15539) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-69.89624, 50.46641, -38.15539) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree8 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-70.091, 50.49433, -24.43164) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-70.091, 50.49433, -24.43164) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree9 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-125.31981, 45.48673, 1.64429) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-125.31981, 45.48673, 1.64429) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree10 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-131.04121, 45.64332, 76.12076) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-131.04121, 45.64332, 76.12076) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
tree11 = {
    modelpart = models.bobthebetter.tree,
    translation = vec(-106.86881, 45.64309, 88.95484) -vec(0,10,0),
    rotation = vec(90,0,0),
    scale = vec(1,1,1)*10,
    pivot = vec(-106.86881, 45.64309, 88.95484) -vec(0,10,0),
    facNums = vec(67,68),
    texture = textures[""],
    textureName = "bobthebetter.Tree",
    noLighting = true
},
shadow1 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-89.48885, 65.72649, -98.15059) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-89.48885, 65.72649, -98.15059) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow2 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-53.81478, 62.74687, -101.9815) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-53.81478, 62.74687, -101.9815) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow3 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(107.60824, 49.51744, -127.5465) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(107.60824, 49.51744, -127.5465) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow4 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(62.35984, 50.13174, -133.02077) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(62.35984, 50.13174, -133.02077) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow5 = {
    modelpart = models.bobthebetter.shadow,
    translation =  vec(-90.60043, 50.41055, -76.90715) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot =  vec(-90.60043, 50.41055, -76.90715) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow6 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-65.88844, 50.42228, -57.86143) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-65.88844, 50.42228, -57.86143) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow7 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-69.89624, 50.46641, -38.15539) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-69.89624, 50.46641, -38.15539) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow8 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-70.091, 50.49433, -24.43164) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-70.091, 50.49433, -24.43164) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow9 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-125.31981, 45.48673, 1.64429) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-125.31981, 45.48673, 1.64429) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow10 = {
    modelpart = models.bobthebetter.shadow,
    translation =  vec(-131.04121, 45.64332, 76.12076) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot =  vec(-131.04121, 45.64332, 76.12076) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
shadow11 = {
    modelpart = models.bobthebetter.shadow,
    translation = vec(-106.86881, 45.64309, 88.95484) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-106.86881, 45.64309, 88.95484) ,
    facNums = vec(67,84),
    texture = textures[""],
    textureName = "bobthebetter.shadow",
    static = true
},
seesaw = {
    modelpart = models.bobthebetter.seesaw,
    translation = vec(-44.98644, 55.14285, -22.41406) ,
    rotation = vec(0,133,0),
    scale = vec(1,1,1)*11,
    pivot = vec(-44.98644, 55.14285, -22.41406) ,
    facNums = vec(99,100),
    texture = textures[""],
    textureName = "bobthebetter.seesaw",
    collision = true,
},
[2] = {
    modelpart = models.bobthebetter.bobombbuddyblock,
    translation =vec(108.2, 39.5, -94) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(108.2, 39.5, -94) ,
    facNums = vec(99,132),
    texture = textures[""],
    textureName = "bobthebetter.bobombbuddy",
    collision = true,
    static = true
},
[3] = {
    modelpart = models.bobthebetter.bobombbuddyblock,
    translation =vec(-99, 44.2942, 0069) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-99, 44.2942, 0069) ,
    facNums = vec(99,132),
    texture = textures[""],
    textureName = "bobthebetter.bobombbuddy",
    collision = true,
    static = true
},
[4] = {
    modelpart = models.bobthebetter.bobombbuddyblock,
    translation =vec(128, 29, 0139.5) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(128, 29, 0139.5) ,
    facNums = vec(99,132),
    texture = textures[""],
    textureName = "bobthebetter.bobombbuddy",
    collision = true,
    static = true
},
[5] = {
    modelpart = models.bobthebetter.bobombbuddyblock,
    translation =vec(86, 9, 0047.1) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(86, 9, 0047.1) ,
    facNums = vec(99,132),
    texture = textures[""],
    textureName = "bobthebetter.bobombbuddy",
    collision = true,
    static = true
},
[6] = {
    modelpart = models.bobthebetter.bobombbuddyblock,
    translation =vec(-112.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,132),
    texture = textures[""],
    textureName = "bobthebetter.bobombbuddy",
    collision = true,
    static = true
},
cointexturetemp1 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,1634),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    static = true
},
cointexturetemp2 = {
    modelpart = models.bobthebetter.coin2,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,1830),
    texture = textures[""],
    textureName = "bobthebetter.coin2",
    static = true
},
cointexturetemp3 = {
    modelpart = models.bobthebetter.coin3,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,1323),
    texture = textures[""],
    textureName = "bobthebetter.coin3",
    static = true
},
cointexturetemp4 = {
    modelpart = models.bobthebetter.coin4,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,2132),
    texture = textures[""],
    textureName = "bobthebetter.coin4",
    static = true
},
sparkletexturetemp1 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle1",
    static = true
},
sparkletexturetemp2 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle2",
    static = true
},
sparkletexturetemp3 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle3",
    static = true
},
sparkletexturetemp4 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle4",
    static = true
},
sparkletexturetemp5 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle5",
    static = true
},
sparkletexturetemp6 = {
    modelpart = models.bobthebetter.sparkle1,
    translation =vec(-11299.5, 68, -113.5),
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*4.2,
    pivot = vec(-112.5, 68, -113.5) ,
    facNums = vec(99,212),
    texture = textures[""],
    textureName = "bobthebetter.sparkle6",
    static = true
},
coin1 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*0   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*0 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin2 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*4   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*4 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin3 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*8   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*8 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin4 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*12   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*12 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin5 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*16   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-6.98179, 65.10204, -115.569580)+vec(1,0,0)*16 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin6 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,0)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,0) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin7 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin8 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*2)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*2) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true,

},
coin9 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*3)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*3) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin10 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*4)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*4) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin11 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*5)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*5) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin12 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*6)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*6) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin13 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*7)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*7) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin14 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*8)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*8) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin15 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*9)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(-120.02129, 44.16759, 103.95019)+polarToCartesian(6,36*9) ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin16 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*0   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*0 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin17 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*3   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*3 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin18 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*6   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*6 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin19 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*9   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*9 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin20 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*12   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(31.89856, 7.02516, 44.91697)+vec(0.93954, 0, -0.34196)*12 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin21 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*0   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*0 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin22 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*3   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*3 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin23 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*6   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*6 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin24 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*9   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*9 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
coin25 = {
    modelpart = models.bobthebetter.coin1,
    translation =vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*12   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*1.5,
    pivot = vec(89.51498, 3.86137, 48.9641)+vec(0.84715, 0, 0.51913)*12 ,
    facNums = vec(99,164)-vec(0,16),
    texture = textures[""],
    textureName = "bobthebetter.coin1",
    noLighting = true
},
oneUptemp = {
    modelpart = models.bobthebetter.oneUp1,
    translation = vec(-188819.73335, 44.16659, 103.610250)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0,
    pivot = vec(-119.73335, 44.16659, 103.610250) ,
    facNums = vec(99,324),
    texture = textures[""],
    textureName = "bobthebetter.oneup",
    noLighting = true,
    static = true
},
goomba1 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(-60.43577, 63.36535, -115.4785)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(-60.43577, 63.36535, -115.4785) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot1 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot2 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba2 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(-4.59421, 56.05062, -114.106)     ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(-4.59421, 56.05062, -114.106) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot3 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot4 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba3 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(74.75535, 49.64324, -120.68715)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(74.75535, 49.64324, -120.68715) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot5 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot6 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba4 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(73.90593, 49.62037, -132.46886)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(73.90593, 49.62037, -132.46886) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot7 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot8 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba5 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(83.43009, 49.23923, -121.37452)     ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(83.43009, 49.23923, -121.37452) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot9 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot10 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba6 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(108.58386, 45.94351, -64.8391) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(108.58386, 45.94351, -64.8391)  ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot11 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot12 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba7 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(94.75856, 47.60481, -57.80242)     ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(73.90593, 49.62037, -132.46886) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot13 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot14 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goomba8 = {
    modelpart = models.bobthebetter.goomba,
    translation = vec(110.68313, 46.8697, -55.03597)     ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(73.90593, 49.62037, -132.46886) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot15 = {
    modelpart = models.bobthebetter.goombaFoot1,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
goombaFoot16 = {
    modelpart = models.bobthebetter.goombaFoot2,
    translation = vec(41.19253, 14.63505, -132.81875)   ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*0.075,
    pivot = vec(41.19253, 14.63505, -132.81875) ,
    facNums = vec(323,324),
    texture = textures[""],
    textureName = "bobthebetter.goomba",
    noLighting = true
},
ironBall1 = {
    modelpart = models.bobthebetter.ironBall,
    translation = vec(-88.41275, 65.16703, -127.01478) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*6,
    pivot = vec(-88.41275, 65.16703, -127.01478) ,
    facNums = vec(323,356),
    texture = textures[""],
    textureName = "bobthebetter.IronBall",
    noLighting = true
},
ironBall2 = {
    modelpart = models.bobthebetter.ironBall,
    translation = vec(-88.41275, 65.16703, -127.01478) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*6,
    pivot = vec(-88.41275, 65.16703, -127.01478) ,
    facNums = vec(323,356),
    texture = textures[""],
    textureName = "bobthebetter.IronBall",
    noLighting = true
},
ironBall3 = {
    modelpart = models.bobthebetter.ironBall,
    translation = vec(-88.41275, 65.16703, -127.01478) ,
    rotation = vec(0,0,0),
    scale = vec(1,1,1)*6,
    pivot = vec(-88.41275, 65.16703, -127.01478) ,
    facNums = vec(323,356),
    texture = textures[""],
    textureName = "bobthebetter.IronBall",
    noLighting = true
}

}
--  
optimizeTextures()
warpCooldown = 150

mario = {
    torso1 = BBmodelToMesh.marioTorso1,
    torso2 = BBmodelToMesh.marioTorso2,
    armL1 = BBmodelToMesh.marioArmL1,
    armL2 = BBmodelToMesh.marioArmL2,
    fistL = BBmodelToMesh.marioFistL,
    armR1 = BBmodelToMesh.marioArmR1,
    armR2 = BBmodelToMesh.marioArmR2,
    fistR = BBmodelToMesh.marioFistR,
    head = BBmodelToMesh.marioHead,
    legL1 = BBmodelToMesh.marioLegL1,
    legL2 = BBmodelToMesh.marioLegL2,
    bootL = BBmodelToMesh.marioBootL,
    legR1 = BBmodelToMesh.marioLegR1,
    legR2 = BBmodelToMesh.marioLegR2,
    bootR = BBmodelToMesh.marioBootR

}

goombas ={
    goomba1 = {model = BBmodelToMesh.goomba1,foot1 = BBmodelToMesh.goombaFoot1,foot2 = BBmodelToMesh.goombaFoot2,pos=BBmodelToMesh.goomba1.translation:copy(),angle=0,canJump = 4},
    goomba2 = {model = BBmodelToMesh.goomba2,foot1 = BBmodelToMesh.goombaFoot3,foot2 = BBmodelToMesh.goombaFoot4,pos=BBmodelToMesh.goomba2.translation:copy(),angle=0,canJump = 4},
    goomba3 = {model = BBmodelToMesh.goomba3,foot1 = BBmodelToMesh.goombaFoot5,foot2 = BBmodelToMesh.goombaFoot6,pos=BBmodelToMesh.goomba3.translation:copy(),angle=0,canJump = 4},
    goomba4 = {model = BBmodelToMesh.goomba4,foot1 = BBmodelToMesh.goombaFoot7,foot2 = BBmodelToMesh.goombaFoot8,pos=BBmodelToMesh.goomba4.translation:copy(),angle=0,canJump = 4},
    goomba5 = {model = BBmodelToMesh.goomba5,foot1 = BBmodelToMesh.goombaFoot9,foot2 = BBmodelToMesh.goombaFoot10,pos=BBmodelToMesh.goomba5.translation:copy(),angle=0,canJump = 4},
    goomba6 = {model = BBmodelToMesh.goomba6,foot1 = BBmodelToMesh.goombaFoot11,foot2 = BBmodelToMesh.goombaFoot12,pos=BBmodelToMesh.goomba6.translation:copy(),angle=0,canJump = 4},
    goomba7 = {model = BBmodelToMesh.goomba7,foot1 = BBmodelToMesh.goombaFoot13,foot2 = BBmodelToMesh.goombaFoot14,pos=BBmodelToMesh.goomba7.translation:copy(),angle=0,canJump = 4},
    goomba8 = {model = BBmodelToMesh.goomba8,foot1 = BBmodelToMesh.goombaFoot15,foot2 = BBmodelToMesh.goombaFoot16,pos=BBmodelToMesh.goomba8.translation:copy(),angle=0,canJump = 4}
}

ironBalls = {
ironBall1 = {model = BBmodelToMesh.ironBall1,timer = 0, stage = 1, start = 1,timeForStage = 10},
ironBall2 = {model = BBmodelToMesh.ironBall2,timer = 5, stage = 3, start = 1,timeForStage = 10},
ironBall3 = {model = BBmodelToMesh.ironBall3,timer = 0, stage = 6, start = 1,timeForStage = 10}}


coins = {
    coin1 = BBmodelToMesh.coin1,
    coin2 = BBmodelToMesh.coin2,
    coin3 = BBmodelToMesh.coin3,
    coin4 = BBmodelToMesh.coin4,
    coin5 = BBmodelToMesh.coin5,
    coin6 = BBmodelToMesh.coin6,
    coin7 = BBmodelToMesh.coin7,
    coin8 = BBmodelToMesh.coin8,
    coin9 = BBmodelToMesh.coin9,
    coin10 = BBmodelToMesh.coin10,
    coin11 = BBmodelToMesh.coin11,
    coin12 = BBmodelToMesh.coin12,
    coin13 = BBmodelToMesh.coin13,
    coin14 = BBmodelToMesh.coin14,
    coin15 = BBmodelToMesh.coin15,
    coin16 = BBmodelToMesh.coin16,
    coin17 = BBmodelToMesh.coin17,
    coin18 = BBmodelToMesh.coin18,
    coin19 = BBmodelToMesh.coin19,
    coin20 = BBmodelToMesh.coin20,
    coin21 = BBmodelToMesh.coin21,
    coin22 = BBmodelToMesh.coin22,
    coin23 = BBmodelToMesh.coin23,
    coin24 = BBmodelToMesh.coin24,
    coin25 = BBmodelToMesh.coin25,
}


trees = {
    BBmodelToMesh.tree1,
    BBmodelToMesh.tree2,
    BBmodelToMesh.tree3,
    BBmodelToMesh.tree4,
    BBmodelToMesh.tree5,
    BBmodelToMesh.tree6,
    BBmodelToMesh.tree7,
    BBmodelToMesh.tree8,
    BBmodelToMesh.tree9,
    BBmodelToMesh.tree10,
    BBmodelToMesh.tree11,
    
}
coinAnim = {
"bobthebetter.coin1",
"bobthebetter.coin4",
"bobthebetter.coin3",
"bobthebetter.coin2",
}
sparkleAnim = {
    "bobthebetter.sparkle6",
    "bobthebetter.sparkle5",
    "bobthebetter.sparkle4",
    "bobthebetter.sparkle3",
    "bobthebetter.sparkle2",
    "bobthebetter.sparkle1",
    }
    oneUps = {

    }
    warpHitboxes = {flowers = {hitbox1 = {vec(-129.34011, 44.098, 64.49794),vec(-132.69319, 44.10328, 65.31539),dest = vec(40.48217, 48.63329, -134.07318)},hitbox2 = {vec(41.19253, 48.63505, -132.81875),vec(39.05165, 48.63173, -135.61179),dest = vec(-131.11346, 44.10255, 65.79824)}},
                    wallthings = {hitbox1 = {vec(10.40831, 11.86972, 105.59531),vec(14.03751, 11.86687, 106.1273),dest = vec(34.70831, -11.19241, 107.67643)},hitbox2 = {vec(36.30399, -11.19227, 108.59753),vec(33.04324, -11.19059, 107.68549),dest = vec(12.9326, 11.86678, 105.49329)}}}
    local oneupflag1 = false
toDelete = {}
toDeleteOneUP = {}

ironBallPath={{start=vec(9.15314, 13.45406, 112.77145),dest = vec(8.30987, 14.17767, 117.71775) ,time=20},{start=vec(8.30987, 14.17767, 117.71775) ,dest = vec(62.80885, 16.37382, 148.41792)   ,time=50},{start=vec(62.80885, 16.37382, 148.41792)  ,dest = vec(124.01333, 24.95544, 116.86376)    ,time=70},{start=vec(124.01333, 24.95544, 116.86376)    ,dest=vec(112.41302, 28.36095, 47.13164)      ,time=70},{start=vec(112.41302, 28.36095, 47.13164)      ,dest=vec(59.17217, 33.64776, 33.78956)        ,time=50},{start=vec(59.17217, 33.64776, 33.78956)      ,dest=vec(46.07936, 36.8481, 27.32779)        ,time=10},{start=vec(46.07936, 36.8481, 27.32779)      ,dest=vec(-33.71869, 65.39847, 16.89674)          ,time=45}  }
function events.tick()





    warpCooldown = warpCooldown - 1

if playerVel:length()<0.2 then
    if warpCooldown < 0 and cameraPos.x < warpHitboxes.flowers.hitbox1[1].x and cameraPos.x > warpHitboxes.flowers.hitbox1[2].x and cameraPos.y < warpHitboxes.flowers.hitbox1[2].y and cameraPos.y > warpHitboxes.flowers.hitbox1[1].y and cameraPos.z < warpHitboxes.flowers.hitbox1[2].z and cameraPos.z > warpHitboxes.flowers.hitbox1[1].z then
        cameraPos=warpHitboxes.flowers.hitbox1.dest:copy()
        sounds:playSound("warp", player:getPos())
        warpCooldown = 250
    end
    if  warpCooldown < 0 and cameraPos.x < warpHitboxes.flowers.hitbox2[1].x and cameraPos.x > warpHitboxes.flowers.hitbox2[2].x and cameraPos.y > warpHitboxes.flowers.hitbox2[2].y and cameraPos.y < warpHitboxes.flowers.hitbox2[1].y and cameraPos.z > warpHitboxes.flowers.hitbox2[2].z and cameraPos.z < warpHitboxes.flowers.hitbox1[2].z then
        cameraPos=warpHitboxes.flowers.hitbox2.dest:copy()
        sounds:playSound("warp", player:getPos())
        warpCooldown = 250
    end
    if  warpCooldown < 0 and cameraPos.x > warpHitboxes.wallthings.hitbox1[1].x and cameraPos.x < warpHitboxes.wallthings.hitbox1[2].x and cameraPos.y < warpHitboxes.wallthings.hitbox1[1].y+1 and cameraPos.y > warpHitboxes.wallthings.hitbox1[2].y-1 and cameraPos.z > warpHitboxes.wallthings.hitbox1[1].z and cameraPos.z < warpHitboxes.wallthings.hitbox1[2].z then
        cameraPos=warpHitboxes.wallthings.hitbox1.dest:copy()
        sounds:playSound("warp", player:getPos())
        warpCooldown = 250
    end
    if  warpCooldown < 0 and cameraPos.x < warpHitboxes.wallthings.hitbox2[1].x and cameraPos.x > warpHitboxes.wallthings.hitbox2[2].x and cameraPos.y > warpHitboxes.wallthings.hitbox2[1].y-1 and cameraPos.y < warpHitboxes.wallthings.hitbox2[2].y+1 and cameraPos.z < warpHitboxes.wallthings.hitbox2[1].z and cameraPos.z > warpHitboxes.wallthings.hitbox2[2].z then
        cameraPos=warpHitboxes.wallthings.hitbox2.dest:copy()
        sounds:playSound("warp", player:getPos())
        warpCooldown = 250
    end
end

for i, goomba in pairs(goombas) do

    if (goomba.pos-cameraPos):length()<42.5 then



        if (goomba.pos-cameraPos):length()>19.5 then
            goomba.canJump = 0
            goomba.angle= (goomba.angle+3)%360
            goomba.pos = goomba.pos-vec(0,-0.3,0) -vectors.angleToDir(0,goomba.angle)*0.1
            goomba.model.rotation = vec(math.sin(world.getTime()/5)*10,-goomba.angle-270,0)
            goomba.foot1.rotation= vec(0,-goomba.angle-270,math.abs(math.sin(world.getTime()/5))*40)
            goomba.foot2.rotation= vec(0,-goomba.angle-270,(math.abs(math.sin((world.getTime()+math.pi*2.5)/5)))*40)
        else    -- Calculate the target angle (in degrees)
        if goomba.canJump<=4 then 
            if goomba.canJump == 0 then
                sounds:playSound("goombaNotice", player:getPos())
            end
goomba.canJump=goomba.canJump+1
goomba.pos.y=goomba.pos.y-1.5/goomba.canJump
        elseif world.getTime()%3 == 0 then
        sounds:playSound("goombaStep", player:getPos())
        end
        local turnSpeed = 4
            local direction = vec(goomba.pos.x - cameraPos.x, 0, goomba.pos.z - cameraPos.z):normalize()
            local targetAngle = math.abs(math.deg(math.atan2(-direction.x, -direction.z))-180 ) -- atan2(y, x) handles quadrant correction
        
            -- Get the shortest rotation direction
            local angleDiff = (targetAngle - goomba.angle + 360) % 360  -- Keeps angle difference in [-180, 180]

            -- Apply smooth rotation
            if math.abs(angleDiff) > turnSpeed then
                if angleDiff < 180 then
                    goomba.angle = (goomba.angle + turnSpeed) % 360  -- Rotate clockwise
                else
                    goomba.angle = (goomba.angle - turnSpeed + 360) % 360  -- Rotate counterclockwise
                end
            else
                goomba.angle = targetAngle  -- Snap to the exact angle if close enough
            end


            goomba.pos = goomba.pos-vec(0,-0.3,0) -vectors.angleToDir(0,goomba.angle)*0.355
            goomba.model.rotation = vec(math.sin(world.getTime()/2)*20,-goomba.angle-270,0)
            goomba.foot1.rotation= vec(0,-goomba.angle-270,math.abs(math.sin(world.getTime()/2))*40)
            goomba.foot2.rotation= vec(0,-goomba.angle-270,(math.abs(math.sin((world.getTime()+math.pi*1.5)/2)))*40)
        end

    for j, mesh in pairs(colTris) do
        for k, triTranslated in pairs(mesh) do
            goomba.pos = sphereTriangleCollisionObj(goomba.pos,2,triTranslated[1],triTranslated[2],triTranslated[3])
        end
    end



goomba.model.translation = goomba.pos+vec(0,0.3,0)
goomba.model.pivot = goomba.pos+vec(0,0.3,0)
goomba.foot1.translation = goomba.pos+vec(0,0.3,0)
goomba.foot1.pivot = goomba.pos+vec(0,0.3,0)
goomba.foot2.translation = goomba.pos+vec(0,0.3,0)
goomba.foot2.pivot = goomba.pos+vec(0,0.3,0)
else
    goomba.model.translation = goomba.pos+vec(09999999,0.3,0)
goomba.model.pivot = goomba.pos+vec(0999999999,0.3,0)
goomba.foot1.translation = goomba.pos+vec(099999999,0.3,0)
goomba.foot1.pivot = goomba.pos+vec(0999999999,0.3,0)
goomba.foot2.translation = goomba.pos+vec(099999999,0.3,0)
goomba.foot2.pivot = goomba.pos+vec(0999999999,0.3,0)
end
end
for i, tree in pairs(trees) do
    tree.rotation = -VectorToAngles((cameraPosWithOffset-tree.translation).x_z)+vec(-90,0,180)
end
for i, oneUp in pairs(oneUps) do
    oneUp.bbmodel.rotation = -VectorToAngles((cameraPosWithOffset-oneUp.bbmodel.translation).x_z)+vec(-90,0,180)
    oneUp.lifetime = oneUp.lifetime-1
    if oneUp.stage == 1 then
        oneUp.bbmodel.translation = oneUp.pos+polarToCartesian(1,18*oneUp.lifetime)
        if oneUp.lifetime < 0 then 
            oneUp.stage = 2
            oneUp.lifetime = 200
        end
    end
    if oneUp.stage == 2 then

        local newPos = oneUp.pos-vec(0,-0.3,0)+vectors.angleToDir(0,oneUp.angle)*0.4
        oneUp.angle = oneUp.angle+2*oneUp.aistage

        if oneUp.aistage == -1 then 

        if math.random()>0.2 then
            oneUp.aistage = 1
        end
        end
        if oneUp.aistage == 1 then 

            if math.random()>0.2 then
                oneUp.aistage = -1
            end
            end
        local newerPos 
        for i, mesh in pairs(colTris) do
            for k, triTranslated in pairs(mesh) do
                newerPos = sphereTriangleCollisionObj(newPos,2,triTranslated[1],triTranslated[2],triTranslated[3])
                if newerPos ~= oneUp.pos-vec(0,-0.3,0) then
                    newPos = newerPos:copy()
                end

            end
          end
          oneUp.pos = newPos:copy()
         oneUp.bbmodel.translation = newPos:copy()
         oneUp.bbmodel.pivot = newPos:copy()
        if (cameraPos-oneUp.bbmodel.translation):length() < 2.5 then
            lives = lives + 1
            mesh[i] = nil
            oneUps[i]=nil
            sounds:playSound("oneupcollect", player:getPos())
        end
        if oneUp.lifetime<0 then

            mesh[i] = nil
            oneUps[i]=nil
        end

            end
end
for i, coin in pairs(coins) do
    local dist = (cameraPos-coin.translation):length()
    if dist<20 then
    coin.textureName = coinAnim[(math.floor(world.getTime()/3)%#coinAnim)+1]    
    coin.rotation = -VectorToAngles((cameraPosWithOffset-coin.translation).x_z)+vec(-90,0,180)
    if dist < 2.2 then
        table.insert(toDelete,{timer = #sparkleAnim, i=i,coin = coin})
        sounds:playSound("coin", player:getPos())
        coins[i] = nil
        if (not coins.coin6) and (not coins.coin7) and (not coins.coin8) and (not coins.coin9) and (not coins.coin10) and (not coins.coin11) and (not coins.coin12) and (not coins.coin13) and (not coins.coin14) and (not coins.coin15) and not oneupflag1 then
            oneupflag1 = true
            BBmodelToMesh.oneUp1 = {
                modelpart = models.bobthebetter.oneUp1,
                translation = vec(-119.73335, 40.16659, 103.610250)   ,
                rotation = vec(0,0,0),
                scale = vec(1,1,1)*2,
                pivot = vec(-119.73335, 40.16659, 103.610250) ,
                facNums = vec(99,308),
                texture = textures[""],
                textureName = "bobthebetter.oneup",
                noLighting = true
            }
            sounds:playSound("oneup", player:getPos())
            convertBBmodelToMesh(BBmodelToMesh.oneUp1.modelpart,"oneUp1",BBmodelToMesh.oneUp1.textureName,BBmodelToMesh.oneUp1.facNums)
            oneUps.oneUp1 = {bbmodel=BBmodelToMesh.oneUp1,stage = 1,lifetime = 75,angle = 0,pos = BBmodelToMesh.oneUp1.translation:copy(),aistage = -1}
        end
    end
end
end
for i, ironBall in pairs(ironBalls) do
    local dist = (cameraPos-ironBall.model.translation):length()


    ironBall.timer = ironBall.timer+1
    if ironBall.timer > ironBall.timeForStage then
        ironBall.stage=ironBall.stage+1
        if ironBall.stage > #ironBallPath then
            ironBall.stage = 1
            if dist<30 then
            sounds:playSound("explosion", player:getPos(),10,1.5)
            end
        end
        ironBall.timer=0
        ironBall.timeForStage=ironBallPath[ironBall.stage].time
    end
    ironBall.model.translation = math.lerp(ironBallPath[ironBall.stage].start,ironBallPath[ironBall.stage].dest,(ironBall.timer/ironBall.timeForStage))
    local hit, intersection
if (ironBall.model.translation-cameraPosWithOffset):length()<85 then
        
        ironBall.model.rotation = -VectorToAngles((cameraPosWithOffset-ironBall.model.translation).xyz)+vec(-90,0,180) 

        for i, mesh in pairs(colTris) do

            for k, triTranslated in pairs(mesh) do


                hit, intersection = triangleRaycast(ironBall.model.translation+vec(0,-10,0),vec(0,1,0),triTranslated[1],triTranslated[2],triTranslated[3])
                if hit then break end
            end
            if hit then break end
        end
    end
        if hit then

            ironBall.model.translation=intersection-vec(0,3,0)
            ironBall.model.pivot=intersection-vec(0,3,0)
        else
            ironBall.model.translation = vec(99999,999999,999999)
        end


end
for i, tbl in pairs(toDelete) do
    if tbl.timer == 0 then
        mesh[tbl.i] = nil
        toDelete[i]=nil
    end
    tbl.coin.textureName = sparkleAnim[math.ceil(tbl.timer)]
    tbl.coin.scale = vec(3,3,3)
    tbl.timer = tbl.timer - 1

end
end

--[lua] SOOMUCHLAG : {35,41509, 65,09916, -94,2837} [lua] SOOMUCHLAG : {-0,21212, 0,96478, 0,15553} 


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
    local seesawRotationLimit = 38
  local seesawRotation = 0
  local seesawDir = vectors.angleToDir(0,43)
    -- Sphere-Triangle collision and resolution function
  function sphereTriangleCollisionObj(sphereCenter, sphereRadius, v0, v1, v2,i)
    -- Step 1: Calculate triangle normal
  local npos = sphereCenter:copy()
    local triangleNormal = (v1 - v0):crossed(v2 - v0):normalize()
  
  
    -- Step 3: Check if the projected point is within the triangle using barycentric coordinates
    if pointInTriangle( (sphereCenter- triangleNormal* (sphereCenter - v0):dot(triangleNormal)), v0, v1, v2) then
        -- Step 4: Calculate the distance from the spheres center to the plane
        local distanceToPlane = (sphereCenter- v0):dot(triangleNormal)
    
        -- Step 5: If the distance is less than the sphere's radius, resolve the collision
        if math_abs(distanceToPlane) < sphereRadius then

            -- Move the sphere along the normal of the triangle to push it out of the collision
            local moveDirection = triangleNormal* (sphereRadius - math_abs(distanceToPlane))

            -- Move the sphere's center out of the triangle plane

            npos = sphereCenter+ moveDirection


  
          end
    end

    -- Step 6: Return the adjusted sphere center

    return npos
  end
  
  
  

-- 2 
-- 3 
-- 4 
-- 5 
-- 6 vec(59.17217, 33.64776, 33.78956)  
-- 7 vec(46.07936, 36.8481, 27.32779)
-- 8 vec(-33.71869, 65.39847, 16.89674)  