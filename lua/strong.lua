function Block(el)
    if el.t == "Para" or el.t == "Plain" then
        for k, _ in ipairs(el.content) do

            if el.content[k].t == "Str" and el.content[k].text == "Manderson," and
                el.content[k + 1].t == "Space" and el.content[k + 2].t == "Str" and
                el.content[k + 2].text:find("^A.") and
                el.content[k + 3].t == "Space" and el.content[k + 4].t == "Str" and
                el.content[k + 4].text:find("^A.")
                then
                -- Original approach assumes that you only have one initial, this approach assumes you have two.
                -- The pattern should(?) generalise if you have more.
                -- Uncomment the below line to see the structure at and around the important index of el.content
                -- print(el.content[k + 1].text, el.content[k + 2].text, el.content[k + 3].text, el.content[k + 4].text)
                local _, e = el.content[k + 2].text:find("^A.")
                local rest = el.content[k + 2].text:sub(e + 1) -- empty if e+1>length
                el.content[k] = pandoc.Strong {pandoc.Str("Manderson, A. A.,")}
                el.content[k + 1] = pandoc.Str(rest)
                table.remove(el.content, k + 2) -- safe? another way would be to set element k+2 to Str("")
                table.remove(el.content, k + 3) -- We've merged the two initials, which used to be separate entries, into one entry, so we must now delete the original second initial
                -- no real need to skip ipairs items here

            end

        end
    end
    return el
end