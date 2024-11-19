document.addEventListener('DOMContentLoaded', function () {
  const freightForm = document.getElementById('freight-form');

  if (freightForm) {
    freightForm.addEventListener('ajax:success', function (event) {
      const [data, _status, _xhr] = event.detail;

      // Atualizar o valor do frete na interface
      const freightValueDiv = document.getElementById('freight-value');
      const totalValueDiv = document.getElementById('total-value');

      if (data.freight_value) {
        // Atualiza o valor do frete
        freightValueDiv.innerHTML = `<p>Frete: R$ ${data.freight_value.toFixed(2)}</p>`;

        // Atualiza o valor total (produto + frete)
        const total = data.freight_value + parseFloat(document.getElementById('cart-total').innerText.replace('R$', '').trim());
        totalValueDiv.innerHTML = `<p>Total: R$ ${total.toFixed(2)}</p>`;
      } else {
        freightValueDiv.innerHTML = '<p>Erro ao calcular o frete.</p>';
        totalValueDiv.innerHTML = '';
      }
    });

    freightForm.addEventListener('ajax:error', function (event) {
      const [data, _status, _xhr] = event.detail;
      alert(`Erro ao calcular o frete: ${data.error}`);
    });
  }
});
