---
layout: page
permalink: /photography
---

<div class="photo-grid">
  <div class="photo-grid-container">
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_1.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_6.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_5.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_3.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_2.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_1.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_4.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.21_2.jpg" alt="Photo from February 21, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_6.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_5.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_4.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2026.02.11_3.jpg" alt="Photo from February 11, 2026">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_3.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_2.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_1.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.13_3.jpg" alt="Photo from June 13, 2025">
    </div>
    <div class="photo-item photo-item--placeholder" aria-hidden="true"></div>
    <div class="photo-item landscape">
      <img src="/assets/images/2025.06.13_4.jpg" alt="Photo from June 13, 2025">
    </div>
  </div>
</div>

<style>
.photo-grid {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.photo-grid-container {
  column-count: 4;
  column-gap: 1.5rem;
  column-fill: auto;
  padding: 1rem;
}

.photo-item {
  break-inside: avoid;
  margin-bottom: 1.5rem;
  position: relative;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.photo-item:last-child {
  margin-bottom: 0;
}

.photo-item.landscape {
  column-span: all;
  margin-top: 2rem;
  margin-bottom: 1.5rem;
}

.photo-item:hover {
  transform: scale(1.02);
}

.photo-item--placeholder {
  column-span: all;
  width: calc((100% - 4.5rem) / 4 * 3 + 3rem);
  height: calc(70px - 1.5rem);
  margin-top: -50px;
  margin-left: auto;
  background: #a8a8a8;
  pointer-events: none;
}

.photo-item--placeholder:hover {
  transform: none;
}

.photo-item img {
  width: 100%;
  height: auto;
  display: block;
  object-fit: contain;
}

@media (max-width: 768px) {
  .photo-grid-container {
    column-count: 1;
  }
  .photo-item--placeholder {
    display: none;
  }
}
</style>