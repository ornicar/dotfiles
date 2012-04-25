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
    <spec>:hipchatjumptoalert</spec>
    <description>
      <p>Jump to the next highligthed tab</p>
    </description>
  </item>
</plugin>;

function jumpTo(contents, elem) {
  let evt=contents.createEvent("MouseEvents");
  evt.initMouseEvent(
    'click',
    true, // canBubble
    true, // cancelable
    window, // view
    0, // detail
    0, // screenX
    0, // screenY
    0, // clientX
    0, // clientY
    false, // ctrlKey
    false, // altKey
    false, // shiftKey
    false, // metaKey
    0, // button
    null //relatedTarget
  ); 
  elem.dispatchEvent(evt);
}

commands.addUserCommand(
  ['hipchatjumptonext'],
  'Jump to the next tab',
  function(){
    let contents=gBrowser.selectedBrowser.contentDocument;
    let targets=contents.getElementsByClassName('selected');
    if(targets.length<1){
      return false;
    }
    let elem = targets[0].nextSibling.firstChild;
    jumpTo(contents, elem);
  }
);
commands.addUserCommand(
  ['hipchatjumptoprevious'],
  'Jump to the previous tab',
  function(){
    let contents=gBrowser.selectedBrowser.contentDocument;
    let targets=contents.getElementsByClassName('selected');
    if(targets.length<1){
      return false;
    }
    let elem = targets[0].previousSibling.firstChild;
    jumpTo(contents, elem);
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
