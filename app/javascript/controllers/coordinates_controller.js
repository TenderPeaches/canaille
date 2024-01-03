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
    document.querySelector('.use-new-city').addEventListener('change', async (event) => {
      const url = document.querySelector('.use-new-city').checked ? '/coordinates/use_new_city' : '/coordinates/use_existing_city';
      const request = new FetchRequest('post', url, { responseKind: "turbo-stream", query: { source: window.location.pathname } });
      const response = await request.perform();
    });
  }
}
