module EvilJL
"""
    activateWideMode(filename; destructive=false)

This function removes all line breaks from a given file, resulting in a single, very long line of code. Any single line comment in the original file will result in a broken mess, so just memorize and delete any documentation.

Defaults to saving the file as a filename_wide.jl copy, but can be destructive with the optional second input.
"""
function activateWideMode(filename::String; destructive = false)

    newfilename = replace(filename, ".jl"=> "_wide.jl")
    if destructive
        newfilename = filename
    end

    file = open(filename, "r")
    data = read(file, String)
    close(file)
    
    data = replace(data, "\r"=>";")

    touch(newfilename)
    file = open(newfilename,"w")
    write(newfilename,data)
    close(file)

end
export activateWidemode

end # module EvilJL
