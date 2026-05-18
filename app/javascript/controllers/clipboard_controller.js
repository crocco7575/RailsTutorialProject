import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }

  copy() {
    navigator.clipboard.writeText(this.textValue)
    // Optional: Change the button text for 2 seconds
    const originalText = event.target.innerText
    event.target.innerText = "Copied!"

    setTimeout(() => {
    event.target.innerText = originalText
    }, 2000)
}
}

