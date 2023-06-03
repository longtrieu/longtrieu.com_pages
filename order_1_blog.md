---
layout: page
title: "Blog"
permalink: /blog
---

<ul style="list-style: none;">
  {% for post in site.posts %}
    <li>
      <span style="color:gray">{{ post.date | date: "%B %-d %Y" }}</span>
      <h3>
        <a href="{{ post.url }}">{{ post.title }}</a>
      </h3>
      <br />
    </li>
  {% endfor %}
</ul>
