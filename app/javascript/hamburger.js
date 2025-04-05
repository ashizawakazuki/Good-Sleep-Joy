document.addEventListener('turbo:load', () => {
const btn =  document.getElementById('hamburger');
const xmark =  document.getElementById('xmark');
const content =  document.getElementById('humburger-content');

btn.addEventListener('click', () => {
    btn.classList.add('hidden');
    xmark.classList.remove('hidden');
    content.classList.toggle('hidden');
});

xmark.addEventListener('click', () => {
    xmark.classList.add('hidden');
    btn.classList.remove('hidden');
    content.classList.toggle('hidden');
});
});