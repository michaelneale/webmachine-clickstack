#!/usr/bin/env escript

main([]) ->
    patch_setup(),
    patch_supervisor().

patch_setup() ->     
    replace("start.sh", "reloader -s", " ").

patch_supervisor() ->         
    SupFile = string:strip(os:cmd("ls src/*_sup.erl"), both, $\n),
    patch_port(SupFile),
    patch_priv_dir(SupFile).   


patch_port(SupFile) ->
    replace(SupFile, "{port, 8000}", "{port, os:getenv(\"WEBMACHINE_PORT\")}").

patch_priv_dir(SupFile) -> 
    S = "filename:join(" ++ 
        "filename:dirname(filename:dirname(code:which(App))), \"priv\")",
    replace(SupFile, "code:priv_dir(App)", S).       



replace(File, Pattern, Replace) ->
    io:format("~p~n", ["Patching file " ++ File]),
    {ok, Contents} = file:read_file(File),
    Result = binary:replace(Contents, 
                list_to_binary(Pattern), 
                list_to_binary(Replace)),    
    file:write_file(File, Result).



