local passauth = require 'oasis/auth/passauth'
local l = require 'test/luaunit'

local Nginx = {
  say_value = nil,
  status = nil,
  exit_value = nil,
  header = {},
  reqheaders = {},
  req = nil,
}

function Nginx:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o.req = {
    get_headers = function()
        return o.reqheaders
    end,
  }

  o.say = function(s)
    o.say_value = s
  end
  o.exit = function(s)
    o.exit_value = s
  end
  return o
end

TestAuthPass = {}

function TestAuthPass:call_verify(value, expected, result)
  local ngx = Nginx:new()
  ngx.req.get_headers()["X-PASSWORD-AUTH"] = value

  local ok = passauth.verify(ngx, expected)

  l.assertEquals(ok, result)
end

function TestAuthPass:test_verify_ok()
  TestAuthPass:call_verify("password", "password", true)
end

function TestAuthPass:test_verify_err_diff_password()
  TestAuthPass:call_verify("other", "password", false)
end

function TestAuthPass:test_verify_err_nil_password()
  TestAuthPass:call_verify(nil, "password", false)
end

function TestAuthPass:test_authenticate_ok()
  local ngx = Nginx:new()
  ngx.req.get_headers()["X-PASSWORD-AUTH"] = "password"

  local ok = passauth.verify(ngx, "password")
  l.assertTrue(ok)
  l.assertEquals(ngx.say_value, nil)
  l.assertEquals(ngx.status_value, nil)
  l.assertEquals(ngx.exit_value, nil)
end

function TestAuthPass:test_authenticate_err()
  local ngx = Nginx:new()
  ngx.req.get_headers()["X-PASSWORD-AUTH"] = "password"

  passauth.authenticate(ngx, "other")
  l.assertEquals(ngx.say_value, "Forbidden")
  l.assertEquals(ngx.status, 403)
  l.assertEquals(ngx.exit_value, 403)
end

os.exit(l.LuaUnit.run())
