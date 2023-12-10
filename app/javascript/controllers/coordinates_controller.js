import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="coordinates"
export default class extends Controller {
  connect() {
    this.listen();
  }

  listen() {
    this.listen__use_new_city_checkbox();
  }

  listen__use_new_city_checkbox() {
    // "use new city" checkbox submit request on change
    document.querySelector('#use_new_city').addEventListener('change', async (event) => {
      const url = document.querySelector('#use_new_city').checked ? 'use_new_city' : 'use_existing_city';
      const request = new FetchRequest('post', url, { responseKind: "turbo-stream" });
      const response = await request.perform();
      if (response.ok) {
        console.log(response);
        console.log(response.text);
      }
    });
  }
}
