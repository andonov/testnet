-module(ae_http_dispatch_ext).

-export([handle_request/3]).

-spec handle_request(
        OperationID :: swagger_api:operation_id(),
        Req :: cowboy_req:req(),
        Context :: #{}
       ) -> {Status :: cowboy:http_status(), Headers :: cowboy:http_headers(), Body :: #{}}.

handle_request('GetHeader', #{blockId := BlockId}, _Context) ->
    Header = block:block_to_header(block:read_int(BlockId)),
    {200, [], #{<<"header">> => base64:encode(Header)}};

handle_request(OperationID, Req, Context) ->
    error_logger:error_msg(
      ">>> Got not implemented request to process: ~p~n",
      [{OperationID, Req, Context}]
     ),
    {501, [], #{}}.
