include("manchester.jl")

# String (UTF-8) to Binary: Hello, World!
test_string = "01001000011001010110110001101100011011110010110000100000010101110110111101110010011011000110010000100001"
println("\nGround truth:\n$test_string")

# The argument "method" is optional and specifies if you
# wan't some other encoding method, and in this case "invert".
# Remember the method when you are decoding the data, or else
# you will get the wrong data back

method = "invert"
println("\nEncoding method:\n$method")
encoded = encode(test_string, method)
println("\nEncoded data:\n$(encoded.data)")

# Here is the decoded data
decoded = decode(string(encoded.data, "11"), encoded.method)
println("\nDecoded data:\n$(decoded.data)")

# For reference
println("\nGround truth (again for reference):\n$test_string")
