import JSON.print
import JSON.Parser.parse
using NetCDF
using NCDatasets
using DataStructures

indent = 4 # figure out how to read user defined indent

"""
    ncmeta_addvarattr(filename_ncfile::String, filename_json::String)

Read user-definied JSON file with defined global meta-data information and apply to existing netcdf file
"""
function ncmeta_addvarattr(var :: String, filename_ncfile::String, filename_json::String) 
    
    # Open the JSON file and get the global attributes
    fio = open(filename_json,"r")
    varattrinput = parse(fio,dicttype=OrderedDict)
    close(fio)

    # Read the netcdf files and update the global data
    ncds = NCDataset(filename_ncfile,"a")
    for (attrname,attrdesc) in varattrinput
        ncds[var].attrib[attrname] = attrdesc
    end
    close(ncds)
    return nothing
end

"""
    ncmeta_addglobalattr(filename_ncfile::String, filename_json::String)

Read user-definied JSON file with defined global meta-data information and apply to existing netcdf file
"""
function ncmeta_addglobalattr(filename_ncfile::String, filename_json::String) 
    
    # Open the JSON file and get the global attributes
    fio = open(filename_json,"r")
    globalinput = parse(fio,dicttype=OrderedDict)
    close(fio)

    # Read the netcdf files and update the global data
    ncds = NCDataset(filename_ncfile,"a")
    for (attrname,attrdesc) in globalinput
        ncds.attrib[attrname] = attrdesc
    end
    close(ncds)
    return nothing
end

"""
    ncmeta_globaltemplate(filename_template::String, filename_ncfile::String="")

Define a JSON template file with necessary meta-date fields for global attributes.  If `filename_ncfile` is provided, grab the global attributes already included and add any missing default global attributes.
"""
function ncmeta_globaltemplate(filename_template::String, filename_ncfile::String="")
   
    # If a netcdf file is given, read the attribute meta-data into an OrderedDict
    if filename_ncfile != ""
        ncds = NCDataset(filename_ncfile)
        glbattr = OrderedDict(ncds.attrib)
        tempglobal = merge(globaltemplate(),glbattr) # Merge with the import holding priority
    else
        tempglobal = globaltemplate()
    end
    close(ncds)
    # TO DO: Get the variable attribute metadata and merge with global

    # Write the template to a file
    open(filename_template,"w") do fio
        print(fio, tempglobal, indent)
    end
    return nothing
end

"""
    ncmeta_vartemplate(filename_template::String, filename_ncfile::String="")

Define a JSON template file with necessary meta-date fields for global attributes.  If `filename_ncfile` is provided, grab the global attributes already included and add any missing default global attributes.
"""
function ncmeta_vartemplate(filename_template::String)

    # Write the template to a file
    open(filename_template,"w") do fio
        print(fio, vartemplate(), indent)
    end
    return nothing
end

"""
    ncmeta_cfcheck(filename :: String)

Check the user-defined JSON file for CF conformance (min requirements?)
"""
function ncmeta_cfcheck(filename :: String)
    return nothing
end

"""
    ncmeta_checkvar(filename :: String)

Check that the user-defined variables have attributes
"""

function ncmeta_checkvar(filename :: String)

    # Check that the file has variablesd
    ncds = NCDataset(filename)
    if isempty(keys(ncds))
        error("The dataset in ", filename, "does not contain any variables")
    end

    # Report which keys if any have variables
    for (varname,var) in ncds
        println("Checking ", varname)

        # Check if variable has any attributes
        if isempty(var.attrib)
            println(varname," is missing attribute data")
        end

        # TO DO: cross reference against standard variable metadata?
 
    end
    return nothing
    
end

"""
    globaltemplate()

Function that defines the minimum set of global attributes as a dict
"""
function globaltemplate()
   
    # Define the minimum global attribute dict
    globaldict = OrderedDict("comment" => "", 
                             "conventions" => "", 
                             "history" => "", 
                             "institution" => "", 
                             "references" => "", 
                             "source" => "", 
                             "title" => ""
                             )
    return globaldict
end

"""
    vartemplate()

Function that defines the minimum set of var attributes as a dict
"""
function vartemplate()
   
    # Define the minimum variable attribute dict
    vardict = OrderedDict("units" => "", 
                   "long_name" => "", 
                   "mode" => ""
                  )
    return vardict
end