using fatestools
using Documenter

DocMeta.setdocmeta!(fatestools, :DocTestSetup, :(using fatestools); recursive=true)

makedocs(;
    modules=[fatestools],
    authors="Gregory Lemieux, Lawrence Berkeley National Laboratory",
    repo="https://github.com/glemieux/fatestools.jl/blob/{commit}{path}#{line}",
    sitename="fatestools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://glemieux.github.io/fatestools.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/glemieux/fatestools.jl",
    devbranch="main",
)
