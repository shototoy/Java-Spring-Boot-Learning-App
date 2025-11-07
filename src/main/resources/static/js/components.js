document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('[data-subject]').forEach(el => {
        const subject = el.dataset.subject;
        const config = SUBJECTS[subject];
        
        if (!config) return;
        
        const icon = el.querySelector('.subject-icon');
        if (icon) icon.textContent = config.icon;
        
        if (el.classList.contains('subject-card')) {
            el.style.borderColor = config.color;
            el.style.background = config.bg;
        }
        
        const btn = el.querySelector('.btn');
        if (btn) btn.style.background = config.color;
        
        const header = el.querySelector('h3, h4');
        if (header) header.style.color = config.color;
    });
});
