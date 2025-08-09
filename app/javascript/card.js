const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        
        form.submit();
      } else {
        const token = response.id;
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'order_address[token]');
        tokenInput.setAttribute('value', token);
        form.appendChild(tokenInput);

        numberElement.unmount();
        expiryElement.unmount();
        cvcElement.unmount();

        form.submit();
      }
    });
  });
};

window.addEventListener('turbo:load', pay);
window.addEventListener("turbo:render", pay);
