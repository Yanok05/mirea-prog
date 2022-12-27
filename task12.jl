include("functions.jl")

function count_wall2!(robot)
    x, y = gotostart!(robot)
    side = Ost
     # т.к. по условию в крайнем положении над роботом перегородки нет и, можно считать, что как бы и на предыдущем шаге ее не было 
    num_borders = 0
    #ИНВАРИАНТ: num_borders = число_обнаруженных(пройденных)_концов_перегородок
    while (!isborder(robot, side) || !isborder(robot, Nord)) && (!isborder(robot, inverse(side)) || !isborder(robot, Nord))
        state = 0
        while try_move!(robot, side)
            if state == 0
                if isborder(robot, Nord)
                    # обнаружено начало очередной перегородки
                    state = 1                 
                end
            elseif state == 1 # на предыдущем шаге была перегородка
                if !isborder(robot, Nord)
                    state = 2
                    # алгоритм находится в состоянии ожидания возможного конца перегородки
                end
            else # state == 2
                if !isborder(robot, Nord)
                    state = 0
                    # обнаружен конец очередной перегородки                
                    num_borders += 1
                else
                    state = 1
                end
            end
        end
        if state == 2
            num_borders +=1
        end
        move!(robot, Nord)
        side = inverse(side)
    end

    return_to_start!(robot, x, y) 
    return num_borders
end

r = Robot("situations/11.sit", animate= true)
print(count_wall2!(r))