function item_price() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const fee = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue - fee);

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = fee;

    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = profit;
  });
}

window.addEventListener('load', item_price);
window.addEventListener("turbo:render", item_price);
