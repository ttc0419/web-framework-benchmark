request = function ()
    local indexFile = io.open("parameters/index", "r+")
    local index = indexFile:read("*number")
    indexFile:close()

    local queryFile = io.open("parameters/" .. index, "r")
    path = "/record/index.php" .. queryFile:read("*all")
    queryFile:close()

    index = (index + 1) % 4096
    indexFile = io.open("parameters/index","w")
    indexFile:write(index);
    indexFile:close()

    return wrk.format("GET", path)
end
