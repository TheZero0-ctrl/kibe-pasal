import { Controller } from "@hotwired/stimulus"
import { FileUpload } from "../helpers/file_upload"


// Connects to data-controller="image-upload"
export default class extends Controller {
  static targets = [
    "preview",
    "cta",
    "progress",
    "remove",
    "fileInput",
    "hiddenInput"
  ]

  static values = {
    blobUrlTemplate: String
  }

  connect() {
    if (this.previewTarget.getAttribute("src")) {
      this.setState("image_set")
    } else {
      this.setState("no_image")
    }
  }

  upload(event) {
    let file = event.target.files[0]
    new FileUpload(file, event.target.dataset.directUploadUrl, this)
        .start()
  }

  remove() {
    this.previewTarget.removeAttribute("src")
    this.fileInputTarget.value = ""
    this.hiddenInputTarget.value = ""
    this.setState("no_image")
  }

  // Private

  setState(state) {
    switch(state) {
      case "no_image":
        this.ctaTarget.classList.remove("hidden")
        this.removeTarget.classList.add("hidden")
        this.progressTarget.classList.add("hidden")
        this.fileInputTarget.disabled = false
        break
      case "uploading":
        this.ctaTarget.classList.add("hidden")
        this.removeTarget.classList.add("hidden")
        this.progressTarget.classList.remove("hidden")
        break
      case "image_set":
        this.ctaTarget.classList.add("hidden")
        this.removeTarget.classList.remove("hidden")
        this.progressTarget.classList.add("hidden")
        this.fileInputTarget.disabled = true
        break
    }
  }

  // File Upload delegate
  setFileUploadProgress(progress) {
    this.progressTarget.value = progress
  }

  fileUploadDidStart(upload) {
    this.setState("uploading")
  }


  fileUploadDidComplete(error, attributes) {
    if (error) {
      this.setState("no_image")
      return
    }

    let imageUrl = this.blobUrlTemplateValue
      .replace(":signed_id", attributes.signed_id)
      .replace(":filename", encodeURIComponent(attributes.filename))

    this.previewTarget.setAttribute("src", imageUrl)
    this.hiddenInputTarget.value = attributes.signed_id

    this.setState("image_set")
  }
}
