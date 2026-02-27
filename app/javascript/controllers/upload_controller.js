import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {
  static targets = [ "input" ]

  // Stops the browser from just opening the image in a new tab when you drag it over
  prevent(event) {
    event.preventDefault()
  }

  // Clicks the hidden file input when they click "Browse Files"
  triggerClick(event) {
    event.preventDefault()
    this.inputTarget.click()
  }

  // Automatically submits the form as soon as a file is selected/dropped/pasted
  submit() {
    this.inputTarget.closest("form").submit()
  }

  // Handle Drag & Drop
  drop(event) {
    event.preventDefault()
    let files = event.dataTransfer.files
    if (files.length > 0) {
      this.inputTarget.files = files
      this.submit()
    }
  }

  // Handle Ctrl+V / Cmd+V anywhere on the page
  paste(event) {
    // Don't intercept paste if they are typing inside the URL text box!
    if (event.target.tagName === 'INPUT' && event.target.type === 'text') return;

    let items = (event.clipboardData || event.originalEvent.clipboardData).items;
    for (let index in items) {
      let item = items[index];
      if (item.kind === 'file') {
        let blob = item.getAsFile();
        
        // We have to use a DataTransfer object to assign a blob to an HTML file input
        let dataTransfer = new DataTransfer();
        dataTransfer.items.add(blob);
        this.inputTarget.files = dataTransfer.files;
        
        this.submit();
      }
    }
  }
}
