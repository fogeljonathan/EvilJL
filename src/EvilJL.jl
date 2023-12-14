module EvilJL

"""
refactorComments(data)

    This function takes read data and removes all single line comments, turning them all into multiline comments. Now that I think about it, this actually isn't that evil!

    All data is saved in the process, characters are simply added to encapsulate any comment into a multiline format.
"""
function refactorComments(data::String)
    i = 1
    while i <length(data)-1
        if data[i] == '#' && data[i+1] != '=' && data[max(1,i-1)] != '='
            data = data[begin:i]*"="*data[i+1:end]
            i+=1
            j = i
            while j < length(data)
                if data[j] in ['\n','\r']
                    data = data[begin:j-1]*"=#"*data[j:end]
                    break
                end
                j+=1
            end
            i+=1
        else 
            i+=1
        end
    end
    return data
end
export refactorComments

"""
activateWideMode(filename; destructive=false)

    This function removes all line breaks from a given file, resulting in a single, very long line of code.

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
    
    data = refactorComments(data)
    data = replace(data, "\r"=>";")
    data = replace(data, "\n"=>";")

    touch(newfilename)
    file = open(newfilename,"w")
    write(newfilename,data)
    close(file)

end
export activateWidemode

end # module EvilJL
