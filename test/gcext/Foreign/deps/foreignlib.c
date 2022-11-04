// This file is a part of Julia. License is MIT: https://julialang.org/license

#include "julia.h"
#include "julia_gcext.h"

int nmarks = 0;
int nsweeps = 0;

uintptr_t mark(jl_ptls_t ptls, jl_value_t *p)
{
    nmarks += 1;
    return 0;
}

void sweep(jl_value_t *p)
{
    nsweeps++;
}

void init_dt_gc(jl_datatype_t *dt)
{
    jl_reinit_foreign_type(dt, mark, sweep);
    nmarks = nsweeps = 0;
}

int nmark_counter()
{
    return nmarks;
}

int nsweep_counter()
{
    return nsweeps;
}
