# -*- coding: utf-8 -*-
# Copyright (C) 2009, 2010  Roman Zimbelmann <romanz@lavabit.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
This is the default key configuration file of ranger.
Syntax for binding keys: map(*keys, fnc)

Examples for keys: "x", "gg", "<C-J><A-4>", "<tab>", "<down><up><right>"

fnc is a function which is called with the CommandArgs object.

The CommandArgs object has these attributes:
arg.fm: the file manager instance
arg.wdg: the current widget
arg.n: the number typed before the key combination (if allowed)
arg.direction: the direction object (if applicable)
arg.keys: the string representation of the used key combination
arg.keybuffer: the keybuffer instance

Direction keys are special.  They must be mapped with: map.dir(*keys, **args)
where args is a dict of values such as up, down, to, absolute, relative...
Example: map.dir('gg', to=0)
Direction keys can be accessed in a mapping that contians "<dir>".
Other special keys are "<any>" which matches any single key and "<bg>"
which will run the function passively, without clearing the keybuffer.

Additionally, there are shortcuts for accessing methods of the current
file manager and widget instance:
map('xyz', fm.method(foo=bar))
will be translated to:
map('xyz', lamdba arg: arg.fm.method(foo=bar))
If possible, arg.n and arg.direction are automatically inserted.


Example scenario
----------------
If this keys are defined:
map("dd", "d<dir>", fm.cut(foo=bar))
map.dir("gg", to=0)

Type in the keys on the left and the function on the right will be executed:
dd        => fm.cut(foo=bar)
5dd       => fm.cut(foo=bar, narg=5)
dgg       => fm.cut(foo=bar, dirarg=Direction(to=0))
5dgg      => fm.cut(foo=bar, narg=5, dirarg=Direction(to=0))
5d3gg     => fm.cut(foo=bar, narg=5, dirarg=Direction(to=3))

Example ~/.config/ranger/keys.py
-------------------------
from ranger.api.keys import *

keymanager.map("browser", "d", fm.move(down=0.5, pages=True))

# Add less-like d/u keys to the "browser" context:
map = keymanager.get_context('browser')
map("d", fm.move(down=0.5, pages=True))
map("u", fm.move(up=0.5, pages=True))

# Add keys to all contexts
map = KeyMapWithDirections()  # create new empty keymap.
map("q", fm.exit())
map.dir("<down>", down=3)     # I'm quick, I want to move 3 at once!
keymanager.merge_all(map)     # merge the new map into all existing ones.
"""

from ranger.api.keys import *

map = vim_aliases = KeyMapWithDirections()
#map.dir('n', down='<down>')
map('n', fm.move(down=1))
map.dir('e', alias='<up>')

map('j', fm.search())
map('J', fm.search(forward=False))

map('E', fm.edit_file())

keymanager.merge_all(map)     # merge the new map into all existing ones.
