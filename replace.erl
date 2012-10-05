#!/usr/bin/env escript

main([File, Pattern, Replace]) ->
    {ok, Contents} = file:read_file(File),
    Result = binary:replace(Contents, 
                list_to_binary(Pattern), 
                list_to_binary(Replace)),    
    file:write_file(File, Result);                 
main(_) ->
    usage().

usage() ->
    io:format("usage: replace.erl source_file pattern replacement\n"),
    halt(1).
