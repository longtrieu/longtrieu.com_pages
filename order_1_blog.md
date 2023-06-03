---
layout: page
title: "Blog"
permalink: /blog
---

<style>
/* Hide the page title */
.page-title, h1 {
  display: none;
}
</style>

<div class="page-container">
  <div class="blog-posts">
    {% for post in site.posts %}
      <article class="blog-post">
        <div class="post-meta">
          <time class="post-date">{{ post.date | date: "%B %-d, %Y" }}</time>
          {% if post.categories %}
            <span class="post-category">{{ post.categories | first }}</span>
          {% endif %}
        </div>

        <h2 class="post-title">
          <a href="{{ post.url }}">{{ post.title }}</a>
        </h2>

        {% if post.excerpt %}
          <p class="post-excerpt">{{ post.excerpt | strip_html | truncatewords: 30 }}</p>
        {% endif %}

        <div class="post-footer">
          <a href="{{ post.url }}" class="read-more">Read more →</a>
        </div>
      </article>
    {% endfor %}
  </div>

  {% if site.posts.size == 0 %}
    <div class="empty-state">
      <h3>No posts yet</h3>
      <p>Check back soon for new content!</p>
    </div>
  {% endif %}
</div>

<style>
.page-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}



.blog-posts {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.blog-post {
  padding: 2rem;
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
  transition: all 0.3s ease;
  border: 1px solid #f0f0f0;
}

.blog-post:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(0,0,0,0.1);
}

.post-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.post-date {
  color: #666;
  font-size: 0.9rem;
  font-weight: 500;
}

.post-category {
  background: #667eea;
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: 600;
  text-transform: uppercase;
}

.post-title {
  margin: 0 0 1rem 0;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.3;
}

.post-title a {
  color: #333;
  text-decoration: none;
  transition: color 0.3s ease;
}

.post-title a:hover {
  color: #667eea;
}

.post-excerpt {
  color: #666;
  line-height: 1.6;
  margin: 0 0 1.5rem 0;
  font-size: 1rem;
}

.post-footer {
  display: flex;
  justify-content: flex-end;
}

.read-more {
  color: #667eea;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  transition: color 0.3s ease;
}

.read-more:hover {
  color: #764ba2;
}

.empty-state {
  text-align: center;
  padding: 3rem 1rem;
  color: #666;
}

.empty-state h3 {
  margin: 0 0 0.5rem 0;
  color: #333;
}

@media (max-width: 768px) {
  .page-container {
    padding: 1rem;
  }

  .blog-post {
    padding: 1.5rem;
  }

  .post-title {
    font-size: 1.3rem;
  }
}
</style>
