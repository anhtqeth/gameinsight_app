# Game Info Web App
[Game Insight](https://gameinsight.herokuapp.com/en)

This is a Web Application display details of video games

# PURPOSE
- Integrate with a headless CMS for authors and fans to write content on their favorite game
- Integrate with a forum system to establish community
- To have established a place for local audience to participate and discuss their favorite video games. 
- This is intended to be translated to local language and managed by editor of the current country. 

# FEATURES

- Showing most popular games base on platform (Switch/PS4/Xbox) [Home Page](https://gameinsight.herokuapp.com/en)
- Discover Popular Games base on genres [Discover](https://gameinsight.herokuapp.com/games/discover?locale=en)
- Discover Popular Games base on platforms [PS4 Games](https://gameinsight.herokuapp.com/en/platforms/playstation-4)
- Showing upcoming release with a countdown to the release date. [Count Down](https://gameinsight.herokuapp.com/games/countdown?locale=en)
- Showing news sources from various popular gaming press [News Page](https://gameinsight.herokuapp.com/en/news)
- Showing Games Information (Release Date, Platforms, Screenshots/ Videos News...) For almost any games with a combination of own database and result from API Services [Games Search](https://gameinsight.herokuapp.com/en/search?utf8=%E2%9C%93&name=Xenoblade+Chronicles)

# Some Technical Notes
- This web app retrieve data from API services (RESTful API) and format it to save to a PostgreSQL database. 
- Redis is used to store seasonal data (Popular Games for a time period...) and is updated daily, weekly depend on the content types (Video Games News url & info are refreshed every 12 hours...)
- A Scheduler was setup (Sidekiq) to occasionally fetch news from other sources. 
- It is also setup to be able to call to AWS Translation service for content Translation. 
- A Headless CMS was used (Contentful) is already setup for author to create their content on a CMS system. 

### INSTALLATION

This source is currently only for references. 
A demo of the app is currently live [here](https://gameinsight.herokuapp.com/en)

### CODE CONVENTION

- [Ruby Styles Guides](https://github.com/rubocop-hq/ruby-style-guide)
I followed this popular Ruby style guides from Git.


## Deployment

- App is currently deployed to Heroku

## Built With

* [Rails 5.2](https://guides.rubyonrails.org/5_2_release_notes.html)
* [Bootstrap 4.3.1](https://getbootstrap.com/docs/4.3/getting-started/introduction/)

## Authors

* **Coding Enthusiast** - *Initial work*
