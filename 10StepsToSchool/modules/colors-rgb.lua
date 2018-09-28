-- colors-rgb.lua for 10StepsToSchool
-- (c) 2018, Jericho Crosby <jericho.crosby227@gmail.com>
colorsRGB = {
    blue = {50 / 255, 180 / 255, 255 / 255},
    white = {255, 255, 255},
    green = {10 / 255, 110 / 255, 0 / 255}
}

colorsRGB.RGB = function (name)
    return colorsRGB[name][1], colorsRGB[name][2], colorsRGB[name][3]
end
