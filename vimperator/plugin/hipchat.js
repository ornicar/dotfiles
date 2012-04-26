// INFO //
var INFO = 
<plugin name="hipchat.js" version="0.1"
        summary="Add hipchat shortcuts"
        href="http://github.com/ornicar"
        xmlns="http://vimperator.org/namespaces/liberator">
  <author email="thibault.duplessis@gmail.com">Thibault Duplessis</author>
  <license href="http://opensource.org/licenses/mit-license.php">MIT</license>
  <project name="Vimperator" minVersion="2.3"/>
  <p>Hipchat goodies</p>
  <item>
    <tags>'hipchat'</tags>
    <spec>'hipchat'</spec>
    <description>
      <p>Add handy commands for hipchat</p>
    </description>
  </item>
</plugin>;

function jumpTo(contents, elem) {
  elem.click();
  setTimeout(focusChat, 1000);
}

function focusChat() {
  document.getElementsByClassName('chat_display')[0].focus();
}

commands.addUserCommand(
  ['hipchatjumptonext'],
  'Jump to the next tab',
  function(){
    let contents=gBrowser.selectedBrowser.contentDocument;
    let target=contents.getElementsByClassName('selected')[0].nextSibling || contents.getElementById('tabs').firstChild;
    jumpTo(contents, target.firstChild);
  }
);
commands.addUserCommand(
  ['hipchatjumptoprevious'],
  'Jump to the previous tab',
  function(){
    let contents=gBrowser.selectedBrowser.contentDocument;
    let target=contents.getElementsByClassName('selected')[0].previousSibling || contents.getElementById('tabs').lastChild;
    jumpTo(contents, target.firstChild);
  }
);
commands.addUserCommand(
  ['hipchatjumptoalert'],
  'Jump to the next highligthed tab',
  function(){
    let contents=gBrowser.selectedBrowser.contentDocument;
    let targets=contents.getElementsByClassName('alert');
    if(targets.length<1){
      return false;
    }
    let elem = targets[0].firstChild;
    jumpTo(contents, elem);
  }
);
