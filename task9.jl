
#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних 
   перегородок)
   РЕЗУЛЬТАТ: Робот - в исходном положении, на всем поле расставлены маркеры в шахматном порядке, причем так, чтобы в клетке с роботом находился маркер
=#

using HorizonSideRobots

function gotostart!(robot)
    x = 0
    y = 0
    steps = 0
    while !isborder(robot, West)
        move!(robot, West)
        x = x + 1
        steps += 1
    end
    while !isborder(robot, Sud)
        move!(robot, Sud)
        y = y + 1
        steps += 1
    end
    return x, y, steps
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

function chess!(robot)
    x, y, steps = gotostart!(robot)
    c = 0
    side = Ost
    if steps % 2 == 0
        c = 0
        putmarker!(robot)
    else
        c = 1
    end
    while !isborder(robot, side) || !isborder(robot, Nord)
        if isborder(robot, side)
            move!(robot, Nord)
            side = inverse(side)
        else
            move!(robot, side)
        end
        if c == 1
            putmarker!(robot)
            c = 0
        else
            c = 1
        end
    end
    return_to_start!(robot, x, y)
end

robot = Robot("test.sit", animate=true)
chess!(robot)