local a = peripheral.wrap('ntm_pile_loader_0')
local b = peripheral.wrap('ntm_pile_loader_1')
 
function enable_fuel()
    redstone.setAnalogOutput('right', 15)
end
 
function disable_fuel()
    redstone.setAnalogOutput('right', 0)
end
 
function enable_neutral()
    redstone.setAnalogOutput('left', 15)
end
 
function disable_neutral()
    redstone.setAnalogOutput('left', 0)
end
 
function push_all_neutral()
    enable_neutral()
    for i=1, 4, 1 do
        print(i)
        a.load()
        b.load()
        sleep(1)
    end 
    disable_neutral()
    a.load()
    b.load()
end
 
function push_all_fuel()
    enable_fuel()
    for i=1, 4, 1 do
        a.load()
        b.load()
        sleep(1)
    end
    disable_fuel()
    a.load()
    b.load()
end
push_all_neutral()
while true do
    write('type wanted (4=pu239, 5=pu_rgp, 8=th_fuel, 6=waste)\n')
    local type = read()
    write('\nstart? y/n ')
    local strt = read()
    if strt == "y" then
        push_all_fuel()
    end
    sleep(1)
    if a.getLifetime() == 0 or b.getLifetime() == 0 then
        print('one or more fuel channels are not activated')
        strt = ""
    end
    while strt == 'y' do
        sleep(0.5)
        print(a.getDepletion() + b.getDepletion() .."/".. a.getLifetime() + b.getLifetime())
        if (a.getType() + b.getType()) == (type*2) then
            push_all_neutral()
            break
        end
    end
end