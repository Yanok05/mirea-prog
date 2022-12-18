
#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних 
   перегородок)
   РЕЗУЛЬТАТ: Робот - в исходном положении, и на всем поле расставлены маркеры в шахматном порядке клетками размера N*N (N-параметр функции), начиная с юго-западного угла
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

function get_cage_size!(robot)
    x = 0
    y = 0
    while !isborder(robot, Ost)
        move!(robot, Ost)
        x += 1
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        y += 1
    end
    gotostart!(robot)
    return x, y
end

function square_chess!(robot)
    x, y = gotostart!(robot)
    x_size, y_size = get_cage_size!(robot)
    n = minimum([x_size , y_size])
    c = 0
    side = Ost
    putmarker!(robot)
    for i in 1:n+1
        for j in 1:n
            move!(robot, side)
            if c % 2 == 1
                putmarker!(robot)
            end
            c += 1
        end
        if i == n+1
            break
        end
        move!(robot, Nord)
        side = inverse(side)
        if c % 2 == 1
            putmarker!(robot)
        end
        c += 1
    end
    return_to_start!(robot, x, y)
end

robot = Robot("test.sit", animate=true)
square_chess!(robot)