include("manchester.jl")

# String (UTF-8) to Binary: Hello, World!
test_string = "01001000011001010110110001101100011011110010110000100000010101110110111101110010011011000110010000100001"

# The argument "invert" is optional and specifies if you
# wan't some other encoding method. Remember the method when
# you are decoding the data, or else you will get the wrong
# data back
encoded = encode(test_string, "invert")
println(encoded)

# Here is the decoded data
decoded = decode(encoded.data, encoded.method)
println(decoded)
println(test_string)
