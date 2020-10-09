local fonts = {
    verdana = renderer.setup_font('c:/windows/fonts/verdana.ttf', 12, 0)
}

local notifier = {
    messages = {},

    colors = {
        bar = color_t.new(0, 153, 255, 0),
        background = color_t.new(25, 25, 25, 0),
        font = color_t.new(230, 230, 230, 0)
    }
}

function register_message(text, colors)
    print("[EVENTLOG] " .. text .. "\n")

    if colors ~= nil then
        colors.bar = colors.bar or notifier.colors.bar
        colors.background = colors.background or notifier.colors.background
        colors.font = colors.font or notifier.colors.font
    end

    table.insert(notifier.messages, {
        text = text,
        alpha = 0,
        creation_time = globalvars.get_real_time(),
        colors = colors or notifier.colors
    })
end

function to_rgba(params)
    return params[1], params[2], params[3], params[4]
end

function render_rect(x, y, w, h, color)
    renderer.rect_filled(vec2_t.new(x,y), vec2_t.new(x+w,y+h), color_t.new(to_rgba(color)))
end

function render_text(x, y, text, color)
    renderer.text(tostring(text), fonts.verdana, vec2_t.new(x,y), 12, color_t.new(to_rgba(color)))
end

function listener()
    local dist_to_add = 0
    local last_render_pos = 10

    for i = 1, #notifier.messages do
        local message = notifier.messages[i]

        if message == nil then
            goto skip
        end

        local current_time = globalvars.get_real_time();

        if message.creation_time > current_time or message.alpha <= 0 and current_time - message.creation_time > 2 then
            table.remove(notifier.messages, i)

            goto skip
        end
        
        if i >= 15 then
            message.creation_time = current_time
        end

        if message.alpha < 255 and current_time - message.creation_time < 5 and i < 15 then
            message.alpha = message.alpha + 5
        end

        if current_time - message.creation_time > 5 and message.alpha > 0 then
            message.alpha = message.alpha - 5
        end

        if message.alpha < 0 then
            goto skip
        end
        
        local text_size = renderer.get_text_size(fonts.verdana, 14, message.text)
        local dist_modifier = message.alpha / 255
        local colors = message.colors

        render_rect(0, (last_render_pos + dist_to_add) - 10, 5 + text_size.x, text_size.y * dist_modifier + 10, { colors.background.r, colors.background.b, colors.background.b, message.alpha })
        render_rect(0, last_render_pos + dist_to_add - 10, 2, text_size.y * dist_modifier + 10, { colors.bar.r, colors.bar.g, colors.bar.b, message.alpha })
        render_text(10, last_render_pos + dist_to_add - 5, tostring(message.text), { colors.font.r, colors.font.g, colors.font.b, message.alpha })

        last_render_pos = last_render_pos + dist_to_add
        dist_to_add = (text_size.y + 10) * dist_modifier

        ::skip::
    end
end

notifier.add = register_message
notifier.listener = listener

notifier.add('Library loaded successfully');

return notifier