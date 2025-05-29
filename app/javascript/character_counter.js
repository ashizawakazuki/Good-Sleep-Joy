document.addEventListener('DOMContentLoaded', function() {
  // 入力欄の要素を取得
  const inputText = document.getElementById('inputText');

  // 入力欄にキーを押したときのイベントを設定
  inputText.addEventListener('keyup', keyUp, false);

  // キーが押されたときの処理
  function keyUp() {
    // 入力された文字列を取得
    let str = inputText.value;

    // 改行を取り除く
    str = str.replace(/\r?\n/g, '');

    // 残りの文字数を計算（最大100文字）
    let num = 100 - str.length;

    // 文字数を表示する部分の要素を取得
    const characterCount = document.getElementById('characterCount');

    // 数字を表示
    characterCount.textContent = num;

    // ラップ部分の<p>タグを取得して色を変える
    const characterCountwrap = document.getElementById('characterCountwrap');

    if (num >= 0) {
      characterCountwrap.style.color = 'black';
    } else {
      characterCountwrap.style.color = 'red';
    }
  }
});