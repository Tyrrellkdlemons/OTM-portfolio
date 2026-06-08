/* ============================================================
   OTM // PORTFOLIO — interactive layer
   Custom cursor · iframe loader with fallback
   theme/layout switches · reveals · konami
   ============================================================ */
(function () {
  'use strict';

  // Year
  const yr = document.getElementById('yr'); if (yr) yr.textContent = new Date().getFullYear();

  // Custom cursor
  (function () {
    const dot = document.getElementById('cursorDot');
    const ring = document.getElementById('cursorRing');
    if (!dot || !ring || window.matchMedia('(hover: none)').matches) return;
    let mx = 0, my = 0, rx = 0, ry = 0;
    document.addEventListener('mousemove', e => {
      mx = e.clientX; my = e.clientY;
      dot.style.transform = `translate(${mx}px, ${my}px) translate(-50%, -50%)`;
    });
    (function loop() {
      rx += (mx - rx) * 0.15; ry += (my - ry) * 0.15;
      ring.style.transform = `translate(${rx}px, ${ry}px) translate(-50%, -50%)`;
      requestAnimationFrame(loop);
    })();
    document.querySelectorAll('a, button, .project-card, .gadget, .toggle').forEach(el => {
      el.addEventListener('mouseenter', () => ring.classList.add('grow'));
      el.addEventListener('mouseleave', () => ring.classList.remove('grow'));
    });
  })();

  // Scroll progress
  (function () {
    const prog = document.getElementById('scrollProgress');
    if (!prog) return;
    window.addEventListener('scroll', () => {
      const max = document.body.scrollHeight - window.innerHeight;
      prog.style.transform = `scaleX(${Math.min(1, window.scrollY / Math.max(1, max))})`;
    }, { passive: true });
  })();

  // Reveal on scroll
  (function () {
    if (!('IntersectionObserver' in window)) {
      document.querySelectorAll('.reveal').forEach(el => el.classList.add('in')); return;
    }
    const io = new IntersectionObserver(entries => {
      entries.forEach(e => {
        if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
      });
    }, { threshold: 0.15 });
    document.querySelectorAll('.reveal').forEach(el => io.observe(el));
  })();

  // ---------- IFRAME LOADER + FALLBACK ----------
  // STRATEGY: show the styled fallback card immediately (no "LOADING..." purgatory).
  // Try to load the iframe in the background. If it loads successfully with real
  // content, swap to the iframe. If the site blocks framing (X-Frame-Options) or
  // never loads, the fallback stays — no blank cards, no infinite spinners.
  function setupFrame(card) {
    const frame = card.querySelector('.project-frame');
    const fallback = card.querySelector('.project-fallback');
    if (!frame || !fallback) return;

    // Immediately exit the "loading" purgatory and show the fallback.
    card.classList.add('ready');
    fallback.classList.remove('hidden');

    frame.addEventListener('load', () => {
      if (!frame.src || frame.src === 'about:blank') return;
      // Try to detect an X-Frame-Options block. For cross-origin SUCCESS,
      // contentDocument access throws SecurityError. For a BLOCKED frame,
      // contentDocument is readable but body is empty (about:blank).
      let blocked = false;
      try {
        const doc = frame.contentDocument;
        if (doc && (!doc.body || doc.body.children.length === 0)) {
          blocked = true;
        }
      } catch (e) {
        blocked = false; // cross-origin SecurityError = real content
      }
      if (!blocked) {
        frame.classList.add('loaded');
        fallback.classList.add('hidden');
      }
    });

    // Fire the navigation. RAF gives the load listener time to attach.
    const src = frame.dataset.src || frame.getAttribute('src') || '';
    if (src) requestAnimationFrame(() => { frame.src = src; });
  }
  function initFrames() {
    document.querySelectorAll('.project-card').forEach(setupFrame);
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initFrames);
  } else {
    initFrames();
  }

  // ---------- THEME SWITCHER ----------
  document.querySelectorAll('[data-set-theme]').forEach(btn => {
    btn.addEventListener('click', () => {
      const t = btn.dataset.setTheme;
      document.body.setAttribute('data-theme', t);
      document.querySelectorAll('[data-set-theme]').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      try { localStorage.setItem('otm-portfolio-theme', t); } catch (e) {}
    });
  });
  try {
    const savedTheme = localStorage.getItem('otm-portfolio-theme');
    if (savedTheme) {
      document.body.setAttribute('data-theme', savedTheme);
      const btn = document.querySelector(`[data-set-theme="${savedTheme}"]`);
      if (btn) {
        document.querySelectorAll('[data-set-theme]').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
      }
    }
  } catch (e) {}

  // ---------- LAYOUT SWITCHER ----------
  document.querySelectorAll('[data-set-layout]').forEach(btn => {
    btn.addEventListener('click', () => {
      const l = btn.dataset.setLayout;
      document.body.classList.remove('layout-grid', 'layout-list');
      document.body.classList.add('layout-' + l);
      document.querySelectorAll('[data-set-layout]').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
    });
  });

  // ---------- LIVE TOGGLE (auto-reload iframes on a tick) ----------
  const liveToggle = document.getElementById('liveToggle');
  let liveTimer = null;
  if (liveToggle) {
    liveToggle.addEventListener('click', () => {
      const on = liveToggle.classList.toggle('on');
      liveToggle.setAttribute('aria-checked', String(on));
      if (on) {
        liveTimer = setInterval(() => {
          document.querySelectorAll('.project-frame.loaded').forEach(f => {
            const src = f.src; f.src = ''; setTimeout(() => f.src = src, 50);
          });
        }, 60000);
      } else if (liveTimer) {
        clearInterval(liveTimer); liveTimer = null;
      }
    });
  }

  // ---------- SMOOTH SCROLL FOR # LINKS ----------
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const id = a.getAttribute('href');
      if (id.length > 1) {
        const el = document.querySelector(id);
        if (el) { e.preventDefault(); el.scrollIntoView({ behavior: 'smooth' }); }
      }
    });
  });

  // ---------- KONAMI EASTER EGG ----------
  (function () {
    const seq = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];
    let pos = 0;
    document.addEventListener('keydown', e => {
      if (e.key === seq[pos]) {
        pos++;
        if (pos === seq.length) {
          const t = ['classic', 'terminal', 'street', 'editorial'][Math.floor(Math.random() * 4)];
          document.body.setAttribute('data-theme', t);
          document.body.style.filter = 'hue-rotate(60deg)';
          setTimeout(() => document.body.style.filter = '', 3000);
          pos = 0;
        }
      } else pos = 0;
    });
  })();

})();
