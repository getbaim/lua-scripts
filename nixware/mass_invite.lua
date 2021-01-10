local lobby_refresh = ui.add_check_box('force refresh', 'lobby_refresh', false)
local lobby_auto_refresh = ui.add_check_box('auto refresh', 'lobby_auto_refresh', false)
local lobby_mass_invite = ui.add_check_box('mass invite', 'lobby_mass_invite', false)

local js = require('panorama')
local timer = require('timers')

js.eval([[
    var collectedSteamIDS = []
]])

local function refresh_nearbies()
    print("Refreshing..")
    
    js.eval([[
        PartyBrowserAPI.Refresh();
        var lobbies = PartyBrowserAPI.GetResultsCount();
        for (var lobbyid = 0; lobbyid < lobbies; lobbyid++) {
            var xuid = PartyBrowserAPI.GetXuidByIndex(lobbyid);
            var name = PartyListAPI.GetFriendName(xuid)
            if (!collectedSteamIDS.includes(xuid)) {
                collectedSteamIDS.push(xuid);
                $.Msg(`Adding ${name}(${xuid}) to the collection..`);
            }
        }
        $.Msg(`Mass invite collection: ${collectedSteamIDS.length}`);
    ]])
end

refresh_nearbies()

timer.new_interval(refresh_nearbies, 5000)

client.register_callback('paint', function ()
    if lobby_refresh:get_value() then
        lobby_refresh:set_value(false)

        refresh_nearbies()
    end

    if lobby_mass_invite:get_value() then
        lobby_mass_invite:set_value(false)

        js.eval([[
            collectedSteamIDS.forEach(xuid => {
                FriendsListAPI.ActionInviteFriend(xuid, "");
            });
        ]])
    end

    if lobby_auto_refresh:get_value() then
        timer.listener()
    end
end)