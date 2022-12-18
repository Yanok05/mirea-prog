
#=ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без 
внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре косого креста из маркеров, расставленных вплоть до внешней рамки. 1
=#

using HorizonSideRobots

sides = [Nord, Ost, Sud, West]

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

function cross_branch!(robot, side1, side2)
    n = 0
    while !isborder(robot, side1) && !isborder(robot, side2)
        move!(robot, side1)
        move!(robot, side2)
        putmarker!(robot)
        n += 1
    end
    return n
end

function along!(robot, side1, side2, num_steps)
    for a in 1:num_steps 
        move!(robot, side1) 
        move!(robot, side2)
    end
end

function cross_cross!(robot)
    for i in 1:4
        side1 = sides[i]
        side2 = sides[i % 4 + 1]
        n = cross_branch!(robot, side1, side2)
        along!(robot, inverse(side1), inverse(side2), n)
    end
    putmarker!(robot)
end

robot = Robot("test.sit", animate=true)
cross_cross!(robot)
