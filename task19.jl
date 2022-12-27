using HorizonSideRobots

#Написать рекурсивную функцию, перемещающую робота до упора в заданном направлении, ставящую возле перегородки маркер и возвращающую робота в исходное положение.

function marklim!(robot, side)
    if isborder(robot, side)
        putmarker!(robot)
    else
        move!(robot, side)
        marklim!(robot, side)
        move!(robot, inverse(side))
    end
end

r = Robot("situations/test.sit", animate=true)
marklim!(r, Ost)