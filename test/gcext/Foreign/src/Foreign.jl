# This file is a part of Julia. License is MIT: https://julialang.org/license

module Foreign

using Libdl

const foreignlib = joinpath(dirname(joinpath(@__DIR__)), "deps", "foreignlib.so")

const FObj = ccall(:jl_new_foreign_type, Any, (Symbol, Module, Any, Any, Any, Cint, Cint),
                   :FObj, Foreign, Any, C_NULL, C_NULL, 0, 0)

FObj() = ccall(:jl_new_struct_uninit, Any, (Any,), FObj)

get_nmark()  = ccall((:nmark_counter, foreignlib),  Cint, ())
get_nsweep() = ccall((:nsweep_counter, foreignlib), Cint, ())

function __init__()
    ccall((:init_dt_gc, foreignlib), Cvoid, (Any,), FObj)
end

end # module Foreign
