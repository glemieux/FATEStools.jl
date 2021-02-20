using FATEStools
using Test

@testset "FATEStools.jl" begin
    
    # Test meta-data add function
    fn_nc = "testfile.nc"
    fn_meta = "testmeta_src.json"
    fn_temp = "testmeta_temp.json"
    ncmeta_add!(fn_nc,fn_meta) # what should this return?

    # Test function to define JSON template with necessary meta-date fields for both global and variable attributes
    ncmeta_template(fn_temp)

    # Test function to check the user-defined JSON file for CF conformance (min requirements?)
    ncmeta_cfcheck(fn_nc) # need to define return states

end
