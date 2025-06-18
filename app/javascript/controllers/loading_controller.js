import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["spinner"] 
  
  // connectはstimulusによるメソッドで「data-controller」で囲った要素が読み込まれた時に自動で実行される
  connect() {
    this.hide()
    // ブラウザバックでもローディングアニメーションが表示されないよう設定
    window.addEventListener("pageshow", () => {
        this.hide();
      });
    }
  
  
  // 「hidden」を取り除き、スピナーを表示
  show() {
    this.spinnerTarget.classList.remove("hidden")
  }
  
  // classListでhideenをHTML要素に追加し、スピナーを非表示にする
  hide() {
    this.spinnerTarget.classList.add("hidden")
  }
}
