document.querySelector('.dropdown').addEventListener('focusin', event => {
  document.querySelector('.dropdown-menu').classList.add('show')
})

document.querySelector('.dropdown').addEventListener('focusout', event => {
  setTimeout(() => {
    document.querySelector('.dropdown-menu').classList.remove('show')
  }, 500)
})
