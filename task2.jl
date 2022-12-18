#=ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
   РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы 1 
=#

using HorizonSideRobots


function gotostart!(robot)
    x = 0
    y = 0
    while !isborder(robot, West)
        move!(robot, West)
        x = x + 1
    end
    while !isborder(robot, Sud)
        move!(robot, Sud)
        y = y + 1
    end
    return x, y
end

function inverse(side)
    if side == Nord
        return Sud
    elseif side == West
        return Ost
    elseif side == Sud
        return Nord
    elseif side == Ost
        return West
    end
end

function return_to_start!(robot, x, y)
    for i = 1:x
        move!(robot, Ost)
    end
    for i = 1:y
        move!(robot, Nord)
    end
end


function border!(robot)
    x, y = gotostart!(robot)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        putmarker!(robot)
    end
    while !isborder(robot, Ost)
        move!(robot, Ost)
        putmarker!(robot)
    end
    while !isborder(robot, Sud)
        move!(robot, Sud)
        putmarker!(robot)
    end
    while !isborder(robot, West)
        move!(robot, West)
        putmarker!(robot)
    end
    return_to_start!(robot, x, y)
end

r = Robot("test.sit", animate=true)
border!(r)