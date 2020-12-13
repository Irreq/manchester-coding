# Manchester Code

# Author : Irreq

struct Manchester
    main::String
    bit_map::Dict
end

options = Manchester(
"normal",

# bit map for functions
Dict(
    "normal"=>Dict(
    "0"=>"01",
    "1"=>"10"
    ),

    "invert"=>Dict(
    "0"=>"10",
    "1"=>"01"
    ),

    "differential"=>Dict(
    "0"=>"01"

    ),
    "decode"=>Dict(
    "01"=>"0",
    "10"=>"1"
    )
)
)

struct Encoded
    data::String
    method::String
end

struct Decoded
    data::String
    method::String
end


function _parser(data, n)

     return data[1:n], data[n+1:end]
end

function _findall(pattern,string::AbstractString)
    toReturn = UnitRange{Int64}[]
    s = 1
    while true

        range = findnext(pattern,string,s)
        if range == nothing
             break
        else
            push!(toReturn, range)
            s = first(range)+1
        end
    end
    return toReturn
end

function encode(data, encoding=options.main; args=nothing)

    method = options.bit_map[encoding]

    encoded = []

    while length(data) > 0

        bit, data = _parser(data, 1)

        value = method[bit]

        push!(encoded, value)

    end

    encoded = join(encoded)

    result = Encoded(encoded, encoding)

    return result
end

function decode(data, encoding=options.main; args=nothing)

    errors = Dict([i=>_findall(i, data) for (i) = ["000","111"]])

    method = options.bit_map[encoding]

    bits = []

    while length(data) > 0

        bit, data = _parser(data, 2)

        push!(bits, bit)
    end

    decoded = []

    parity = []

    for (i) = bits
        if length(i)%2!=0
            push!(parity, nothing)
            break
        end
        if i[1] == i[2]
            push!(parity, false)


        else
            push!(parity, true)

        end

    end

    for (i) = bits

        bit = ""
        if (encoding) == "invert"
            if (i) == "01"
                bit = "1"
            end
            if (i) == "10"
                bit = "0"
            end

        elseif (encoding) == "normal"
            if (i) == "01"
                bit = "0"
            end
            if (i) == "10"
                bit = "1"
            end
        else
            bit = ""
        end



        push!(decoded, bit)
    end

    decoded = join(decoded)

    result = Encoded(decoded, encoding)
end
