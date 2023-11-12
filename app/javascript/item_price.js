function item_price() {
  const priceInput = document.getElementById("item-price");

  // 要素が存在するか確認
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
      const addProfitDom = document.getElementById("profit");
      addProfitDom.innerHTML = Math.floor(inputValue - Math.floor(inputValue * 0.1));
    });
  }
}

window.addEventListener('DOMContentLoaded', item_price);
window.addEventListener("turbo:render", item_price);
