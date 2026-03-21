import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          this.element.classList.remove("opacity-0", "translate-y-8")
          observer.disconnect()
        }
      },
      { threshold: 0.2 }
    )

    observer.observe(this.element)
  }
}
