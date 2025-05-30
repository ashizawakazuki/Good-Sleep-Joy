document.addEventListener('turbo:load', function() {
  //アイテム投稿（編集）のtitleの文字数カウンター

  //入力フォームをtitleInputに入れている
  const titleInput = document.getElementById('titleInput');
  //入力フォームにユーザーが入力したら、function()以下を実行する（イベントリスナー）
  titleInput.addEventListener('keyup', function() {
  
    //titleInputに入力されている値をvalueで取得
    let str = titleInput.value;
  
    //replaceで第一引数で改行を、第二引数で空文字にしている（改行は文字数にカウントしない）
    str = str.replace(/\r?\n/g, '');
  
    //50からstr(入力された文字数)を引いて、残りの入力可能な文字数をnumに格納
    let num = 50 - str.length;
  
    //文字数表示部分の要素を取得
    const titleCount = document.getElementById('titleCount');
  
    //numに格納されている残りの文字数をセットして新たな数値をtextContextで表示
    titleCount.textContent = num;
  
    //残り文字数表示部分のp要素（全体）を取得
    const titleCountwrap = document.getElementById('titleCountwrap');
  
    //numが0以上の時は文字の色は灰色、マイナスの時は赤にする
    if(num >= 0) {
      titleCountwrap.style.color = 'gray';
    } else {
      titleCountwrap.style.color = 'red';
    }
  });

  
  //アイテム投稿（編集）のbodyの文字数カウンター
  const bodyInput = document.getElementById('bodyInput');

  bodyInput.addEventListener('keyup', function() {
    let str = bodyInput.value;
    str = str.replace(/\r?\n/g, '');
    let num = 1000 - str.length;
    const bodyCount = document.getElementById('bodyCount');
    bodyCount.textContent = num;
    const bodyCountwrap = document.getElementById('bodyCountwrap');

    if(num >= 0) {
      bodyCountwrap.style.color = 'gray'
    } else {
      bodyCountwrap.style.color = 'red'
    }
  });
});