
#=Робот находится рядом с границей лабиринта произвольной формы.
	Требуется определить где он находится, внутри лабиринта или снаружи.
=#
include("functions.jl")

function borderside(robot)
    if isborder(robot, Nord)
        return Nord
    elseif isborder(robot, Ost)
        return Ost
    elseif isborder(robot, Sud)
        return Sud
    elseif isborder(robot, West)
        return West
    end
end

function nextside(side)
    if side == Nord
        return Ost
    elseif side == Ost
        return Sud
    elseif side == Sud
        return West
    elseif side == West
        return Nord
    end
end

function changecoords(coords, side2)
    if side2 == Ost
        coords[1] += 1
    elseif side2 == West
        coords[1] -= 1
    elseif side2 == Nord
        coords[2] += 1
    elseif side2 == Sud
        coords[2] -= 1
    end
    return coords
end

function changeside(side, side2, ugol)
    if ugol == "in"
        if side == Nord
            side = Ost
            side2 = Sud
        elseif side == Ost
            side = Sud
            side2 = West
        elseif side == Sud
            side = West
            side2 = Nord
        else
            side = Nord
            side2 = Ost
        end
    else
        if side == Nord
            side = inverse(side2)
            side2 = Nord
        elseif side == Ost
            side = inverse(side2)
            side2 = Ost
        elseif side == Sud
            side = inverse(side2)
            side2 = Sud
        else
            side = inverse(side2)
            side2 = West
        end
    end
    return side, side2
end

function check!(robot)
    in_ugol = 0
    out_ugol = 0
    coords = [0, 0]
    side = borderside(robot)
    side2 = nextside(side)
    while isborder(robot, side2)
        side, side2 = changeside(side, side2, "in")
    end
    empties = 0
    for i in sides
        if !isborder(robot, i)
            empties += 1
        end
    end
    for _ in 1:empties
        move!(robot, side2)
        coords = changecoords(coords, side2)
        while coords != [0, 0]
            while !isborder(robot, side2) && isborder(robot, side)
                move!(robot, side2)
                coords = changecoords(coords, side2)
            end
            if !isborder(robot, side)
                out_ugol += 1
                side, side2 = changeside(side, side2, "out")
                if coords == [0, 0]
                    break
                end
                move!(robot, side2)
                coords = changecoords(coords, side2)
            elseif isborder(robot, side2)
                in_ugol += 1
                side, side2 = changeside(side, side2, "in")
            
            end
        end
    end
    if in_ugol - out_ugol == 4
        return "Внутри"
    else
        return "Снаружи"
    end
end

robot = Robot("situations/38.sit", animate = true)
println(check!(robot))