# 1. Написать функцию, осуществлющую проверку, является ли заданное целое число простым; оценка сложности должна быть O(sqrt(n)) .

function isprime(n::IntType) where IntType <: Integer # является ли заданное число простым
     for d in 2:IntType(ceil(sqrt(n)))
        if n % d == 0
            return false
        end
     end
     return true
end

println("exp(1) ~= ",exp_taylor(1.0))

# 2. Написать функцию, реализующую "решето" Эратосфена, т.е. возвращающую вектор всех простых чисел, не превосходящих заданное число .

function eratosphenes_sieve(n::Integer)
    prime_indexes = ones(Bool, n)
    prime_indexes[begin] = false
    i = 2
    prime_indexes[i^2:i:n] .= false # - четные вычеркнуты
    i=3
    #ИНВАРИАНТ: i - простое нечетное
    while i <= n
        prime_indexes[i^2:2i:n] .= false
        # т.к. i^2 - нечетное, то шаг тут можно взять равным 2i, т.к. нечетное+нечетное=четное, а все четные уже вычеркнуты
        i+=1
        while i <= n && prime_indexes[i] == false
            i+=1
        end
        # i - очередное простое (первое не вычеркунутое)
    end
    return findall(prime_indexes)
end
   
# 3.  Написать функцию, осуществляющую разложение заданное целое число на степени его простых делителей.

function factorize(n::IntType) where IntType <: Integer
    list = NamedTuple{(:div, :deg), Tuple{IntType, IntType}}[]
    for p in eratosphenes_sieve(Int(ceil(n/2)))
        k = degree(n, p) # кратность делителя
        if k > 0
            push!(list, (div=p, deg=k))
        end
    end
    return list
end

function degree(n, p) # кратность делителя `p` числа `n`
    k=0
    n, r = divrem(n,p)
    while n > 0 && r == 0
        k += 1
        n, r = divrem(n,p)
    end
    return k
end
   
# 4. Реализлвать функцию, осуществляющую вычисление сренего квадратического отклонения (от среднего значения) заданного числового массива за один проход этого массива.

function meanstd(aaa)
    T = eltype(aaa)
    n = 0; s¹ = zero(T); s² = zero(T)
    for a ∈ aaa
        n += 1; s¹ .+= a; s² += a*a
    end
    mean = s¹ ./ n
    return mean, sqrt(s²/n - mean*mean)
   end