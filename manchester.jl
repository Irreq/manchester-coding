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

    g = Dict(
    "01"=>"0",
    "10"=>"1"
    )

    value = [g[string(data[Integer(k*2)-1], data[Integer(k*2)])]  for (k) in 1:(length(data))/2]

    result = Decoded(join(value), encoding)
    return result
end


#### Test Area ####
# String (UTF-8) to Binary: Hello, World!
test = "01001000011001010110110001101100011011110010110000100000010101110110111101110010011011000110010000100001"

encoded = encode(test, "invert")
println(encoded)
decoded = decode(encoded.data, encoded.method)
println(decoded)

# function splitter(data)
#     return [string(i) for i = data]
# end
# function start(data, arg, method="basic")
#     data = splitter(data)
#
#     return join([bit_map[arg][i] for i = data])
# end
#
# println(start(test, "basic"))
#
# function Man_Decode(data)
#
# function joiner(data)
#     return [bit_map[string(i)] for i = data]
# end
#
# # arr = splitter(test)
# #
# # # println(summary(arr[end]))
# # arr = joiner(arr)
# # arr = join(arr)
# # println(arr)
