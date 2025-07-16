const price = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;

    const profit = inputValue - tax;
    profitDom.innerHTML = profit;
  })
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);

