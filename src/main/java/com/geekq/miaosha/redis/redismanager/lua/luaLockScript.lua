---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by qiurunze.
--- DateTime: 2018/12/22 18:20
---
--- 释放锁
if redis.call('get',KEY[1] == ARGV[1]) then
    return redis.call('del',KEY[1])
else
    return 0
end

--- 加锁
local key  = KEY[1]
local content = KEY[2]
local ttl = AVG[1]
local lockSet = redis.call('setnx',key,content)
if lockSet==1 then
    redis.call('pexpire',key,ttl)
else
    local value = redis.call('get',key)
    if value==content then
        lockSet=1
        redis.call('pexpire',key,ttl)
    end
end
return lockSet