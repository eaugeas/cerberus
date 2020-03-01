local _M = {}

function _M.verify(ngx, expected)
  local pass = ngx.req.get_headers()['X-PASSWORD-AUTH']
  if pass == nil then
    return false
  end

  return expected == pass
end

function _M.authenticate(ngx, expected)
  local ok = _M.verify(ngx, expected)
  if not ok then
    ngx.header.content_type = "text/plain"
    ngx.status = 403
    ngx.say("Forbidden")
    return ngx.exit(403)
  end
end

return _M
