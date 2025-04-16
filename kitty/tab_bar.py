# https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-2183440
import datetime
import json
import subprocess
from collections import defaultdict
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        draw_right_status(draw_data, screen)
    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that wont fit
    while True:
        if not cells:
            return
        padding = screen.columns - screen.cursor.x - sum(len(c) + 3 for c in cells)
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = tab_bg
            screen.draw("")
        else:
            screen.cursor.fg = default_bg
            screen.cursor.bg = tab_bg
            screen.draw("")
        screen.cursor.fg = tab_fg
        screen.cursor.bg = tab_bg
        screen.draw(f" {cell} ")


def create_cells() -> list[str]:
    now = datetime.datetime.now()
    return [
        # currently_playing(),
        # now.strftime("%d %b"),
        # now.strftime("%H:%M"),
    ]

def currently_playing():
    status = ""
    # Get the current player status
    try:
        player_status = subprocess.getoutput("playerctl status")
        if player_status == "Playing":
            status += "" # Icon or text for playing status
        elif player_status == "Paused":
            status += ""  # Icon or text for paused status
        else:
            status += "■"  # Icon or text for stopped status
    except subprocess.CalledProcessError:
        status = ""  # Default icon if there's an error

    # Get the current song title
    try:
        title = subprocess.getoutput("playerctl metadata title")
        status += f" {title}"
    except subprocess.CalledProcessError:
        pass  # Title may not be available

    # Get the current artist
    try:
        artist = subprocess.getoutput("playerctl metadata artist")
        if artist:
            status += f" - {artist}"
    except subprocess.CalledProcessError:
        pass  # Artist may not be available

    return status


def _redraw_tab_bar():
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
