using HorizonSideRobots

#двигает робота в нижний девый угол
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

#возвращает робота в исходное положение
function return_to_start!(robot, x, y)
    gotostart!(robot)
    for i in 1:y
        move!(robot, Nord)
    end 
    for i in 1:x
        move!(robot, Ost)
    end
end

along!(robot::Robot,side::HorizonSide)::Nothing =
    while !isborder(robot,side)
        move!(robot,side)
    end

#робот движется в сторону до <условие>
function along!(robot, side, num_steps)
    for a in 1:num_steps move!(robot, side) end
end

#меняет сторону на противоположенную
function inverse(side::HorizonSide)
    HorizonSide((Int(side) + 2) % 4)
end

#возвращает размер клетки
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

#меняет сторону против часовой
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

#меняет сторону по часовой
function reverse_90(side)
    if side == Nord
        return Ost
    elseif side == Nord
        return Sud
    elseif side == West
        return Ost
    elseif side == Ost
        return Sud
    end
end

#определяет в какую сторону нужно поворачивать роботу(по часовой/против)
function direction(direc, side)
    if direc == 1
        return reverse90(side)
    else
        return reverse_90(side)
    end
end

#проставляет маркеры в направлении
function putmarkers!(robot::Robot,side::HorizonSide)::Nothing
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end

function try_move!(robot, direct)::Bool
    if isborder(robot, direct)
        return false
    end
    move!(robot, direct)
    return true
end


try_move!(robot, direct) = (!isborder(robot, direct) && (move!(robot, direct); return true); false)

sides = [Nord, Ost, Sud, West]