include("functions2.jl")
using HorizonSideRobots

function snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Ost, Nord))
    x, y, steps = gotostart!(robot)
    if steps % 2 != 0
        c = 0
    else
        c = 1
    end
    while !isborder(robot, move_side) || !isborder(robot, next_row_side)
        put_markers_along!(isborder, robot, move_side, c)
        if isborder(robot, Nord)
            break
        end
        move!(robot, next_row_side)
        move_side = inverse(move_side)
    end
    return_to_start!(robot, x, y)
end

#=function snake!(robot::Robot,move_side::HorizonSide,next_row_side::HorizonSide)::Nothing
	while !isborder(robot,move_side)
		along!(robot,move_side)
		if isborder(robot,next_row_side) return end

		move_side = inverse(move_side)
		move!(robot,next_row_side)
	end
end=#

r = Robot("situations/test.sit", animate = true)
snake!(r)
