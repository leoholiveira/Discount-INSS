import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="proponents"
export default class extends Controller {
  static targets = [ "formInput", "discountInput", "address", "neighborhood", "state", "city", "zipcode" ]

  connect() {
    this.calculateInss();
  }

  calculateInss() {
    let value = this.formInputTarget.value;
    fetch('/proponents/calculate_inss?salary=' + value)
      .then(response => response.json())
      .then(data => {
        this.discountInputTarget.value = data.discount
        console.log(data.discount)
      });
  }

  searchZipcode() {
    let value = this.zipcodeTarget.value;
    if (value.length == 8) {
      fetch(`https://viacep.com.br/ws/${value}/json/`)
      .then(response => response.json())
      .then(data => {
        if(data.cep !== undefined) {
          this.addressTarget.value = data.logradouro;
          this.neighborhoodTarget.value = data.bairro;
          this.stateTarget.value = data.uf;
          this.cityTarget.value = data.localidade;
        }
      });
    }
    
  }



}