import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="user"
export default class extends Controller {
  connect() {
    this.listen();
  }
  
  listen() {
    this.listen__is_client();
    this.listen__is_service_provider();
  }

  listen__is_client() {
    // placeholder in case 
    // document.querySelector('#is_client').addEventListener('change', async (event) => {});
  }

  // listen on checkbox change
  listen__is_service_provider() {
    document.querySelector('#is-service-provider')?.addEventListener('change', async (event) => {
      const url = document.querySelector('#is-service-provider').checked ? 'is_service_provider' : 'is_not_service_provider';
      const request = new FetchRequest('post', url, { query: { is_client: document.querySelector('#is-client').checked ? 1 : 0 }, responseKind: "turbo-stream" });
      const response = await request.perform();
    });
  }

}
