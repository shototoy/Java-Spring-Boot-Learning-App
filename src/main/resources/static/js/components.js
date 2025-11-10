document.addEventListener('DOMContentLoaded', function() {
    const subjectLabels = document.querySelectorAll('.subject-label');
    subjectLabels.forEach(label => {
        const subject = label.textContent.trim().toLowerCase();
        if (subject === 'math' || subject === 'mathematics') {
            label.setAttribute('data-subject', 'math');
        } else if (subject === 'english') {
            label.setAttribute('data-subject', 'english');
        } else if (subject === 'science') {
            label.setAttribute('data-subject', 'science');
        }
    });
    const cards = document.querySelectorAll('.card.clickable');
    cards.forEach(card => {
        card.addEventListener('click', function(e) {
            if (e.target.tagName !== 'A' && e.target.tagName !== 'BUTTON') {
                const link = card.querySelector('a.btn');
                if (link) {
                    link.click();
                }
            }
        });
    });
});