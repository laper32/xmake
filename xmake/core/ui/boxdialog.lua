--!A cross-platform build utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2018, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        boxdialog.lua
--

-- load modules
local log        = require("ui/log")
local rect       = require("ui/rect")
local curses     = require("ui/curses")
local window     = require("ui/window")
local textdialog = require("ui/textdialog")

-- define module
local boxdialog = boxdialog or textdialog()

-- init dialog
function boxdialog:init(name, bounds, title)

    -- init window
    textdialog.init(self, name, bounds, title)

    -- insert box
    self:panel():insert(self:box())

    -- resize text bounds
    self:text():bounds():resize(self:panel():width(), math.floor(self:panel():height() / 4))
end

-- get box
function boxdialog:box()
    if not self._BOX then
        self._BOX = window:new("boxdialog.box", rect{0, math.floor(self:panel():height() / 4), self:panel():width(), self:panel():height() - 1})
        self._BOX:border():cornerattr_set("black", "white")
    end
    return self._BOX
end

-- return module
return boxdialog
