# Breaking News

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app uses the [News API](https://newsapi.org/docs/get-started) to display breaking news headlines.

### App Evaluation

- **Category:** News
- **Mobile:** Mobile is ideal for real-time alerts, location-based news delivery, and quick browsing.
- **Story:** Keeps users informed with fast, relevant, and minimal-bias news. Combats news fatigue by filtering out low-impact headlines and clickbait.  
- **Market:** News readers, professionals, travelers, and anyone who wants to stay informed without scrolling endlessly. Could target younger users turned off by traditional media. 
- **Habit:** Users open the app multiple times daily or rely on push notifications for top stories. Customization and urgency drive repeated engagement. 
- **Scope:** V1 could launch with top curated stories and filtering by categories. V2 adds location-based feeds and user-defined keywords. V3 could introduce personalization based on reading behavior and sentiment filters.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* As a user, I want to see a list of the latest breaking news headlines as soon as I open the app.
* As a user, I want to filter news by categories like Technology, Sports, Entertainment, etc.
* As a user, I want to read a description and have a link to the full article by tapping on a headline.
* As a user, I want to mark articles as "Read" or "Readlist"
* As a user, I want to see a list of my read articles.
* As a user, I want to see a list of my saved for later (readlist) articles.
* As a user, I want the app to load quickly and display content in a clean, minimal UI.

**Optional Nice-to-have Stories**

* As a user, I want to search for articles.
* As a user, I want to personalize my news feed based on selected interests or topics.
* As a user, I want to view local news based on my current location.
* As a user, I want to receive daily digests or summaries of top stories.
* As a user, I want to share articles easily via social media or messaging apps.
* As a user, I want to receive push notifications for major breaking news stories.

### 2. Screen Archetypes

Breaking News View
* As a user, I want to see a list of the latest breaking news headlines as soon as I open the app.
* As a user, I want to filter news by categories like Technology, Sports, Entertainment, etc.

News Details View
* As a user, I want to read a description and have a link to the full article by tapping on a headline.
* As a user, I want to mark articles as "read/favorites" or "saved for later."

Read View
* As a user, I want to see a list of my read articles.

Readlist View
* As a user, I want to see a list of my saved for later articles.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* News
* Read
* Readlist

**Flow Navigation** (Screen to Screen)

Breaking News View
* click on list item to navigate to News Details
* click on Read tab to navigate to Read View
* click on Readlist tab to navigate to Readlist View

News Details View
* click on News tab to navigate to Breaking News View
* click on News tab to navigate to Breaking News View
* click on Readlist tab to navigate to Readlist View
  
Read View
* click on list item to navigate to News Details
* click on News tab to navigate to Breaking News View
* click on Readlist tab to navigate to Readlist View

Readlist View
* click on list item to navigate to News Details
* click on News tab to navigate to Breaking News View
* click on Read tab to navigate to Read View

## Wireframes
<img src="./breaking-news-wireframe.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
