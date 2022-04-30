--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        add_user.lua
--

-- imports
import("core.base.option")
import("core.base.base64")
import("core.base.bytes")
import("core.base.hashset")
import("private.service.service")
import("private.service.config")

function main(user)
    assert(user, "empty user name!")

    -- get user password
    cprint("Please input user ${bright}%s${clear} password:", user)
    io.flush()
    local pass = (io.read() or ""):trim()
    assert(pass ~= "", "password is empty!")

    -- compute user authorization
    local auth = base64.encode(user .. ":" .. pass)
    auth = hash.sha256(bytes(auth))

    -- save to configs
    local configs = assert(config.configs(), "configs not found!")
    configs.server = configs.server or {}
    configs.server.auths = configs.server.auths or {}
    if not hashset.from(configs.server.auths):has(auth) then
        table.insert(configs.server.auths, auth)
    else
        cprint("User ${bright}%s${clear} has been added!", user)
        return
    end
    config.save(configs)
    cprint("Add user ${bright}%s${clear} ok!", user)
end
