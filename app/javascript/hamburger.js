// turbo:loadにしておくと、turboでのページ遷移時でも実行されるようになる
// turboはページ全体をリロードせず、必要な部分だけ書き換えて、画面遷移を早くする仕組み（例えばヘッダーは残してbodyの部分だけ切り替えたり）
document.addEventListener('turbo:load', () => {
  const btn =  document.getElementById('hamburger');
  const xmark =  document.getElementById('xmark');
  const content =  document.getElementById('hamburger-content');
  
  // if文で定数（要素）があるときのみイベントを発生させる
  if (btn && xmark && content) {
    // クリック時にイベントを発生させる
    btn.addEventListener('click', () => {
      // btnに入れた要素のクラスにhiddenというクラスを追加して隠している
      btn.classList.add('hidden');
      // xmarkに入れた要素のクラスのhiddenというクラスを削除している
      xmark.classList.remove('hidden');
      // contentに入れた要素のクラスのhiddenというクラスを切り替えている
      // hiddenがついてなければ追加（非表示）、hiddenがついてたら削除（表示）
      content.classList.toggle('hidden');
    });

    xmark.addEventListener('click', () => {
      // xmarkに入れた要素のクラスにhiddenというクラスを追加して隠している
      xmark.classList.add('hidden');
      // btnに入れた要素のクラスのhiddenというクラスを削除している
      btn.classList.remove('hidden');
      // contentに入れた要素のクラスのhiddenというクラスを切り替えている
      // hiddenがついてなければ追加（非表示）、hiddenがついてたら削除（表示）
      content.classList.toggle('hidden');
    });
  };
});