window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const addtaxprice = document.getElementById("add-tax-price");
    addtaxprice.innerHTML = Math.round(priceInput.value * 0.1);
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.round(priceInput.value - Math.round(priceInput.value * 0.1))
  })
});