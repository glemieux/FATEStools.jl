using FATEStools
using Documenter

DocMeta.setdocmeta!(FATEStools, :DocTestSetup, :(using FATEStools); recursive=true)

makedocs(;
    modules=[FATEStools],
    authors="Gregory Lemieux, Lawrence Berkeley National Laboratory",
    repo="https://github.com/glemieux/FATEStools.jl/blob/{commit}{path}#{line}",
    sitename="FATEStools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://glemieux.github.io/FATEStools.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/glemieux/FATEStools.jl",
    devbranch="main",
)
