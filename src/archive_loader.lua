return function(create_api,patch,build)
    if rawget(_G,'ShallowWaterDive') then return end
    local state={revision=build.revision,active=false,observed=0,protected=0,
        restored=0,startup_clears=0,short_ends=0}
    rawset(_G,'ShallowWaterDive',state)
    local function report(status,active)
        state.active=active
        local counts=table.concat({state.observed,state.protected,state.restored,state.startup_clears,state.short_ends},',')
        if state.status==status and state.counts==counts then return end
        state.status=status;state.counts=counts
        print('[ShallowWaterDiving] '..build.revision..': '..status)
        pcall(function()
            local logger=rawget(_G,'CowboyBingusModLoader')
            local file=logger and logger.open_log and logger.open_log('ShallowWaterDiving.log');if not file then return end
            file:write(build.revision..'\n'..status..'\n')
            for _,key in ipairs({'observed','protected','restored','startup_clears','short_ends'}) do
                file:write(key..'='..state[key]..'\n')
            end
            file:close()
        end)
    end
    local ok,api,game,exe=pcall(function()
        local loader=rawget(_G,'CowboyBingusModLoader')
        assert(type(loader)=='table' and type(loader.api)=='number' and loader.api>=1
            and type(loader.version)=='number' and loader.version>=6,
            'Bingus Shared Loader loader-v5 or newer / API 1 or newer is required')
        local adapter=create_api()
        local g,e=adapter.module('game.dll'),adapter.module(nil)
        assert(g and e,'Required modules unavailable')
        assert(adapter.module_hash(g)==build.game_sha256,'Unsupported game module')
        assert(adapter.module_hash(e)==build.exe_sha256,'Unsupported executable')
        assert(type(update)=='function','Game update unavailable')
        return adapter,g,e
    end)
    if not ok then report(tostring(api),false);return end
    local previous,previous_shutdown,stopped=update,shutdown,false
    local function cleanup()
        local called,restored=pcall(patch.restore,api,state.pending)
        if called and restored then state.pending=nil;return true end
        return false
    end
    local function check()
        if stopped then return end
        local called,accepted,reason,active=pcall(patch.apply,api,game,exe,state)
        if not called or not accepted then
            stopped=true
            local restored=cleanup()
            report(tostring(called and reason or accepted)..(restored and '' or '; restore_failed'),false)
            return
        end
        report(reason,active==true)
    end
    local function after(called,...)
        if not called then
            stopped=true
            report(cleanup() and 'stopped_after_update_error' or 'restore_failed',false)
            error((...),0)
        end
        check();return ...
    end
    update=function(...) check();return after(pcall(previous,...)) end
    shutdown=function(...)
        stopped=true
        report(cleanup() and 'stopped' or 'restore_failed',false)
        if previous_shutdown then return previous_shutdown(...) end
    end
    report('waiting_for_mission',false)
end
