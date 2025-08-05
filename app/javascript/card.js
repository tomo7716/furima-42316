const pay = () => {
  const payjp = Payjp('pk_test_***********************'); // PAY.JPテスト公開鍵
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
        alert('カード情報が正しくありません');
      } else {
        const token = response.id;

        // トークンをフォームに埋め込む
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'order_address[token]');
        tokenInput.setAttribute('value', token);
        form.appendChild(tokenInput);

        // カード情報のDOMを削除（セキュリティのため）
        numberElement.unmount();
        expiryElement.unmount();
        cvcElement.unmount();

        form.submit(); // トークンを含めて送信
      }
    });
  });
};

window.addEventListener('turbo:load', pay);
