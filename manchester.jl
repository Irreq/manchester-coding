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

function encode(data, encoding=options.main; args=nothing)
    value = Array
    try
        value = [options.bit_map[encoding][string(i)] for i = data]
    catch e
        println("$e is not a valid encoding method")
    end

    result = Encoded(join(value), encoding)

    return result
end



function decode(data, encoding=options.main; args=nothing)

    # Make sure encoded data is even
    if (length(data) % 2 != 0)

        return nothing
    end



    value = [options.bit_map["decode"][string(data[Integer(k*2)-1], data[Integer(k*2)])]  for (k) in 1:(length(data))/2]


    if (encoding) == "invert"
        v = []
        for (i) = value
            if (i == "1")
                push!(v, string("0") )
            end

            if (i == "0")
                push!(v, string("1" ))
            end
        end

        value = v
    end
    result = Decoded(join(value), encoding)
    return result
end
