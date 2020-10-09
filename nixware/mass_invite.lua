ui.add_checkbox('force refresh', 'lobby_refresh', false)
ui.add_checkbox('auto refresh', 'lobby_auto_refresh', false)
ui.add_checkbox('mass invite', 'lobby_mass_invite', false)

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

client.register_callback('paint_d3d', function ()
    if ui.get_bool('lobby_refresh') then
        ui.set_bool('lobby_refresh', false)

        refresh_nearbies()
    end

    if ui.get_bool('lobby_mass_invite') then
        ui.set_bool('lobby_mass_invite', false)

        js.eval([[
            collectedSteamIDS.forEach(xuid => {
                FriendsListAPI.ActionInviteFriend(xuid, "");
            });
        ]])
    end

    if ui.get_bool('lobby_auto_refresh') then
        timer.listener()
    end
end)