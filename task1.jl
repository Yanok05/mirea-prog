#=ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без 
внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки. 1
=#

using HorizonSideRobots

function numsteps_putmarkers!(robot, side)
    num_steps = 0
    while !isborder(robot, side)
        move!(robot, side)
        num_steps += 1
        putmarker!(robot)
    end
    return num_steps
end


function inverse(side::HorizonSide)
    HorizonSide((Int(side) + 2) % 4)
end


function along!(robot, side, num_steps)
    for a in 1:num_steps move!(robot, side) end
end


function cross!(robot)
    for side in (Nord, West, Sud, Ost)
        n = numsteps_putmarkers!(robot, side)
        along!(robot, inverse(side), n)
    end
    putmarker!(robot)
end

robot = Robot("test.sit", animate=true)
cross!(robot)
