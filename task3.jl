#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
   РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы 1
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
    gotostart!(robot)
    for i = 1:x
        move!(robot, Ost)
    end
    for i = 1:y
        move!(robot, Nord)
    end
end

function mark_all!(robot)
    side = Ost
    x, y = gotostart!(robot)
    putmarker!(robot)
    while !isborder(robot, side) || !isborder(robot, Nord)
        if !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        else
            putmarker!(robot)
            move!(robot, Nord)
            side = inverse(side)
        end
    end 
    return_to_start!(robot, x, y)
end

robot = Robot("test.sit", animate=true)
mark_all!(robot)
