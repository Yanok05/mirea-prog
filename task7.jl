
#=ДАНО: Робот - рядом с горизонтальной бесконечно продолжающейся 
   в обе стороны перегородкой (под ней), в которой имеется проход шириной в одну клетку.
   РЕЗУЛЬТАТ: Робот - в клетке под проходом
=#

using HorizonSideRobots

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

function endless_line(robot)
    side = Ost
    step = 1
    while !isborder(robot, Nord)
        for i in 1:step
            move!(robot, side)
        end
        side = inverse(side)
        step += 1
    end
end

r = Robot("test.sit", animate=true)
endless_line!(r)