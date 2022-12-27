
#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на поле расставлены горизонтальные перегородки различной длины (перегорки длиной в несколько клеток, считаются одной перегородкой), не касающиеся внешней рамки.
РЕЗУЛЬТАТ: Робот — в исходном положении, подсчитано и возвращено число всех перегородок на поле.
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
    for i = 1:y
        move!(robot, Nord)
    end
    for i = 1:x
        move!(robot, Ost)
    end
end

function count_wall!(robot)
    x, y = gotostart!(robot)
    side = Ost
    walls = 0
    isbarrier = false
    while (!isborder(robot, side) || !isborder(robot, Nord)) && (!isborder(robot, inverse(side)) || !isborder(robot, Nord))
        while !isborder(robot, side)
            move!(robot, side)
            if isborder(robot, Nord)
                isbarrier = true
            else
                if isbarrier
                    walls += 1
                end
                isbarrier = false
            end
        end
        move!(robot, Nord)
        side = inverse(side)
    end
    return_to_start!(robot, x, y)
    return walls 
end

robot = Robot("situations/11.sit", animate=true)
count_wall!(robot)