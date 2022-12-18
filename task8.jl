
#=ДАНО: Где-то на неограниченном со всех сторон поле без внутренних перегородок 
   имеется единственный маркер. Робот - в произвольной клетке этого поля.
   РЕЗУЛЬТАТ: Робот - в клетке с маркером.
=#

using HorizonSideRobots

function reverse90(side)
    if side == Nord
        return West
    elseif side == West
        return Sud
    elseif side == Sud
        return Ost
    elseif side == Ost
        return Nord
    end
end

function spiral!(robot)
    a = 0
    b = false
    c = 1
    d = 0
    side = Nord
    while a == 0
        for i in 1:c
            move!(robot, side)
            if ismarker(robot)
                b = true
                break
            end
        end
        d += 1
        side = reverse90(side)
        if d % 2 == 0
            c += 1
        end    
        if b
            break
        end
    end
end

robot = Robot("test.sit", animate=true)
spiral!(robot)