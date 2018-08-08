
	--说明:当使用get方法时为查询缓存方法,当使用post方法时为更新缓存方法,为了获取post请求参数需要在location中写入: lua_need_request_body on;
	local redis = require("resty.rediscli-ft")
    local request_method = ngx.var.request_method
    local args = nil
	local red = redis.new()
	if "POST" == request_method then
		local rdskey = nil

		args=ngx.req.get_post_args()
		for key,val in pairs(args) do
                	if "key" == key then
                		rdskey = val
					end
        	end
		local res, err = red:exec(
                        function(red)
                       red:exists(rdskey)
                        end
                        )
		ngx.print(res)

	end
