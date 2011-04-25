# Copyright (c) 2009-2010 by Nils Görs <weechatter@arcor.de>
#
# waiting for hotlist to change and then execute a user specified command
# or writes the hotlist to screen title.
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
# I am using this script to display the hotlist with STDIN plasmoid on
# KDE desktop.
# http://www.kde-look.org/content/show.php/STDIN+Plasmoid?content=92309
#
# Script inspirated and tested by LaoLang_cool
#
# 0.7	: using %h for weechat-dir instead of hardcoded path in script (flashcode)
# 0.6	: new option "use_title" to print hotlist in screen title.
# 0.5	: lot of internal changes
# 0.4	: highlight_char can be set as often as you want
#	: merged buffer will be displayed once
#	: more than one metachar-highlight produced a perl error
# 0.3	: usersettings won't be loaded, sorry! :-(
#	: added a more complex sort routine (from important to unimportant and also numeric)
#	: added options: "delimiter", "priority_remove" and "hotlist_remove_format"
#
#
# use the following settings for hotlist_format:
# %h = weechat-dir (~/.weechat)
# %H = filled with highlight_char if a highlight message was written in channel. For example: *
# %N = filled with buffer number: 1 2 3 ....
# %S = filled with short name of channel: #weechat
#
# export the hotlist_format to your external command.
# %X
#
# Usage:
# template to use for display (for example: "1:freenode *2:#weechat"):
# /set plugins.var.perl.hotlist2extern.hotlist_format  "%H%N:%S"
#
# Output (for example: "WeeChat Act: %H%N:%S"):
# /set plugins.var.perl.hotlist2extern.external_command_hotlist "echo \'WeeChat Act: %X\' >%h/hotlist_output.txt"
#
# Output if there is no activity (for example: "WeeChat: no activity"):
# /set plugins.var.perl.hotlist2extern.external_command_hotlist_empty "echo 'WeeChat: no activity ' >%h/hotlist_output.txt"
#
# charset for a highlight message:
# /set plugins.var.perl.hotlist2extern.highlight_char  "*"
#
# template that shall be remove when message priority is low. (for example, the buffer name will be removed and only the buffer
# number will be display instead! (1 *2:#weechat):
# /set plugins.var.perl.hotlist2extern.hotlist_remove_format ":%S"
#
# message priority when using hotlist_remove_format (-1 means off)
# /set plugins.var.perl.hotlist2extern.priority_remove 0
#
# display messages with level:
# 0=crappy msg (join/part) and core buffer informations, 1=msg, 2=pv, 3=nick highlight
# /set plugins.var.perl.hotlist2extern.lowest_priority  0
#
# delimiter to use:
# /set plugins.var.perl.hotlist2extern.delimiter ","
#
# hotlist will be printed to screen title:
# /set plugins.var.perl.hotlist2extern.use_title "on"

use strict;
my $hotlist_format		= "%H%N:%S";
my $hotlist_remove_format	= ":%S";
my $external_command_hotlist	= "echo \'WeeChat Act: %X\' >%h/hotlist_output.txt";
my $external_command_hotlist_empty	= "echo \'WeeChat: no activity \' >%h/hotlist_output.txt";
my $highlight_char		= "*";
my $lowest_priority		= 0;
my $priority_remove		= 0;
my $delimiter			= ",";
my $use_title			= "on";

my $prgname	= "hotlist2extern";
my $version	= "0.7";
my $description	= "Give hotlist to an external file/program/screen title";
my $current_buffer = "";

my $plugin_name		= "";
my $weechat_dir		= "";
my $buffer_name		= "";
my $buffer_number	= 0;
my $buffer_pointer	= 0;
my $short_name		= "";
my $res 		= "";
my $res2 		= "";
my $priority		= 0;
my @table		= ();
my $table		= "";

sub hotlist_changed{
my ($data, $buffer, $args) = ($_[0], $_[1], $_[2]);			# save callback from hook_signal
@table		= ();
$table		= "";

  $current_buffer = weechat::current_buffer;				# get current buffer
  my $hotlist = weechat::infolist_get("hotlist","","");			# Pointer to Infolist

   while (weechat::infolist_next($hotlist))
    {
        $priority = weechat::infolist_integer($hotlist, "priority");
	  $res = $hotlist_format;							# save hotlist format
	  $res2 = $external_command_hotlist;						# save external_hotlist format

	    $plugin_name = weechat::infolist_string($hotlist,"plugin_name");
	    $buffer_name = weechat::infolist_string($hotlist,"buffer_name");
	    $buffer_number = weechat::infolist_integer($hotlist,"buffer_number");	# get number of buffer
	    $buffer_pointer = weechat::infolist_pointer($hotlist, "buffer_pointer");	# Pointer to buffer
	    $short_name = weechat::buffer_get_string($buffer_pointer, "short_name");	# get short_name of buffer

	unless ($priority < $lowest_priority){
	  create_output();
	}
    }
  weechat::infolist_free($hotlist);
	    $table = @table;
	    if ($table eq 0){
	      unless ($external_command_hotlist_empty eq ""){				# does we have a command for empty string?
		if ($use_title eq "on"){
		  weechat::window_set_title($external_command_hotlist_empty);
		}else{
		if (grep (/\%h/,$external_command_hotlist_empty)){			# does %h is in string?
		  $external_command_hotlist_empty =~ s/%h/$weechat_dir/;		# add weechat-dir
		}
		  system($external_command_hotlist_empty);
		}
	      }
	    }
  return weechat::WEECHAT_RC_OK;
}

sub create_output{
	  $res = $hotlist_format;							# save hotlist format
	  $res2 = $external_command_hotlist;						# save external_hotlist format

	    if ($priority == 3){							# priority is highlight
	      if (grep (/\%H/,$hotlist_format)){					# check with original!!!
		$res =~ s/\%H/$highlight_char/g;
	      }
	    }else{									# priority != 3
		$res =~ s/\%H//g;							# remove all %H
	    }
   if ($priority <= $priority_remove){
	      $res =~ s/$hotlist_remove_format//;					# remove hotlist_remove_format
	    if (grep (/\%S/,$hotlist_format)){						# does %S is in string? (check with original!!!)
		  $res =~ s/%S/$short_name/;						# add short_name
	    }
 	    if (grep (/\%N/,$hotlist_format)){
	      $res =~ s/%N/$buffer_number/;						# add buffer_number
	    }
   }else{
	    if (grep (/\%S/,$hotlist_format)){						# does %S is in string? (check with original!!!)
		  $res =~ s/%S/$short_name/;						# add short_name
	    }
 	    if (grep (/\%N/,$hotlist_format)){
	      $res =~ s/%N/$buffer_number/;						# add buffer_number
	    }
    }
	    if ($res ne $hotlist_format and $res ne ""){				# did $res changed?
		my $res2 = $res;							# save search string.
		$res2=qq(\Q$res2);							# kill metachars, for searching first
		unless (grep /^$res2$/, @table){					# does we have added $res to @table?
		push (@table, $res);							# No, then add it to @table
	      }
	    }

	    $res=qq(\Q$res);								# kill metachars first
	    if (grep /^$res$/, @table){							# does we have added $res to @table?
	      my $export = join("$delimiter", sort_routine(@table));
	      if (grep (/\%X/,$external_command_hotlist)){				# check for %X option.
		$res2 =~ s/%X/$export/;

		if (grep (/\%h/,$external_command_hotlist)){				# does %h is in string?
		  $res2 =~ s/%h/$weechat_dir/;						# add weechat-dir
		}

		if ($use_title eq "on"){
		  weechat::window_set_title($res2);
		}else{
	    	system($res2);
		}

	      }
	    }
}

# first sort channels with highlight, then channels with
# action and the rest will be put it at the end of list
sub sort_routine {
  my @zeilen = @_;
  my @sortiert = map { $_->[0] }
  map { [$_,(split (/\*/,$_))[1]] } @zeilen ;
  sort { $a->[0] cmp $b->[0] }		#sort{$a<=>$b}(@zeilen);
return @sortiert;
}

sub _extern{
  my ($data) = ($_[0]);
	system($data) unless($data eq "");
  return weechat::WEECHAT_RC_OK;
}

sub init{
# set value of script (for example starting script the first time)
  if (!weechat::config_is_set_plugin("external_command_hotlist")){
    weechat::config_set_plugin("external_command_hotlist", $external_command_hotlist);
  }else{
    $external_command_hotlist = weechat::config_get_plugin("external_command_hotlist");
  }
  if (!weechat::config_is_set_plugin("external_command_hotlist_empty")){
    weechat::config_set_plugin("external_command_hotlist_empty", $external_command_hotlist_empty);
  }else{
    $external_command_hotlist_empty = weechat::config_get_plugin("external_command_hotlist_empty");
  }
  if (!weechat::config_is_set_plugin("highlight_char")){
    weechat::config_set_plugin("highlight_char", $highlight_char);
  }else{
    $highlight_char = weechat::config_get_plugin("highlight_char");
  }
  if (!weechat::config_is_set_plugin("lowest_priority")){
    weechat::config_set_plugin("lowest_priority", $lowest_priority);
  }else{
    $lowest_priority = weechat::config_get_plugin("lowest_priority");
  }
  if (!weechat::config_is_set_plugin("hotlist_format")){
    weechat::config_set_plugin("hotlist_format", $hotlist_format);
  }else{
    $hotlist_format = weechat::config_get_plugin("hotlist_format");
  }
  if (!weechat::config_is_set_plugin("hotlist_remove_format")){
    weechat::config_set_plugin("hotlist_remove_format", $hotlist_remove_format);
  }else{
    $hotlist_remove_format = weechat::config_get_plugin("hotlist_remove_format");
  }
  if (!weechat::config_is_set_plugin("priority_remove")){
    weechat::config_set_plugin("priority_remove", $priority_remove);
  }else{
    $priority_remove = weechat::config_get_plugin("priority_remove");
  }
  if (!weechat::config_is_set_plugin("delimiter")){
    weechat::config_set_plugin("delimiter", $delimiter);
  }else{
    $delimiter = weechat::config_get_plugin("delimiter");
  }
  if (!weechat::config_is_set_plugin("use_title")){
    weechat::config_set_plugin("use_title", $use_title);
  }else{
    $use_title = weechat::config_get_plugin("use_title");
  }
  $weechat_dir = weechat::info_get("weechat_dir", "");
}

sub toggle_config_by_set{
my ( $pointer, $name, $value ) = @_;

  if ($name eq "plugins.var.perl.$prgname.external_command_hotlist"){
    $external_command_hotlist = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.external_command_hotlist_empty"){
    $external_command_hotlist_empty = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.highlight_char"){
    $highlight_char = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.lowest_priority"){
    $lowest_priority = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.hotlist_format"){
    $hotlist_format = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.hotlist_remove_format"){
    $hotlist_remove_format = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.priority_remove"){
    $priority_remove = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.delimiter"){
    $delimiter = $value;
    return weechat::WEECHAT_RC_OK;
  }
  if ($name eq "plugins.var.perl.$prgname.use_title"){
    $use_title = $value;
    return weechat::WEECHAT_RC_OK;
  }
}

# first function called by a WeeChat-script.
weechat::register($prgname, "Nils Görs <weechatter\@arcor.de>", $version,
                  "GPL3", $description, "", "");

     init();				# get user settings

      weechat::hook_signal("hotlist_changed", "hotlist_changed", "");
      weechat::hook_config( "plugins.var.perl.$prgname.*", "toggle_config_by_set", "" );
