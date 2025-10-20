---
layout: default
title: Home
permalink: /

---

<style>
/* Page-scoped quadrant grid for the home page */
.quadrant-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 1fr 1fr;
  gap: 1rem;
  max-width: 1100px;
  margin: 2rem auto;
  padding: 0.5rem;
}
.quadrant {
  background: #ffffff;
  border-radius: 8px;
  padding: 1.25rem;
  box-shadow: 0 6px 18px rgba(20,20,20,0.06);
  min-height: 220px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.quadrant h2 { margin-top: 0; margin-bottom: 0.5rem; }
.quadrant p { margin: 0 0 1rem 0; color: #333; }
.quad-cta { display:inline-block; padding: 0.5rem 0.8rem; background:#0366d6; color:#fff; border-radius:6px; text-decoration:none; }
.quadrant .quad-img { width: 72px; height: 72px; display:block; margin-bottom: 0.5rem; }

@media (max-width: 760px) {
  .quadrant-grid { grid-template-columns: 1fr; }
}
</style>

<div class="quadrant-grid">
  <section class="quadrant" aria-labelledby="about-title">
    <div>
      <img class="quad-img" src="/assets/img/about.svg" alt="About" />
      <h2 id="about-title">About</h2>
      <p>A short introduction and my professional background. For a fuller biography and achievements, see the About page.</p>
    </div>
    <div>
      <a class="quad-cta" href="/aboutme/">Read About Me</a>
    </div>
  </section>

  <section class="quadrant" aria-labelledby="knowledge-title">
    <div>
      <img class="quad-img" src="/assets/img/knowledge.svg" alt="Knowledge" />
      <h2 id="knowledge-title">Knowledge</h2>
      <p>Collected notes, guides, and reference material. Includes extracted content from documents and topic pages.</p>
    </div>
    <div>
      <a class="quad-cta" href="/knowledge/">Browse Knowledge</a>
    </div>
  </section>

  <section class="quadrant" aria-labelledby="dar-title">
    <div>
      <img class="quad-img" src="/assets/img/coming-soon.svg" alt="Coming soon" />
      <h2 id="dar-title">Coming Soon</h2>
      <p>I'm still building out this revamped technical portfolio.</p>
    </div>
    <div>
      <a class="quad-cta" href="/knowledge/evaluation/DAR.md">Open DAR Method</a>
    </div>
  </section>

  <section class="quadrant" aria-labelledby="contact-title">
    <div>
      <img class="quad-img" src="/assets/img/contact.svg" alt="Contact" />
      <h2 id="contact-title">Contact</h2>
      <p>Questions, contributions, or files to convert — get in touch or open an Issue in this repo.</p>
    </div>
    <div>
      <a class="quad-cta" href="mailto:you@example.com">Contact via Email</a>
    </div>
  </section>
</div>