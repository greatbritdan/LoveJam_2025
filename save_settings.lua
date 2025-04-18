return {
    music = {default=0.2, type="number", min=0, max=1},
    sounds = {default=0.8, type="number", min=0, max=1},
    level = {default=0, type="number", min=0, max=15},
    levelsbeaten = {type="table", table={
        [1] = {default=false, type="boolean"},
        [2] = {default=false, type="boolean"},
        [3] = {default=false, type="boolean"},
        [4] = {default=false, type="boolean"},
        [5] = {default=false, type="boolean"},
        [6] = {default=false, type="boolean"},
        [7] = {default=false, type="boolean"},
        [8] = {default=false, type="boolean"},
        [9] = {default=false, type="boolean"},
        [10] = {default=false, type="boolean"},
        [11] = {default=false, type="boolean"},
        [12] = {default=false, type="boolean"},
        [13] = {default=false, type="boolean"},
        [14] = {default=false, type="boolean"},
        [15] = {default=false, type="boolean"}
    }},
    skipdialog = {default=false, type="boolean"},
    devmode = {default=false, type="boolean"},
}