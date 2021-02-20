import JSON.print
using NetCDF

# Function to read user-definied JSON file with meta-data information and apply to existing file
function ncmeta_add!(filename_ncfile::String, filename_json::String) 
    return nothing
end
# Function to define JSON template with necessary meta-date fields for both global and variable attributes
# This function assumes that a netcdf file exists already, but has no or missing meta data
function ncmeta_template(filename_template::String, filename_ncfile::String="")
   
    # Define the  minimum global attribute dict
    tempglobal = Dict("comment" => "", 
                          "conventions" => "", 
                          "history" => "", 
                          "institution" => "", 
                          "references" => "", 
                          "source" => "", 
                          "title" => ""
                          )
    open(filename_template,"w") do fio
        print(fio, tempglobal, 4)
    end
    return nothing
end

# Function to check the user-defined JSON file for CF conformance (min requirements?)
function ncmeta_cfcheck(filename :: String)
    return nothing
end

# Function to define the minimum set of global attributes as a dict
function globaltemplate()
   
    # Define the minimum global attribute dict
    globaldict = Dict("comment" => "", 
                      "conventions" => "", 
                      "history" => "", 
                      "institution" => "", 
                      "references" => "", 
                      "source" => "", 
                      "title" => ""
                    )
    return globaldict
end