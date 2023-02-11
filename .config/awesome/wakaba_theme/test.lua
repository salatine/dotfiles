local theme = {}

local function read_file(path)
    local file = io.open(path, "r") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read("l")
    return content
end

local script_path = "/home/auau/.config/awesome/wakaba_theme/"
os.execute(script_path .. "random.sh")
local result = read_file(script_path .. "random.txt")
local random_wallpaper = ('\n'..result):gsub("\n<Table [^\n]*", ""):sub(2)
theme.wallpaper = random_wallpaper
