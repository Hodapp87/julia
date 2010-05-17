struct Rational{T} <: Real
    num::Int{T}
    den::Int{T}
end

convert{T}(::Type{Rational{T}}, x::T) = Rational(x, convert(T,1))
convert{T}(::Type{Rational{T}}, x::Int) = Rational(convert(T,x), convert(T,1))
convert{T}(::Type{Rational{T}}, x::Rational) = Rational(convert(T,x.num),convert(T,x.den))
convert{T}(::Type{Float{T}}, x::Rational) = convert(T,x.num)/convert(T,x.den)

promote_table{T}(::Type{Rational{T}}, ::Type{Int{T}}) = Rational{T}
promote_table{T,S}(::Type{Rational{T}}, ::Type{Int{S}}) = Rational{promote_type(T,S)}
promote_table{T,S}(::Type{Rational{T}}, ::Type{Rational{S}}) = Rational{promote_type(T,S)}
promote_table{T,S}(::Type{Rational{T}}, ::Type{Float{S}}) = promote_type(T,S)

function //{T}(num::T, den::T)
    if den == 0
        error("demoinator cannot be zero")
    end
    g = gcd(num, den)
    num = div(num, g)
    den = div(den, g)
    num = sign(den) * num
    den = sign(den) * den
    Rational(num, den)
end

//(num, den) = //(promote(num, den)...)
//{T}(x::Rational{T}, y::T) = x.num // (x.den*y)
//{T}(x::T, y::Rational{T}) = (x*y.den) // y.num

function print(x::Rational)
    print(num(x))
    print("//")
    print(den(x))
end

num(x::Rational) = x.num
den(x::Rational) = x.den
sign(x::Rational) = sign(x.num)*sign(x.den)

(-)(x::Rational) = (-x.num) // x.den
(+)(x::Rational, y::Rational) = (x.num*y.den + x.den*y.num) // (x.den*y.den)
(-)(x::Rational, y::Rational) = (x.num*y.den - x.den*y.num) // (x.den*y.den)
(*)(x::Rational, y::Rational) = (x.num*y.num) // (x.den*y.den)
(/)(x::Rational, y::Rational) = (x.num*y.den) // (x.den*y.num)
==(x::Rational, y::Rational)  = (x.num == y.num && x.den == y.den)
