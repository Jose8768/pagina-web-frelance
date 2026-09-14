document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-table-file]').forEach(async (slot) => {
    const file = slot.dataset.tableFile;

    if (!file) {
      return;
    }

    try {
      const response = await fetch(file);

      if (!response.ok) {
        throw new Error(`No se pudo cargar ${file}: ${response.status}`);
      }

      slot.innerHTML = await response.text();
    } catch (error) {
      slot.innerHTML = '<p class="table-error">No se pudo cargar esta sección. Comprueba que la página se esté ejecutando desde un servidor local.</p>';
      console.error(error);
    }
  });

  const form = document.querySelector('.contact-form');

  if (form) {
    form.addEventListener('submit', (event) => {
      const nombre = form.querySelector('input[name="nombre"]');
      const email = form.querySelector('input[name="email"]');
      const mensaje = form.querySelector('textarea[name="mensaje"]');

      if (!nombre || !email || !mensaje || !nombre.value.trim() || !email.value.trim() || !mensaje.value.trim()) {
        event.preventDefault();
        alert('Por favor, completa todos los campos antes de enviar.');
      }
    });
  }
});
