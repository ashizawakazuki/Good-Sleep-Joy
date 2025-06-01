import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["spinner"]
  
  connect() {
    this.hide()
    // ブラウザバックでローディングアニメーションが表示されないよう設定
    window.addEventListener("pageshow", () => {
        this.hide();
      });
    }
  
  show() {
    this.spinnerTarget.classList.remove("hidden")
  }
  
  hide() {
    this.spinnerTarget.classList.add("hidden")
  }
}
