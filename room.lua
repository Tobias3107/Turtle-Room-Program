function checkFuelThenRefuel(blocks)
    while turtle.getFuelLevel() <= 0 do
        if blocks <= 20000 then
            if turtle.getFuelLevel() < blocks then
                refuel()
            end
        end
    end
end

function refuel()
    for i=1,4 do
        turtle.select(i)
        if turtle.refuel(0) then
            stack = turtle.getItemCount()
            turtle.refuel(stack)
        end
    end
end

function digForward()
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
end

function goBack(blocks)
    print("Going Back " .. blocks)
    turtle.turnLeft();
    turtle.turnLeft();
    for i=0,blocks do
        digForward()
    end       
    turtle.turnLeft();
    turtle.turnLeft();
end

function goForward(blocks)
    for i=0,blocks do
        digForward()
    end
end

function digLayer(width, length)
    for y=0,length do
        for x=0,width-1 do
            digForward()
        end      
        goBack(width-1) 
        if y ~= length then
            turtle.turnLeft()
            digForward()
            turtle.turnRight() 
        end
    end
    turtle.turnRight()
    goForward(length-1)
    turtle.turnLeft()
end    

function nextLayer()
    print("Going Next Layer")
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end


print("Breite vom Raum")
local width = tonumber(io.read())-1

print("Länge des Raumes")
local length = tonumber(io.read())-1

print("Höhe des Raumes")
local heigth = tonumber(io.read())-1

local maxBlocks = heigth*length*width
print "Checking fuel..."

print("Minimum Fuel: " .. maxBlocks)
checkFuelThenRefuel(maxBlocks)
print("Fuel: " .. turtle.getFuelLevel())
local z = 0
digForward()
while z<=heigth do
    print("Digging Layer :"..z)
    checkFuelThenRefuel(maxBlocks)
    digLayer(width,length)
    if(z~=heigth) then
        nextLayer()
    end
    z = z+1
end

while turtle.down() do
    
end