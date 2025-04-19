import { Application } from "@hotwired/stimulus"

// autocomplete実装時に追加
import { Autocomplete } from 'stimulus-autocomplete'
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// autocomplete実装時に追加
application.register('autocomplete', Autocomplete)

export { application }