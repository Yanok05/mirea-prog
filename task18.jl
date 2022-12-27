using HorizonSideRobots

#Написать рекурсивную функцию, перемещающую робота до упора в заданном направлении.

function tolim!(robot, side)   
    if !isborder(robot, side)
        move!(robot,side)
        tolim!(robot, side)
    end
end


r = Robot("situations/test.sit", animate=true)
tolim!(r, Ost)