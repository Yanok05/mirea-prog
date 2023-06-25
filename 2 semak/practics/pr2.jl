# 1. Написать обобщенную функцию, реализующую алгоритм быстрого возведения в степень

function FastPower(a, n)
    k=n; p=a; t=1
    #ИНВАРИАНТ: p^k * t == a^n
    while k>0
        if iseven(k)
            k /= 2 # - преобразование, направленное в сторону завершеня цикла,
            p *= p # тогда следующее преобразование следует из инварианта
        else
            k -= 1 # - преобразование, направленное в сторону завершеня цикла,
            t *= p # тогда следующее преобразование следует из инварианта
        end
    end
end


#2. На база этой функции написать другую функцию, возвращающую n-ый член последовательности Фибоначчи (сложность - O(log n)).

Base.oneunit(::Type{Matrix{T}}) where T = [oneunit(T) zero(T) ; zero(T) oneunit(T)]

function GetFibonachi(n::Integer)::Real
	return FastPower([1 1 ; 1 0],n)[1,1]
end

println("5 член фиббоначи: ",GetFibonachi(5))

# 3.Написать функцию, вычисляющую с заданной точностью $\log_a x$ (при произвольном $a$, не обязательно, что $a>1$)

function logarifm(x, a, eps)
    #ИНВАРИАНТ: a^y * z^t = x = const
    y, z, t = 0, x, 1.0
    while abs(t) >= eps || z <= 1.0/a || z >= a
        if z >= a
            z = z/a
            y = y + t
        elseif z <= 1.0/a
            z = z*a
            y = y - t
        else
            z = z * z
            t = t / 2.0
        end
    end
    return y
end

# 4.Написать функцию, реализующую приближенное решение уравнения вида $f(x)=0$ методом деления отрезка пополам.

function bisection(f::Function, a, b, epsilon)
    @assert f(a)*f(b) < 0 
    @assert a < b
    f_a = f(a)
    #ИНВАРИАНТ: f_a*f(b) < 0
    while b-a > epsilon
        t = (a+b)/2
        f_t = f(t)
        if f_t == 0
            return t
        elseif f_a*f_t < 0
            b=t
        else
            a, f_a = t, f_t
        end
    end
    return (a+b)/2
end

#5. Найти приближенное решение уравнения cos(x) = x методом деления отрезка пополам.

Base.oneunit(::Type{Matrix{T}}) where T = [oneunit(T) zero(T) ; zero(T) oneunit(T)]

println("===\nДеление отрезка пополам:\ncos(x) = x\nx ~= ",
	SolveBisection(0.0,pi / 2.0,0.01) do x::Real
		return cos(x) - x
	end
)