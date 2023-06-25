# 1. Генерация всех размещений с повторениями из n элеиентов {1, 2, 3, ..., n} по K

function next_repit_placement!(p::AbstractVector{T}, n::T) where T<:Integer
	i = findlast(x->(x < n), p) # используется встроенная функция высшего порядка
	# i - это последнийпервый с конца индекс: x[i] < n, или - nothing, если такого индекса нет (p == [n,n,...,n])

	isnothing(i) && (return nothing)
	p[i] += 1
	p[i+1:end] .= 1 # - устанавливаются минимально-возможные значения
	
	return p
end

n = 2; k = 5
p = ones(Int,k)
while !isnothing(p)
	println(p)
	p = next_repit_placement!(p,n)
end

function show_placements(k::T,n::T) where T<:Integer
	for i in 0:n^k-1
		digits(i; base=n, pad=k) |> println
	end
end

show_placements(3,5)

# 2. Генерация вcех перестановок 1,2,...,n

function next_permute!(p::AbstractVector)
    n = length(p)
    k = 0 # или firstindex(p)-1
    for i in reverse(1:n-1) # или reverse(firstindex(p):lastindex(p)-1)
        if p[i] < p[i+1]
            k=i
            break
        end
    end
    k == firstindex(p)-1 &&  return nothing # т.е. p[begin]>p[begin+1]>...>p[end]
 
    #УТВ: p[k] < p[k+1] > p[k+2] >...> p[end]
    i=k+1
    while i<n && p[i+1]>p[k] # i < lastindex(p) && p[i+1] > p[k]
        i += 1
    end
    #УТВ: p[i] - наименьшее из всех p[k+1:end], большее p[k]
    p[k], p[i] = p[i], p[k]
    #УТВ: по-прежнему p[k+1]>...>p[end]
    reverse!(@view p[k+1:end])
    return p
end

#Тестирование:
p=[1,2,3,4]
while !isnothing(p)
	println(p)
    p = next_permute!(p)
end


# 3. Генерация всех всех подмножеств n-элементного множества {1,2,...,n}

function next_indicator!(indicator::AbstractVector{Bool})
    i = findlast(x->(x==0), indicator)
	
    isnothing(i) && return nothing
    indicator[i] = 1
    indicator[i+1:end] .= 0

    return indicator 
end

n=5; A=1:n
indicator = zeros(Bool, n)
while !isnothing(indicator)
	println(indicator)

    A[findall(indicator)] |> println
    indicator = next_indicator!(indicator)
end

# 4. Генерация всех k-элементных подмножеств n-элементного множества {1, 2, ..., n}

function next_indicator!(indicator::AbstractVector{Bool}, k)
    # в indicator - ровно k единц, остальные - нули, но это не проверяется! (фактически k - не используется)
    i=lastindex(indicator)
    while indicator[i]==0
        i-=1
    end
    #УТВ: indic[i]==1 и все справа - нули
    m=0; 
    while i >= firstindex(indicator) && indicator[i]==1 
        m+=1
        i-=1
    end
    if i < firstindex(indicator)
        return nothing
    end
    #УТВ: indicator[i]==0 и справа m>0 единиц, причем indicator[i+1]==1
    indicator[i]=1
    indicator[i+1:i+m-1] .= 0
    indicator[i+m:end] .= 1
    return indicator 
end

n=6; k=3; A=1:n
indicator = [zeros(Bool,n-k); ones(Bool,k)]
while !isnothing(indicator)
	A[findall(indicator)] |> println
    indicator = next_indicator!(indicator, k)
end

# 5. Генерация всех разбиений натурального числа на положительные слагаемые. Должно быть length(s) == n, где n - заданное число
		#s[i-1]>=s[i] for all i in (2,3,...,k), где k - число элементов заданного разбиения, представленного вектором s, т.е. число ненулевых элементов в начале вектора s.

function next_split!(s::AbstractVector{T}, k) where T <: Integer
    k == 1 && return nothing, k
    i = k-1 # - это потому что s[k] увеличивать нельзя
    while i > 1 && s[i-1]==s[i]
        i -= 1
    end
    #УТВ: i == 1 или i - это наименьший индекс: s[i-1] > s[i] и i < k
    s[i] += 1
    #Теперь требуется s[i+1]... - уменьшить минимально-возможным способом (в лексикографическом смысле) 
    r = sum(@view(s[i+1:k]))
    k = i+r-1 # - это с учетом s[i] += 1
    s[i+1:n-k] .= 1
	#println("k = ",k)
    return s, k
end

# Тестирование:
n=5; s=ones(Int, n); k=n
while !isnothing(s)
	println(s[1:k])
	s, k = next_split!(s, k)
end