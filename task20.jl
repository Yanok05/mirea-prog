using HorizonSideRobots
include("functions2.jl")

#Написать рекурсивную функцию, перемещающую робота в соседнюю клеьку в заданном направлении, при этом на пути робота может находиться изолированная прямолинейная перегородка конечной длины.

function step!(robot::Robot, side::HorizonSide)::Nothing
    if !isborder(robot, side)
        move!(robot, side)
    else
        move!(robot, left(side))
        step!(robot, side)
        move!(robot, right(side))
    step!(robot, side)
    end
end

r = Robot("situations/20.sit", animate = true)
step!(r, Ost)