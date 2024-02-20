import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = [ "hidden" ] 
  static targets = [ "menu" ]

  toggle(event) {
    event.stopImmediatePropagation()
    this.dispatch('hide')
    this.menuTarget.classList.toggle('hidden')
  }

  hide() {
    this.menuTarget.classList.add('hidden')
  }
}

