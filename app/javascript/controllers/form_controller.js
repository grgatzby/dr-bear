import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="form"
export default class extends Controller {
  static targets =["result", "kw1", "kw2", "kw3", "kw4", "kw5", "kw6", "kw7", "kw8", "kw9", "kw10"]

  connect(question) {
    console.log("Hello from the form controller")
    console.log(question)

  }

  result(event) {
    // console.log(this.kw1Target.checked)
    // console.log(this.kw2Target.checked)
    // console.log(this.kw3Target.checked)
    // console.log(this.kw4Target.checked)
    // console.log(this.kw5Target.checked)
    // console.log(this.kw6Target.checked)
    const arrayResult = [
      this.kw1Target.checked,
      this.kw2Target.checked,
      this.kw3Target.checked,
      this.kw4Target.checked,
      this.kw5Target.checked,
      this.kw6Target.checked]
    const htmlresult = `<%params[:result] = [${arrayResult}]%>`
    console.log(this.resultTarget)
    this.resultTarget.innerHTML=htmlresult

    }

  }
