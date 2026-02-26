import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  // This tells Stimulus to expect the Document ID from the HTML!
  static values = { documentId: Number, pageId: Number } 

  dropPin(event) {
    // Prevent dropping multiple new pins if you haven't saved the current one
    if (document.getElementById("new-pin-form")) return;

    const rect = this.containerTarget.getBoundingClientRect()
    const x = event.clientX - rect.left
    const y = event.clientY - rect.top
    const xPercent = (x / rect.width) * 100
    const yPercent = (y / rect.height) * 100

    // 1. Create a wrapper for our pin and form
    const pinWrapper = document.createElement("div")
    pinWrapper.id = "new-pin-form"
    pinWrapper.style.position = "absolute"
    pinWrapper.style.left = `${xPercent}%`
    pinWrapper.style.top = `${yPercent}%`
    pinWrapper.style.zIndex = "50"

    pinWrapper.addEventListener("click", (e) => e.stopPropagation());

    // 2. We use a little template literal to build an HTML form.
    // We also grab the CSRF token, which Rails requires for security.
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    
    const formHtml = `
      <div style="transform: translate(-50%, -100%); text-align: left;">
        <div style="font-size: 24px; text-align: center; margin-bottom: 5px;">📍</div>
        <div style="background: white; padding: 12px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.2); width: 250px; border: 1px solid #ddd;">
          
          <form action="/pages/${this.pageIdValue}/pins" method="POST" data-turbo="false">
            <input type="hidden" name="authenticity_token" value="${csrfToken}">
            <input type="hidden" name="x_coordinate" value="${xPercent}">
            <input type="hidden" name="y_coordinate" value="${yPercent}">
            
            <textarea name="body" placeholder="Write a comment..." required style="width: 100%; box-sizing: border-box; padding: 8px; margin-bottom: 8px; border-radius: 4px; border: 1px solid #ccc; font-family: sans-serif;"></textarea>
            
            <div style="display: flex; justify-content: space-between;">
              <button type="button" onclick="document.getElementById('new-pin-form').remove()" style="background: #f1f1f1; border: 1px solid #ccc; padding: 6px 12px; border-radius: 4px; cursor: pointer;">Cancel</button>
              <button type="submit" style="background: #e91e63; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-weight: bold;">Save Pin</button>
            </div>
          </form>

        </div>
      </div>
    `;

    pinWrapper.innerHTML = formHtml;

    // 3. Drop the form onto the image!
    this.containerTarget.appendChild(pinWrapper)
  }
}