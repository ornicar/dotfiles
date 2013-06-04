# -*- coding: utf-8 -*-
#
# auto_away.py : A simple auto-away script for Weechat in Python 
# Copyright (c) 2010 by Specimen <spinifer at gmail dot com>
#
# Inspired in yaaa.pl by jnbek
# A very special thanks to Nils G. for helping me out with this script
# ---------------------------------------------------------------------
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
# This script requires WeeChat 0.3.0 or newer.
# 
# ---------------------------------------------------------------------
#
# Summary:
#
#   Sets status to away automatically after a given period of 
#   inactivity. Returns from away when you start typing, but not when
#   you change buffer or scroll. This script should work with any
#   plugin and it's not IRC specific.
#
#
# Configuration:
#
#   /autoaway [time|off] [message]
#
#      time: minutes of inactivity to set away
#       off: disable auto-away (0 also disables)
#   message: away message (optional)
#
#   Without any arguments prints the current settings.
#
#
# Configuration options via /set:
#
# 'idletime'
#   description: Period in minutes (n) of keyboard inactivity until 
#                being marked as being away.
#                Setting idletime to "0", a negative number or a string
#                such as "off" disables auto-away. All positive values 
#                are treated as they integers.
#   command: /set plugins.var.python.auto_away.idletime n
# 
# 'message'
#   description: Away message. The /away command requires this setting 
#                not to be empty.
#   command: /set plugins.var.python.auto_away.message "message"
#
#
# Changelog:
#
#   2010-02-11 - 0.1    - Specimen:
#                         Script created.
#   2010-02-11 - 0.1.1  - Specimen
#                         Various fixes with the help of Flashcode
#   2010-02-13 - 0.2    - Specimen:
#                         Option to disable autoaway, return from away
#                         via hook_signal as suggested by Nils G.
#                         No longer uses plugin configuration to store
#                         away status.
#   2010-02-20 - 0.2.5  - Specimen:
#                         Use hook_config to check idletime and
#                         enable/disable hook_timer.
#                         Removed away_status.  
#   2010-02-21 - 0.3    - Specimen:
#                         Implemented /autoaway command.
#   2010-02-22 - 0.3.3  - Specimen:
#                         Fixed /autoaway command args.
#                         Removed hookinterval.
#                         When setting away it now checks if 'message'
#                         is empty and fixes it.
#                         Workaround for /away -all bug in disconnected
#                         servers (uses some screen_away.py code).
#                         /autoaway without arguments outputs current
#                         settings.
#                         Code rewrite.

try:
    import weechat as w
    
except Exception:
    print "This script must be run under WeeChat."
    print "Get WeeChat now at: http://www.weechat.org/"
    quit()

# Script Properties
SCRIPT_NAME    = "auto_away"
SCRIPT_AUTHOR  = "Specimen"
SCRIPT_VERSION = "0.3.3"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "Simple auto-away script in Python"

# Default values
idletime = "20"
message = "Idle"

# Functions
def timer_hook_function():
    ''' Timer hook to check inactivity '''
    global timer_hook
    if val_idletime() > 0:
        timer_hook = w.hook_timer(10 * 1000, 60, 0, "idle_chk", "")
    return w.WEECHAT_RC_OK

def val_idletime():
    ''' Test idletime value '''
    try:
        idletime_value = int(w.config_get_plugin('idletime'))
    except ValueError:
        idletime_value = 0
    return idletime_value

def idle_chk(data, remaining_calls):
    ''' Inactivity check, when to change status to away '''
    global timer_hook
    if int(w.info_get("inactivity", "")) >= val_idletime() * 60:
        w.unhook(timer_hook)
        if not w.config_get_plugin('message'):
            w.config_set_plugin('message', message)
        w.command("", "/away -all %s" 
                  % w.config_get_plugin('message'))
        if int(version) < 0x00030200:
            ''' Workaround for /away -all bug in v. < 0.3.2 '''
            servers = irc_servers()
            if servers:
                for server in servers:
                    w.command(server, "/away %s" 
                              % w.config_get_plugin('message'))
        input_hook_function()
    return w.WEECHAT_RC_OK

def irc_servers():
    ''' Disconnected IRC servers, workaround for /away -all bug 
    in v. < 0.3.2 '''
    serverlist = w.infolist_get('irc_server','','')
    buffers = []
    if serverlist:
        while w.infolist_next(serverlist):
            if w.infolist_integer(serverlist, 'is_connected') == 0:
                buffers.append((w.infolist_pointer(serverlist,
                               'buffer')))
        w.infolist_free(serverlist)
    return buffers

def input_hook_function():
    ''' Input hook to check for typing '''
    global input_hook
    input_hook = w.hook_signal("input_text_changed",
                               "typing_chk", "")
    return w.WEECHAT_RC_OK

def typing_chk(data, signal, signal_data):
    ''' Activity check, when to return from away '''
    global input_hook
    w.unhook(input_hook)
    w.command("", "/away -all")
    if int(version) < 0x00030200:
        ''' Workaround for /away -all bug in v. < 0.3.2 '''
        servers = irc_servers()
        if servers:
            for server in servers:
                w.command(server, "/away")
    timer_hook_function()
    return w.WEECHAT_RC_OK

# Command hook and config hook
def autoaway_cmd(data, buffer, args):
    ''' /autoaway command, what to do with the arguments '''
    if args:
        value = args.strip(' ').partition(' ')
        w.config_set_plugin('idletime', value[0])
        if value[2]:
            w.config_set_plugin('message', value[2])
    if val_idletime() > 0:
        w.prnt(w.current_buffer(), 
               "%sauto-away%s settings:\n"
               "   Time:    %s%s%s minute(s)\n"
               "   Message: %s%s\n"
               % (w.color("bold"), w.color("-bold"),
               w.color("bold"), w.config_get_plugin('idletime'), 
               w.color("-bold"), w.color("bold"), 
               w.config_get_plugin('message')))
    else:
        w.prnt(w.current_buffer(), 
               "%sauto-away%s is disabled.\n"
               % (w.color("bold"), w.color("-bold")))
    return w.WEECHAT_RC_OK

def switch_chk(data, option, value):
    ''' Checks when idletime setting is changed '''
    global timer_hook, input_hook
    if timer_hook:
        w.unhook(timer_hook)
    if input_hook:
        w.unhook(input_hook)
    timer_hook_function()
    return w.WEECHAT_RC_OK

# Main
if __name__ == "__main__":
    if w.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                  SCRIPT_LICENSE, SCRIPT_DESC, "", ""):
                  
        if not w.config_get_plugin('idletime'): 
            w.config_set_plugin('idletime', idletime)	
        if not w.config_get_plugin('message'): 
            w.config_set_plugin('message', message)
            
        w.hook_command("autoaway", 
                       "Set away status automatically after a period of "
                       "inactivity.", 
                       "[time|off] [message]", 
                       "      time: minutes of inactivity to set away\n"
                       "       off: disable auto-away (0 also disables)\n"
                       "   message: away message (optional)\n"
                       "\n"
                       "Without any arguments prints the current settings.\n"
                       "\n"
                       "Examples:\n"
                       "\n"
                       "/autoaway 20 I'm away\n"
                       "Sets auto-away to 20 minutes, and away message to "
                       "'I'm away'.\n"
                       "\n"
                       "/autoaway 30\n"
                       "Sets auto-away to 30 minutes, and uses the previously "
                       "set, or default, away message.\n"
                       "\n"
                       "/autoaway off\n"
                       "/autoaway 0\n"
                       "Disables auto-away.\n",
                       "", 
                       "autoaway_cmd", "")
        w.hook_config("plugins.var.python.auto_away.idletime",
                      "switch_chk", "")
                      
        version = w.info_get("version_number", "") or 0
        timer_hook = None
        input_hook = None

        timer_hook_function()
