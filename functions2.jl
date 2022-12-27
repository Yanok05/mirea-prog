using HorizonSideRobots
include("functions.jl")

function try_move!(robot, direct)::Bool
    if isborder(robot, direct)
        return false
    end
    move!(robot, direct)
    return true
end


function along!(condition::Function, robot, side)
    n=0
    while !condition(robot, side)
        move!(robot, side)
        n+=1
    end
    return n
end


function put_markers_along!(condition::Function, robot::Robot, side::HorizonSide, c::Int)
    while !condition(robot, side)
        if c == 1
            putmarker!(robot)
            c = 0
        else
            c = 1
        end
        move!(robot, side)
    end
    if c == 1
        putmarker!(robot)
        c = 0
    else
        c = 1
    end
end


left(side::HorizonSide)::HorizonSide = 
	HorizonSide( ( Int(side) + 1 ) % 4 )


right(side::HorizonSide)::HorizonSide =
	HorizonSide( mod( Int(side) - 1 , 4 ) )


try_move!(robot, direct) = (!isborder(robot, direct) && (move!(robot, direct); return true); false)


inverse(direct::NTuple{2, HorizonSide}) = inverse.(direct)


function along!(stop_condition::Function,robot::Robot,side::HorizonSide,num_steps::Integer)::Nothing
	for _ in 1:num_steps
		if stop_condition(robot) return end
		move!(robot,side)
	end
end


function spiral!(stop_condition::Function,robot::Robot,side::HorizonSide = Ost)::Nothing
	dist = 1
	while true
		for _ in 1:2
			if stop_condition(robot) return end
			along!(stop_condition,robot,side,dist)
			side = left(side)
		end

		dist += 1
	end
end


function shatl!(stop_condition::Function, robot::Robot, side::HorizonSide = Ost)
    amplitude = 1
    while stop_condition(robot, Nord)
        for i in 1:amplitude
            move!(robot, side)
        end
        side = inverse(side)
        amplitude += 1
    end
end