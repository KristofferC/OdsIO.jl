using PyCall

# Change that to whatever packages you need.
const PACKAGES = ["ezodf", "lxml"]

# Import pip
try
    @pyimport pip
catch
    # If it is not found, install it
    get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
    download("https://bootstrap.pypa.io/get-pip.py", get_pip)
    run(`$(PyCall.python) $get_pip --user`)
end

@pyimport pip
args = UTF8String[]
if haskey(ENV, "http_proxy")
    push!(args, "--proxy")
    push!(args, ENV["http_proxy"])
end
push!(args, "install")
push!(args, "--user")
append!(args, PACKAGES)

pip.main(args)
