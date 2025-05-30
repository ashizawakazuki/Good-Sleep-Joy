document.addEventListener('turbo:load', function() {
  function keyUp (){
    //入力された値を取得
    let str = inputText.value;
  
    //replaceで第一引数で改行を、第二引数で空文字にしている（詳しくは説明なかった）
    str = str.replace(/\r?\n/g, '');
  
    //残りの文字数をnumに入れてる
    let num = 50 - str.length;
    console.log(num);
  
    //文字数表示部分の要素を取得
    const characterCount = document.getElementById('characterCount');
  
    //残りの文字数をセットして表示
    characterCount.textContent = num;
  
    //残り文字数表示部分のp要素を取得
    const characterCountwrap = document.getElementById('characterCountwrap');
  
    //0以上の時は文字の色は黒、マイナスの時は赤にする
    if(num >= 0) {
      characterCountwrap.style.color = 'gray';
    } else {
      characterCountwrap.style.color = 'red';
    }
  }
  
  const inputText = document.getElementById('inputText');
  inputText.addEventListener('keyup', keyUp, false);
});