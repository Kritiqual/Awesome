user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty",
    floating_terminal = "kitty",
    browser = "google-chrome-stable",
    consolefm = "kitty --class files -e ranger",
    visualfm = "thunar",
    editor = os.getenv("EDITOR") or "code",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",
    -- >> Web Search <<
    -- web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    web_search_cmd = "xdg-open https://www.google.com/search?q=",
    -- >> User profile <<
    profile_picture = os.getenv("HOME") .. "/.config/awesome/profile.png",
    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "$HOME/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "$HOME/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "$HOME/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "$HOME/Pictures",
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "$HOME/Pictures/Screenshots",
    },
    -- >> Sidebar <<
    ctrldock = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },
    -- >> Battery <<
    battery_threshold_low = 20,
    battery_threshold_critical = 5,
    -- >> Weather <<
    openweathermap_key = "",
    openweathermap_city_id = "",
    weather_units = "metric",
    -- -- >> Coronavirus <<
    -- coronavirus_country = "germany"
}
