
#=ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя 
   перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками. 
   РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней, как внутренней, так и внешней, перегородки поставлены маркеры.
=#

include("functions.jl")

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


function putmarkers!(robot::Robot,side::HorizonSide)::Nothing
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end

function rotate_side(r, side)

end

function makedoubleframe!(robot::Robot)
    x, y = gotostart!(robot)
	
	while !isborder(robot,Sud) || !isborder(robot,Ost)
		if !isborder(robot,Ost)
			move!(robot,Ost)
		end

		if !isborder(robot,Sud)
			move!(robot,Sud)
		end
	end

    for side in (HorizonSide(i) for i in 0:3)
        putmarkers!(robot,side)
    end

	side = West

	while !isborder(robot,Nord)
		move!(robot,side)

		if isborder(robot,side)
			side = inverse(side)
			move!(robot,Nord)
		end
	end

	if side == Ost
        direc = 1
    else
        direc = 0
    end


	for i in 0:3
		while isborder(robot,direction(direc, side))
			putmarker!(robot)
			move!(robot,side)
		end
		
		putmarker!(robot)

		if i >= 3 break end
		
		side = direction(direc, side)
		move!(robot,side)
	end
    return_to_start!(robot, x, y)
end


robot = Robot("1.sit",animate=true)
makedoubleframe!(robot)