-- This is toons/tim.lua
return {
    name = "Tim",
    level = 3,
    HP_Max = 12,
    HP_Current = 12,
    AC = 15,
    attacks = {
        {description = "Slash", toHit = "+5", damage = "1d6+3"},
        {description = "Thrust", toHit = "+4", damage = "1d8+2"},
        {description = "Bash", toHit = "+6", damage = "1d4+1"}
    },
    movement = "30 feet",
    actions = {"Dodge", "Parry"},
    attributes = {
        Strength = 14,
        Intelligence = 12,
        Wisdom = 10
    }
}
