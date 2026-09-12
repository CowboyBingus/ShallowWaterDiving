local source=assert(arg[1])
local function test(kind)
    local env=setmetatable({print=function()end,os={getenv=function()end}},{__index=_G});env._G=env
    env.CowboyBingusModLoader={api=1,version=kind=='old_loader' and 5 or 6}
    local calls,restores=0,0
    env.update=function(...)
        if kind=='update_error' then error('original update error') end
        return 1,nil,3
    end
    env.shutdown=function(...)return 4,nil,6 end
    local original=env.update
    local api={module=function(n)return n and 1 or 2 end,module_hash=function(n)return n==1 and 'game' or 'exe' end}
    local patch={apply=function(a,g,e,state)
        assert(a==api and g==1 and e==2);calls=calls+1;state.pending={}
        if kind=='patch_error' then error('patch error') end
        if kind=='patch_failure' then return false,'failed',false end
        if kind=='initializing' and calls<=4 then state.pending=nil;return true,'waiting_for_mission_global_276c3d0',false end
        return true,'ready',true
    end,restore=function(a,p)restores=restores+1;return true end}
    local install=setfenv(assert(loadfile(source..'/archive_loader.lua')),env)()
    install(function()return api end,patch,{revision='test',game_sha256='game',exe_sha256='exe'})
    if kind=='old_loader' then assert(env.update==original and calls==0);return end
    local update=env.update
    install(function()error('duplicate load')end,patch,{})
    assert(env.update==update)
    if kind=='update_error' then assert(not pcall(env.update));assert(restores==1)
    else
        local a,b,c=env.update();assert(a==1 and b==nil and c==3)
        if kind=='normal' then assert(calls==2 and select('#',env.update())==3)
        elseif kind=='initializing' then
            assert(calls==2 and not env.ShallowWaterDive.active)
            env.update();assert(calls==4 and not env.ShallowWaterDive.active)
            env.update();assert(calls==6 and env.ShallowWaterDive.active)
        else assert(calls==1 and restores==1);env.update();assert(calls==1) end
    end
    local a,b,c=env.shutdown();assert(a==4 and b==nil and c==6)
end
for _,kind in ipairs({'normal','initializing','old_loader','update_error','patch_error','patch_failure'}) do test(kind)end
print('PASS: loader gates, duplicate loads, callback tuples, shutdown, update exceptions and failure isolation')
