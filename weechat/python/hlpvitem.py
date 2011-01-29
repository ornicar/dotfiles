# -*- coding: utf-8 -*-
#
# Copyright (c) 2009 by FlashCode <flashcode@flashtux.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#
# Item with highlight/private messages.
#
# After loading this script, you can add item "hlpv" to your status
# bar with command:
#   /set weechat.bar.status.items [+tab]
#   then complete string by adding for example (without quotes): ",[hlpv]"
#
# History:
#
# 2009-10-02, FlashCode <flashcode@flashtux.org>:
#     version 0.1: initial release
#

SCRIPT_NAME    = "hlpvitem"
SCRIPT_AUTHOR  = "FlashCode <flashcode@flashtux.org>"
SCRIPT_VERSION = "0.1"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "Item with highlight/private messages"

import_ok = True

try:
    import weechat
except:
    print "This script must be run under WeeChat."
    print "Get WeeChat now at: http://www.weechat.org/"
    import_ok = False

# script options
hlpv_settings = {
    "show_all_buffers"      : "off",      # off = hidden buffers only
    "buffer_number"         : "on",       # display buffer number before name
    "buffer_short_name"     : "on",       # use buffer short name (if off, use full name)
    "highlight"             : "on",       # display highlights in item
    "private"               : "on",       # display privates in item
    "string_highlight"      : "",         # string displayed for highlight message (before buffer)
    "string_private"        : "",         # string displayed for private message (before buffer)
    "string_delimiter"      : " > ",      # delimiter between prefix and message
    "color_string_highlight": "",         # color for string_highlight (by default == weechat.color.status_data_highlight)
    "color_string_private"  : "",         # color for string_private (by default == weechat.color.status_data_private)
    "color_buffer_number"   : "",         # color for buffer number (by default == weechat.color.status_highlight/private)
    "color_buffer_name"     : "default",  # color for buffer name
    "color_prefix"          : "white",    # color for prefix
    "color_delimiter"       : "cyan",     # color for delimiter
    "color_message"         : "default",  # color for message
    "visible_seconds"       : "7",        # amount of seconds each message is visible
}

hlpv_messages = []

def hlpv_timer():
    weechat.hook_timer(int(weechat.config_get_plugin("visible_seconds")) * 1000, 0, 1, "hlpv_timer_cb", "")

def hlpv_timer_cb(data, remaining_calls):
    """ Called when a message must be removed from list. """
    global hlpv_messages
    
    if len(hlpv_messages):
        hlpv_messages.pop(0)
        weechat.bar_item_update("hlpv")
        if len(hlpv_messages) > 0:
            hlpv_timer()
    return weechat.WEECHAT_RC_OK

def hlpv_item_add(buffer, highlight, prefix, message):
    """ Add message to list of messages (will be displayed by item). """
    global hlpv_messages
    
    if highlight == "1":
        color_type = weechat.config_string(weechat.config_get("weechat.color.status_data_highlight"))
        color_string_highlight = weechat.config_get_plugin("color_string_highlight")
        if color_string_highlight == "":
            color_string_highlight = color_type
        string_prefix = "%s%s" % (weechat.color(color_string_highlight),
                                  weechat.config_get_plugin("string_highlight"))
    else:
        color_type = weechat.config_string(weechat.config_get("weechat.color.status_data_private"))
        color_string_private = weechat.config_get_plugin("color_string_private")
        if color_string_private == "":
            color_string_private = color_type
        string_prefix = "%s%s" % (weechat.color(color_string_private),
                                  weechat.config_get_plugin("string_private"))
    color_delimiter = weechat.color(weechat.config_get_plugin("color_delimiter"))
    if weechat.config_get_plugin("buffer_number") == "on":
        color_buffer_number = weechat.config_get_plugin("color_buffer_number")
        if color_buffer_number == "":
            color_buffer_number = color_type
        buffer_number = "%s%s%s:" % (weechat.color(color_buffer_number),
                                     weechat.buffer_get_integer(buffer, "number"),
                                     color_delimiter)
    else:
        buffer_number = ""
    color_buffer_name = weechat.color(weechat.config_get_plugin("color_buffer_name"))
    if weechat.config_get_plugin("buffer_short_name") == "on":
        buffer_name = weechat.buffer_get_string(buffer, "short_name")
    else:
        buffer_name = weechat.buffer_get_string(buffer, "name")
    color_prefix = weechat.color(weechat.config_get_plugin("color_prefix"))
    string_delimiter = weechat.config_get_plugin("string_delimiter")
    color_message = weechat.color(weechat.config_get_plugin("color_message"))
    string = "%s%s%s%s: %s%s%s%s%s%s" % (string_prefix, buffer_number,
                                         color_buffer_name, buffer_name,
                                         color_prefix, prefix,
                                         color_delimiter, string_delimiter,
                                         color_message, message)
    if len(hlpv_messages) == 0:
        hlpv_timer()
    hlpv_messages.append(string)
    weechat.bar_item_update("hlpv")

def hlpv_print_cb(data, buffer, date, tags, displayed, highlight, prefix, message):
    """ Called when a message is printed. """
    tagslist = tags.split(",")
    show_all_buffers = weechat.config_get_plugin("show_all_buffers")
    num_displayed = weechat.buffer_get_integer(buffer, "num_displayed")
    if num_displayed == 0 or show_all_buffers == "on":
        highlight_enabled = weechat.config_get_plugin("highlight")
        private_enabled = weechat.config_get_plugin("private")
        if ((highlight == "1") and (highlight_enabled == "on")) or (("notify_private" in tagslist) and (private_enabled == "on")):
            hlpv_item_add(buffer, highlight, prefix, message)
    return weechat.WEECHAT_RC_OK

def hlpv_item_cb(data, buffer, args):
    """ Callback for building hlpv item. """
    global hlpv_messages
    
    if len(hlpv_messages) > 0:
        return hlpv_messages[0]
    return ""

if __name__ == "__main__" and import_ok:
    if weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                        SCRIPT_LICENSE, SCRIPT_DESC,
                        "", ""):
        # set default settings
        for option, default_value in hlpv_settings.iteritems():
            if not weechat.config_is_set_plugin(option):
                weechat.config_set_plugin(option, default_value)
        # new item
        weechat.bar_item_new('hlpv', 'hlpv_item_cb', '')
        # hook all printed messages
        weechat.hook_print("", "", "", 1, "hlpv_print_cb", "")
