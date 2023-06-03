---
layout: page
permalink: /photography
---

<div class="photo-grid">
  <div class="photo-grid-container">
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_3.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.13_3.jpg" alt="Photo from June 13, 2025">
    </div>
    <div class="photo-item landscape">
      <img src="/assets/images/2025.06.13_4.jpg" alt="Photo from June 13, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_1.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item">
      <img src="/assets/images/2025.06.14_2.jpg" alt="Photo from June 14, 2025">
    </div>
    <div class="photo-item landscape">
      <img src="/assets/images/2025.06.13_2.jpg" alt="Photo from June 13, 2025">
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
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
  padding: 1rem;
}

.photo-item {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  aspect-ratio: auto;
}

.photo-item.landscape {
  grid-column: 1 / -1;
  max-width: 100%;
}

.photo-item:hover {
  transform: scale(1.02);
}

.photo-item img {
  width: 100%;
  height: auto;
  display: block;
  object-fit: contain;
}

@media (max-width: 768px) {
  .photo-grid-container {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  }
}
</style>