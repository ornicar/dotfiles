# -*- coding: utf-8 -*-
# otr - WeeChat script for Off-the-Record IRC messaging
#
# DISCLAIMER: To the best of my knowledge this script securely provides OTR
# messaging in WeeChat, but I offer no guarantee. Please report any security
# holes you find.
#
# Copyright (c) 2012 Matthew M. Boedicker <matthewm@boedicker.org>
#                    Nils Görs <weechatter@arcor.de>
#
# Report issues at https://github.com/mmb/weechat-otr
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from __future__ import unicode_literals

import collections
import cStringIO
import os
import re
import traceback

import weechat

import potr

SCRIPT_NAME = 'otr'
SCRIPT_DESC = 'Off-the-Record messaging for IRC'
SCRIPT_HELP = """%s

Quick start:

Add an OTR item to the status bar by adding '[otr]' to the config setting
weechat.bar.status.items. This will show you whether your current conversation
is encrypted, authenticated and logged. /set otr.* for OTR status bar
customization options.

Start a private conversation with a friend who has OTR: /query yourpeer hi

In the private chat buffer: /otr start

If you have not authenticated your peer yet, follow the instructions for
authentication.

View OTR policies for your peer: /otr policy

To end your private conversation: /otr finish
""" % SCRIPT_DESC

SCRIPT_AUTHOR = 'Matthew M. Boedicker'
SCRIPT_LICENCE = 'GPL3'
SCRIPT_VERSION = '1.2.0pre'

OTR_DIR_NAME = 'otr'

OTR_QUERY_RE = re.compile('\?OTR(\?|\??v[a-z\d]*\?)$')

POLICIES = {
    'allow_v2' : 'allow OTR protocol version 2',
    'require_encryption' : 'refuse to send unencrypted messages',
    'send_tag' : 'advertise your OTR capability using the whitespace tag',
    }

READ_ONLY_POLICIES = {
    'allow_v1' : False,
    }

IRC_PRIVMSG_RE = re.compile(r"""
(
    :
    (?P<from>
        (?P<from_nick>.+?)
        !
        (?P<from_user>.+?)
        @
        (?P<from_host>.+?)
    )
\ )?
PRIVMSG
\ (?P<to>.+?)
\ :
(?P<text>.+)
""", re.VERBOSE)

potr.proto.TaggedPlaintextOrig = potr.proto.TaggedPlaintext

class WeechatTaggedPlaintext(potr.proto.TaggedPlaintextOrig):
    """Patch potr.proto.TaggedPlaintext to not end plaintext tags in a space.

    When POTR adds OTR tags to plaintext it puts them at the end of the message.
    The tags end in a space which gets stripped off by WeeChat because it
    strips trailing spaces from commands. This causes OTR initiation to fail so
    the following code adds an extra tab at the end of the plaintext tags if
    they end in a space.
    """

    def __bytes__(self):
        # old style because parent class is old style
        result = utf8_decode(potr.proto.TaggedPlaintextOrig.__bytes__(self))

        if result.endswith(' '):
            result = '%s\t' % result

        return utf8_encode(result)

potr.proto.TaggedPlaintext = WeechatTaggedPlaintext

def utf8_encode(s):
    """Encode a Unicode string into utf-8 bytes, replacing characters that
    can't be encoded."""
    return s.encode('utf-8', 'replace')

def utf8_decode(s):
    """Interpret a string of bytes as utf-8, replacing characters that can't
    be interpreted."""
    return s.decode('utf-8', 'replace')

def command(buf, command_str):
    """Wrap weechat.command() with utf-8 encode."""
    debug(command_str)
    weechat.command(buf, utf8_encode(command_str))

def privmsg(server, nick, message):
    """Send a private message to a nick."""
    for line in message.split('\n'):
        command('', '/quote -server %s PRIVMSG %s :%s' % (server, nick, line))

def build_privmsg_in(fromm, to, msg):
    """Build an inbound IRC PRIVMSG command."""
    return ':%s PRIVMSG %s :%s' % (fromm, to, msg)

def prnt(buf, message):
    """Wrap weechat.prnt() with utf-8 encode."""
    weechat.prnt(buf, utf8_encode(message))

def debug(msg):
    """Send a debug message to the WeeChat core buffer."""
    debug_option = weechat.config_get(config_prefix('general.debug'))

    if weechat.config_boolean(debug_option):
        prnt('', ('%s debug\t%s' % (SCRIPT_NAME, unicode(msg))))

def current_user(server_name):
    """Get the nick and server of the current user on a server."""
    return irc_user(info_get('irc_nick', server_name), server_name)

def irc_user(nick, server):
    """Build an IRC user string from a nick and server."""
    return '%s@%s' % (nick, server)

def parse_irc_privmsg(message):
    """Parse an IRC PRIVMSG command and return a dictionary.

    Either the to_channel key or the to_nick key will be set depending on
    whether the message is to a nick or a channel. The other will be None.

    Example input:

    :nick!user@host PRIVMSG #weechat :message here

    Output:

    {'from': 'nick!user@host',
    'from_nick': 'nick',
    'from_user': 'user',
    'from_host': 'host',
    'to': '#weechat',
    'to_channel': '#weechat',
    'to_nick': None,
    'text': 'message here'}
    """

    match = IRC_PRIVMSG_RE.match(message)
    if match:
        result = match.groupdict()

        if result['to'].startswith('#'):
            result['to_channel'] = result['to']
            result['to_nick'] = None
        else:
            result['to_channel'] = None
            result['to_nick'] = result['to']

        return result

def has_otr_end(msg):
    """Return True if the message is the end of an OTR message."""
    return msg.endswith('.') or msg.endswith(',')

def first_instance(objs, klass):
    """Return the first object in the list that is an instance of a class."""
    for obj in objs:
        if isinstance(obj, klass):
            return obj

def config_prefix(option):
    """Add the config prefix to an option and return the full option name."""
    return '%s.%s' % (SCRIPT_NAME, option)

def config_color(option):
    """Get the color of a color config option."""
    return weechat.color(weechat.config_color(weechat.config_get(
            config_prefix('color.%s' % option))))

def config_string(option):
    """Get the string value of a config option with utf-8 decode."""
    return weechat.config_string(
        utf8_decode(weechat.config_get(config_prefix(option))))

def buffer_get_string(buf, prop):
    """Wrap weechat.buffer_get_string() with utf-8 encode/decode."""
    return utf8_decode(weechat.buffer_get_string(buf, utf8_encode(prop)))

def buffer_is_private(buf):
    """Return True if a buffer is private."""
    return buffer_get_string(buf, 'localvar_type') == 'private'

def info_get(info_name, arguments):
    """Wrap weechat.info_get() with utf-8 encode/decode."""
    return utf8_decode(weechat.info_get(info_name, utf8_encode(arguments)))

def default_peer_args(args):
    """Get the nick and server of a remote peer from command arguments or
    the current buffer.

    Passed in args are the [nick, server] slice of arguments from a command.
    If these are present, return them. If args is empty and the current buffer
    is private, return the remote nick and server of the current buffer.
    """
    result = None, None

    if len(args) == 2:
        result = tuple(args)
    else:
        buf = weechat.current_buffer()

        if buffer_is_private(buf):
            result = (
                buffer_get_string(buf, 'localvar_channel'),
                buffer_get_string(buf, 'localvar_server'))

    return result

class AccountDict(collections.defaultdict):
    """Dictionary that adds missing keys as IrcOtrAccount instances."""

    def __missing__(self, key):
        debug(('add account', key))
        self[key] = IrcOtrAccount(key)

        return self[key]

class Assembler:
    """Reassemble fragmented OTR messages.

    This does not deal with OTR fragmentation, which is handled by potr, but
    fragmentation of received OTR messages that are too large for IRC.
    """
    def __init__(self):
        self.clear()

    def add(self, data):
        """Add data to the buffer."""
        self.value += data

    def clear(self):
        """Empty the buffer."""
        self.value = ''

    def is_done(self):
        """Return True if the buffer is a complete message."""
        return self.is_query() or \
            not self.value.startswith(potr.proto.OTRTAG) or \
            has_otr_end(self.value)

    def get(self):
        """Return the current value of the buffer and empty it."""
        result = self.value
        self.clear()

        return result

    def is_query(self):
        """Return true if the buffer is an OTR query."""
        return OTR_QUERY_RE.match(self.value)

class IrcContext(potr.context.Context):
    """Context class for OTR over IRC."""

    def __init__(self, account, peername):
        super(IrcContext, self).__init__(account, peername)

        self.peer_nick, self.peer_server = peername.split('@')
        self.in_assembler = Assembler()
        self.in_otr_message = False
        self.in_smp = False
        self.smp_question = False

    def policy_config_option(self, policy):
        """Get the option name of a policy option for this context."""
        return config_prefix('.'.join([
                    'policy', self.peer_server, self.user.nick, self.peer_nick,
                    policy.lower()]))

    def getPolicy(self, key):
        """Get the value of a policy option for this context."""
        key_lower = key.lower()

        if key_lower in READ_ONLY_POLICIES:
            result = READ_ONLY_POLICIES[key_lower]
        else:
            option = weechat.config_get(self.policy_config_option(key))

            if option == '':
                option = weechat.config_get(
                    config_prefix('policy.default.%s' % key_lower))

            result = bool(weechat.config_boolean(option))

        debug(('getPolicy', key, result))

        return result

    def inject(self, msg, appdata=None):
        """Send a message to the remote peer."""
        if isinstance(msg, potr.proto.OTRMessage):
            msg = unicode(msg)
        else:
            msg = utf8_decode(msg)

        debug(('inject', msg, 'len %d' % len(msg), appdata))

        privmsg(self.peer_server, self.peer_nick, msg)

    def setState(self, newstate):
        """Handle state transition."""
        debug(('state', self.state, newstate))

        if self.is_encrypted():
            if newstate == potr.context.STATE_ENCRYPTED:
                self.print_buffer(
                    'Private conversation has been refreshed.')
            elif newstate == potr.context.STATE_FINISHED:
                self.print_buffer(
                    """%s has ended the private conversation. You should do the same:
/otr finish %s %s
""" % (self.peer, self.peer_nick, self.peer_server))
        elif newstate == potr.context.STATE_ENCRYPTED:
            # unencrypted => encrypted
            trust = self.getCurrentTrust()
            if trust is None:
                fpr = str(self.getCurrentKey())
                self.print_buffer('New fingerprint: %s' % fpr)
                self.setCurrentTrust('')

            if bool(trust):
                self.print_buffer(
                    'Authenticated secured OTR conversation started.')
            else:
                self.print_buffer(
                    'Unauthenticated secured OTR conversation started.')
                self.print_buffer(self.verify_instructions())

        if self.state != potr.context.STATE_PLAINTEXT and \
                newstate == potr.context.STATE_PLAINTEXT:
            self.print_buffer('Private conversation ended.')

        super(IrcContext, self).setState(newstate)

    def maxMessageSize(self, appdata=None):
        """Return the max message size for this context."""
        # remove 'PRIVMSG <nick> :' from max message size
        result = self.user.maxMessageSize - 10 - len(self.peer_nick)
        debug('max message size %d' % result)

        return result

    def buffer(self):
        """Get the buffer for this context."""
        return info_get(
            'irc_buffer', '%s,%s' % (self.peer_server, self.peer_nick))

    def print_buffer(self, msg):
        """Print a message to the buffer for this context."""
        prnt(self.buffer(), '%s\t%s' % (SCRIPT_NAME, msg))

    def smp_finish(self, message):
        """Reset SMP state and send a message to the user."""
        self.in_smp = False
        self.smp_question = False

        self.user.saveTrusts()
        self.print_buffer(message)

    def handle_tlvs(self, tlvs):
        """Handle SMP states."""
        if tlvs:
            smp1q = first_instance(tlvs, potr.proto.SMP1QTLV)
            smp3 = first_instance(tlvs, potr.proto.SMP3TLV)
            smp4 = first_instance(tlvs, potr.proto.SMP4TLV)

            if self.in_smp and not self.smpIsValid():
                debug('SMP aborted')
                self.smp_finish('SMP aborted.')
            elif first_instance(tlvs, potr.proto.SMP1TLV):
                debug('SMP1')
                self.in_smp = True

                self.print_buffer(
                    """Peer has requested SMP verification.
Respond with: /otr smp respond %s %s <secret>""" % (
                        self.peer_nick, self.peer_server))
            elif smp1q:
                debug(('SMP1Q', smp1q.msg))
                self.in_smp = True
                self.smp_question = True

                self.print_buffer(
                    """Peer has requested SMP verification: %s
Respond with: /otr smp respond %s %s <answer>""" % (
                        smp1q.msg, self.peer_nick, self.peer_server))
            elif first_instance(tlvs, potr.proto.SMP2TLV):
                debug('SMP2')
                self.print_buffer('SMP progressing.')
            elif smp3 or smp4:
                if smp3:
                    debug('SMP3')
                elif smp4:
                    debug('SMP4')

                if self.smpIsSuccess():
                    self.smp_finish('SMP verification succeeded.')

                    if self.smp_question:
                        self.print_buffer(
                            """You may want to authenticate your peer by asking your own question:
/otr smp ask %s %s <secret> <question>
""" % (self.peer_nick, self.peer_server))
                else:
                    self.smp_finish('SMP verification failed.')

    def verify_instructions(self):
        """Generate verification instructions for user."""
        return """You can verify that this contact is who they claim to be in one of the following ways:

1) Verify each other's fingerprints using a secure channel:
  Your fingerprint : %(your_fingerprint)s
  %(peer)s's fingerprint : %(peer_fingerprint)s
  then use the command: /otr trust %(peer_nick)s %(peer_server)s

2) SMP pre-shared secret that you both know:
  /otr smp ask %(peer_nick)s %(peer_server)s <secret>

3) SMP pre-shared secret that you both know with a question:
  /otr smp ask %(peer_nick)s %(peer_server)s <secret> <question>
""" % dict(
            your_fingerprint=self.user.getPrivkey(),
            peer=self.peer,
            peer_fingerprint=potr.human_hash(
        self.crypto.theirPubkey.cfingerprint()),
            peer_nick=self.peer_nick,
            peer_server=self.peer_server,
            )

    def is_encrypted(self):
        """Return True if the conversation with this context's peer is
        currently encrypted."""
        return self.state == potr.context.STATE_ENCRYPTED

    def is_verified(self):
        """Return True if this context's peer is verified."""
        return bool(self.getCurrentTrust())

    def format_policies(self):
        """Return current policies for this context formatted as a string for
        the user."""
        buf = cStringIO.StringIO()

        buf.write('Current OTR policies for %s:\n' % self.peer)

        for policy, desc in sorted(POLICIES.iteritems()):
            buf.write('  %s (%s) : %s\n' % (
                    policy, desc,
                    { True : 'on', False : 'off'}[self.getPolicy(policy)]))

        buf.write('Change policies with: /otr policy NAME on|off')

        return buf.getvalue()

    def is_logged(self):
        """Return True if conversations with this context's peer are currently
        being logged to disk."""
        infolist = weechat.infolist_get('logger_buffer', '', '')

        buf = self.buffer()

        result = False

        while weechat.infolist_next(infolist):
            if weechat.infolist_pointer(infolist, 'buffer') == buf:
                result = bool(weechat.infolist_integer(infolist, 'log_enabled'))
                break

        weechat.infolist_free(infolist)

        return result

class IrcOtrAccount(potr.context.Account):
    """Account class for OTR over IRC."""

    contextclass = IrcContext

    PROTOCOL = 'irc'
    MAX_MSG_SIZE = 415

    def __init__(self, name):
        super(IrcOtrAccount, self).__init__(
            name, IrcOtrAccount.PROTOCOL, IrcOtrAccount.MAX_MSG_SIZE)

        self.nick, self.server = self.name.split('@')

        # IRC messages cannot have newlines, OTR query and "no plugin" text
        # need to be one message
        self.defaultQuery = self.defaultQuery.replace("\n", ' ')

        self.key_file_path = os.path.join(OTR_DIR, '%s.%s' % (name, 'key3'))
        self.fpr_file_path = os.path.join(OTR_DIR, '%s.%s' % (name, 'fpr'))

        self.load_trusts()

    def load_trusts(self):
        """Load trust data from the fingerprint file."""
        if os.path.exists(self.fpr_file_path):
            with open(self.fpr_file_path) as fpr_file:
                for line in fpr_file:
                    debug(('load trust check', line))

                    context, account, protocol, fpr, trust = \
                        line[:-1].split('\t')

                    if account == self.name and \
                            protocol == IrcOtrAccount.PROTOCOL:
                        debug(('set trust', context, fpr, trust))
                        self.setTrust(context, fpr, trust)

    def loadPrivkey(self):
        """Load key file."""
        debug(('load private key', self.key_file_path))

        if os.path.exists(self.key_file_path):
            with open(self.key_file_path, 'rb') as key_file:
                return potr.crypt.PK.parsePrivateKey(key_file.read())[0]

    def savePrivkey(self):
        """Save key file."""
        debug(('save private key', self.key_file_path))

        with open(self.key_file_path, 'wb') as key_file:
            key_file.write(self.getPrivkey().serializePrivateKey())

    def saveTrusts(self):
        """Save trusts."""
        with open(self.fpr_file_path, 'w') as fpr_file:
            for uid, trusts in self.trusts.iteritems():
                for fpr, trust in trusts.iteritems():
                    debug(('trust write', uid, self.name,
                           IrcOtrAccount.PROTOCOL, fpr, trust))
                    fpr_file.write('\t'.join(
                            (uid, self.name, IrcOtrAccount.PROTOCOL, fpr,
                             trust)))
                    fpr_file.write('\n')

    def end_all_private(self):
        """End all currently encrypted conversations."""
        for context in self.ctxs.itervalues():
            if context.is_encrypted():
                context.disconnect()

def message_in_cb(data, modifier, modifier_data, string):
    """Incoming message callback"""
    debug(('message_in_cb', data, modifier, modifier_data, string))

    parsed = parse_irc_privmsg(utf8_decode(string))
    debug(('parsed message', parsed))

    # skip processing messages to public channels
    if parsed['to_channel']:
        return string

    server = utf8_decode(modifier_data)

    from_user = irc_user(parsed['from_nick'], server)
    local_user = current_user(server)

    context = ACCOUNTS[local_user].getContext(from_user)

    context.in_assembler.add(parsed['text'])

    result = ''

    if context.in_assembler.is_done():
        try:
            msg, tlvs = context.receiveMessage(context.in_assembler.get())

            debug(('receive', msg, tlvs))

            if msg:
                result = utf8_encode(build_privmsg_in(
                    parsed['from'], parsed['to'], utf8_decode(msg)))

            context.handle_tlvs(tlvs)
        except potr.context.ErrorReceived, e:
            context.print_buffer('Received OTR error: %s' % e.args[0].error)
        except potr.context.NotEncryptedError:
            context.print_buffer(
                'Received encrypted data but no private session established.')
        except potr.context.NotOTRMessage:
            result = string
        except potr.context.UnencryptedMessage, err:
            result = utf8_encode(build_privmsg_in(
                parsed['from'], parsed['to'],
                'Unencrypted message received: %s' % (
                    err.args[0])))

    weechat.bar_item_update(SCRIPT_NAME)

    return result

def message_out_cb(data, modifier, modifier_data, string):
    """Outgoing message callback."""
    result = ''

    # If any exception is raised in this function, WeeChat will send the
    # outgoing message, which could be something that the user intended to be
    # encrypted. This paranoid exception handling ensures that the system
    # fails closed and not open.
    try:
        debug(('message_out_cb', data, modifier, modifier_data, string))

        parsed = parse_irc_privmsg(utf8_decode(string))
        debug(('parsed message', parsed))

        # skip processing messages to public channels
        if parsed['to_channel']:
            return string

        server = utf8_decode(modifier_data)

        to_user = irc_user(parsed['to_nick'], server)
        local_user = current_user(server)

        context = ACCOUNTS[local_user].getContext(to_user)

        if parsed['text'].startswith(potr.proto.OTRTAG) and \
                not OTR_QUERY_RE.match(parsed['text']):
            if not has_otr_end(parsed['text']):
                debug('in OTR message')
                context.in_otr_message = True
            else:
                debug('complete OTR message')
            result = string
        elif context.in_otr_message:
            if has_otr_end(parsed['text']):
                context.in_otr_message = False
                debug('in OTR message end')
            result = string
        else:
            debug(('context send message', parsed['text'], parsed['to_nick'],
                   server))

            try:
                ret = context.sendMessage(
                    potr.context.FRAGMENT_SEND_ALL,
                    utf8_encode(parsed['text']))

                if ret:
                    debug(('sendMessage returned', ret))
                    result = utf8_encode('PRIVMSG %s :%s' % (
                            parsed['to_nick'], utf8_decode(ret)))
            except potr.context.NotEncryptedError, err:
                if err.args[0] == potr.context.EXC_FINISHED:
                    context.print_buffer(
                        """Your message was not sent. End your private conversation:\n/otr finish %s %s""" % (
                            parsed['to_nick'], server))
                else:
                    raise

        weechat.bar_item_update(SCRIPT_NAME)
    except:
        try:
            prnt('', traceback.format_exc())
            context.print_buffer(
                'Failed to send message. See core buffer for traceback.')
        except:
            pass

    return result

def shutdown():
    """Script unload callback."""
    debug('shutdown')

    weechat.config_write(CONFIG_FILE)

    for account in ACCOUNTS.itervalues():
        account.end_all_private()

    free_all_config()

    weechat.bar_item_remove(OTR_STATUSBAR)

    return weechat.WEECHAT_RC_OK

def command_cb(data, buf, args):
    """Parse and dispatch WeeChat OTR commands."""
    result = weechat.WEECHAT_RC_ERROR

    arg_parts = args.split(None, 5)

    if len(arg_parts) in (1, 3) and arg_parts[0] == 'start':
        nick, server = default_peer_args(arg_parts[1:3])

        if nick is not None and server is not None:
            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))

            context.print_buffer('Sending OTR query...')
            context.print_buffer(
                'To try OTR on all conversations with %s: /otr policy send_tag on' %
                context.peer)

            privmsg(server, nick, '?OTR?')

            result = weechat.WEECHAT_RC_OK
    elif len(arg_parts) in (1, 3) and arg_parts[0] == 'finish':
        nick, server = default_peer_args(arg_parts[1:3])

        if nick is not None and server is not None:
            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))
            context.disconnect()

            result = weechat.WEECHAT_RC_OK
    elif len(arg_parts) in (5, 6) and arg_parts[0] == 'smp':
        action = arg_parts[1]

        if action == 'respond':
            nick, server = arg_parts[2:4]
            secret = args.split(None, 4)[-1]

            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))
            context.smpGotSecret(secret)

            result = weechat.WEECHAT_RC_OK
        elif action == 'ask':
            nick, server, secret = arg_parts[2:5]

            if len(arg_parts) > 5:
                question = arg_parts[5]
            else:
                question = None

            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))

            try:
                context.smpInit(secret, question)
            except potr.context.NotEncryptedError:
                context.print_buffer(
                    'There is currently no encrypted session with %s.' % \
                        context.peer)
            else:
                result = weechat.WEECHAT_RC_OK
    elif len(arg_parts) in (1, 3) and arg_parts[0] == 'trust':
        nick, server = default_peer_args(arg_parts[1:3])

        if nick is not None and server is not None:
            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))

            if context.crypto.theirPubkey is not None:
                context.setCurrentTrust('verified')
                context.print_buffer('%s is now authenticated.' % context.peer)

                weechat.bar_item_update(SCRIPT_NAME)
            else:
                context.print_buffer(
                    'No fingerprint for %s. Start an OTR conversation first: /otr start' \
                        % context.peer)

            result = weechat.WEECHAT_RC_OK
    elif len(arg_parts) in (1, 3) and arg_parts[0] == 'distrust':
        nick, server = default_peer_args(arg_parts[1:3])

        if nick is not None and server is not None:
            context = ACCOUNTS[current_user(server)].getContext(
                irc_user(nick, server))

            if context.crypto.theirPubkey is not None:
                context.setCurrentTrust('')
                context.print_buffer(
                    '%s is now de-authenticated.' % context.peer)

                weechat.bar_item_update(SCRIPT_NAME)
            else:
                context.print_buffer(
                    'No fingerprint for %s. Start an OTR conversation first: /otr start' \
                        % context.peer)

            result = weechat.WEECHAT_RC_OK
    elif len(arg_parts) in (1, 3) and arg_parts[0] == 'policy':
        if len(arg_parts) == 1:
            nick, server = default_peer_args([])

            if nick is not None and server is not None:
                context = ACCOUNTS[current_user(server)].getContext(
                    irc_user(nick, server))

                context.print_buffer(context.format_policies())

                result = weechat.WEECHAT_RC_OK
        elif len(arg_parts) == 3 and arg_parts[1].lower() in POLICIES:
            nick, server = default_peer_args([])

            if nick is not None and server is not None:
                context = ACCOUNTS[current_user(server)].getContext(
                    irc_user(nick, server))

                policy_var = context.policy_config_option(arg_parts[1].lower())

                command('', '/set %s %s' % (policy_var, arg_parts[2]))

                context.print_buffer(context.format_policies())

                result = weechat.WEECHAT_RC_OK

    return result

def otr_statusbar_cb(data, item, window):
    """Update the statusbar."""
    if window:
        buf = weechat.window_get_pointer(window, 'buffer')
    else:
        # If the bar item is in a root bar that is not in a window, window
        # will be empty.
        buf = weechat.current_buffer()

    result = ''

    if buffer_is_private(buf):
        local_user = irc_user(
            buffer_get_string(buf, 'localvar_nick'),
            buffer_get_string(buf, 'localvar_server'))

        remote_user = irc_user(
            buffer_get_string(buf, 'localvar_channel'),
            buffer_get_string(buf, 'localvar_server'))

        context = ACCOUNTS[local_user].getContext(remote_user)

        encrypted_str = config_string('look.bar.state.encrypted')
        unencrypted_str = config_string('look.bar.state.unencrypted')
        authenticated_str = config_string('look.bar.state.authenticated')
        unauthenticated_str = config_string('look.bar.state.unauthenticated')
        logged_str = config_string('look.bar.state.logged')
        notlogged_str = config_string('look.bar.state.notlogged')

        bar_parts = []

        if context.is_encrypted():
            if encrypted_str:
                bar_parts.append(''.join([
                            config_color('status.encrypted'),
                            encrypted_str,
                            config_color('status.default')]))

            if context.is_verified():
                if authenticated_str:
                    bar_parts.append(''.join([
                                config_color('status.authenticated'),
                                authenticated_str,
                                config_color('status.default')]))
            elif unauthenticated_str:
                bar_parts.append(''.join([
                            config_color('status.unauthenticated'),
                            unauthenticated_str,
                            config_color('status.default')]))

            if context.is_logged():
                if logged_str:
                    bar_parts.append(''.join([
                                config_color('status.logged'),
                                logged_str,
                                config_color('status.default')]))
            elif notlogged_str:
                bar_parts.append(''.join([
                            config_color('status.notlogged'),
                            notlogged_str,
                            config_color('status.default')]))

        elif unencrypted_str:
            bar_parts.append(''.join([
                        config_color('status.unencrypted'),
                        unencrypted_str,
                        config_color('status.default')]))

        result = config_string('look.bar.state.separator').join(bar_parts)

        if result:
            result = '%s%s%s' % (
                config_color('status.default'),
                config_string('look.bar.prefix'), result)

    return result

def bar_config_update_cb(data, option):
    """Callback for updating the status bar when its config changes."""
    weechat.bar_item_update(SCRIPT_NAME)

    return weechat.WEECHAT_RC_OK

def policy_completion_cb(data, completion_item, buf, completion):
    """Callback for policy tab completion."""
    for policy in POLICIES:
        weechat.hook_completion_list_add(
            completion, policy, 0, weechat.WEECHAT_LIST_POS_SORT)

    return weechat.WEECHAT_RC_OK

def policy_create_option_cb(data, config_file, section, name, value):
    """Callback for creating a new policy option when the user sets one
    that doesn't exist."""
    weechat.config_new_option(
        config_file, section, name, 'boolean', '', '', 0, 0, value, value, 0,
        '', '', '', '', '', '')

    return weechat.WEECHAT_CONFIG_OPTION_SET_OK_CHANGED

def logger_level_update_cb(data, option, value):
    """Callback called when any logger level changes."""
    weechat.bar_item_update(SCRIPT_NAME)

    return weechat.WEECHAT_RC_OK

def buffer_switch_cb(data, signal, signal_data):
    """Callback for buffer switched.

    Used for updating the status bar item when it is in a root bar.
    """
    weechat.bar_item_update(SCRIPT_NAME)

    return weechat.WEECHAT_RC_OK

def init_config():
    """Set up configuration options and load config file."""
    global CONFIG_FILE
    CONFIG_FILE = weechat.config_new(SCRIPT_NAME, 'config_reload_cb', '')

    global CONFIG_SECTIONS
    CONFIG_SECTIONS = {}

    CONFIG_SECTIONS['general'] = weechat.config_new_section(
        CONFIG_FILE, 'general', 0, 0, '', '', '', '', '', '', '', '', '', '')

    for option, typ, desc, default in [
        ('debug', 'boolean', 'OTR script debugging', 'off'),
        ]:
        weechat.config_new_option(
            CONFIG_FILE, CONFIG_SECTIONS['general'], option, typ, desc, '', 0,
            0, default, default, 0, '', '', '', '', '', '')

    CONFIG_SECTIONS['color'] = weechat.config_new_section(
        CONFIG_FILE, 'color', 0, 0, '', '', '', '', '', '', '', '', '', '')

    for option, desc, default, update_cb in [
        ('status.default', 'status bar default color', 'default',
         'bar_config_update_cb'),
        ('status.encrypted', 'status bar encrypted indicator color', 'green',
         'bar_config_update_cb'),
        ('status.unencrypted', 'status bar unencrypted indicator color',
         'lightred', 'bar_config_update_cb'),
        ('status.authenticated', 'status bar authenticated indicator color',
         'green', 'bar_config_update_cb'),
        ('status.unauthenticated', 'status bar unauthenticated indicator color',
         'lightred', 'bar_config_update_cb'),
        ('status.logged', 'status bar logged indicator color', 'lightred',
         'bar_config_update_cb'),
        ('status.notlogged', 'status bar not logged indicator color',
         'green', 'bar_config_update_cb'),
        ]:
        weechat.config_new_option(
            CONFIG_FILE, CONFIG_SECTIONS['color'], option, 'color', desc, '', 0,
            0, default, default, 0, '', '', update_cb, '', '', '')

    CONFIG_SECTIONS['look'] = weechat.config_new_section(
        CONFIG_FILE, 'look', 0, 0, '', '', '', '', '', '', '', '', '', '')

    for option, desc, default, update_cb in [
        ('bar.prefix', 'prefix for OTR status bar item', 'OTR:',
         'bar_config_update_cb'),
        ('bar.state.encrypted',
         'shown in status bar when conversation is encrypted', 'SEC',
         'bar_config_update_cb'),
        ('bar.state.unencrypted',
         'shown in status bar when conversation is not encrypted', '!SEC',
         'bar_config_update_cb'),
        ('bar.state.authenticated',
         'shown in status bar when peer is authenticated', 'AUTH',
         'bar_config_update_cb'),
        ('bar.state.unauthenticated',
         'shown in status bar when peer is not authenticated', '!AUTH',
         'bar_config_update_cb'),
        ('bar.state.logged',
         'shown in status bar when peer conversation is being logged to disk',
         'LOG',
         'bar_config_update_cb'),
        ('bar.state.notlogged',
         'shown in status bar when peer conversation is not being logged to disk',
         '!LOG',
         'bar_config_update_cb'),
        ('bar.state.separator', 'separator for states in the status bar', ',',
         'bar_config_update_cb'),
        ]:
        weechat.config_new_option(
            CONFIG_FILE, CONFIG_SECTIONS['look'], option, 'string', desc, '',
            0, 0, default, default, 0, '', '', update_cb, '', '', '')

    CONFIG_SECTIONS['policy'] = weechat.config_new_section(
        CONFIG_FILE, 'policy', 1, 1, '', '', '', '', '', '',
        'policy_create_option_cb', '', '', '')

    for option, desc, default in [
        ('default.allow_v2', 'default allow OTR v2 policy', 'on'),
        ('default.require_encryption', 'default require encryption policy',
         'off'),
        ('default.send_tag', 'default send tag policy', 'off'),
        ]:
        weechat.config_new_option(
            CONFIG_FILE, CONFIG_SECTIONS['policy'], option, 'boolean', desc, '',
            0, 0, default, default, 0, '', '', '', '', '', '')

    weechat.config_read(CONFIG_FILE)

def config_reload_cb(data, config_file):
    """/reload callback to reload config from file."""
    free_all_config()
    init_config()

    return weechat.WEECHAT_CONFIG_READ_OK

def free_all_config():
    """Free all config options, sections and config file."""
    for section in CONFIG_SECTIONS.itervalues():
        weechat.config_section_free_options(section)
        weechat.config_section_free(section)

    weechat.config_free(CONFIG_FILE)

def create_dir():
    """Create the OTR subdirectory in the WeeChat config directory if it does
    not exist."""
    if not os.path.exists(OTR_DIR):
        weechat.mkdir_home(OTR_DIR_NAME, 0700)

if weechat.register(
    SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENCE, SCRIPT_DESC,
    'shutdown', ''):
    init_config()

    OTR_DIR = os.path.join(info_get('weechat_dir', ''), OTR_DIR_NAME)
    create_dir()

    ACCOUNTS = AccountDict()

    weechat.hook_modifier('irc_in_privmsg', 'message_in_cb', '')
    weechat.hook_modifier('irc_out_privmsg', 'message_out_cb', '')

    weechat.hook_command(
        SCRIPT_NAME, SCRIPT_HELP,
        'start [NICK SERVER] || '
        'finish [NICK SERVER] || '
        'smp ask NICK SERVER SECRET [QUESTION] || '
        'smp respond NICK SERVER SECRET || '
        'trust [NICK SERVER] || '
        'distrust [NICK SERVER] || '
        'policy [POLICY on|off]',
        '',
        'start %(nick) %(irc_servers) %-||'
        'finish %(nick) %(irc_servers) %-||'
        'smp ask|respond %(nick) %(irc_servers) %-||'
        'trust %(nick) %(irc_servers) %-||'
        'distrust %(nick) %(irc_servers) %-||'
        'policy %(otr_policy) on|off %-||',
        'command_cb',
        '')

    weechat.hook_completion(
        'otr_policy', 'OTR policies', 'policy_completion_cb', '')

    weechat.hook_config('logger.level.irc.*', 'logger_level_update_cb', '')

    weechat.hook_signal('buffer_switch', 'buffer_switch_cb', '')

    OTR_STATUSBAR = weechat.bar_item_new(SCRIPT_NAME, 'otr_statusbar_cb', '')
    weechat.bar_item_update(SCRIPT_NAME)
