// stimulusが用意している「Controller」クラスをここで使うための宣言（必ず書くもの）
import { Controller } from "@hotwired/stimulus"

// ここからstimulusのコントローラの内容を記述するという意味（ここからstimulusコントローラの内容が始まる）
export default class extends Controller {
  // HTMLの「data-loading-target = "spiner"」となっている要素を取得し、このコントローラの中では「this.spinnerTarget」という形で操作できるよう設定
  static targets = ["spinner"] // →「this.spinnerTarget」として使える
  
  // connectはstimulusによるメソッドで「data-controller」で囲った要素が読み込まれた時に自動で実行される
  connect() {
    this.hide()
    // ブラウザバックでもローディングアニメーションが表示されないよう設定
    window.addEventListener("pageshow", () => {
        this.hide();
      });
    }
  
  // ユーザーが「data-action="click->loading#show"」属性のHTML要素をクリックしたら、以下が発動
  // application.html.erbの「data-loading-target="spinner"」属性がある要素の「hidden」を取り除き、スピナーを表示
  // HTMLの要素の中のclass~をjsから操作操作するための
  show() {
    this.spinnerTarget.classList.remove("hidden")
  }
  
  // classListでhideenをHTML要素に追加し、スピナーを非表示にする
  hide() {
    this.spinnerTarget.classList.add("hidden")
  }
}
