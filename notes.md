#RUBY learning notes

- The entire folder structure can be created using a single command rails install
- Define the version of the gems in Gemfile. >> This is similar to pom.xml, but in a clearer manner

1. Action is defined in controller located in app/controllers
2. Router will determine what action to be perform and pick the controller to be used
3. Router can act like RequestMapping 
4. 


RVM & RUBY & BUNDLE
This need to be installed for single user
sudo rm -rf /etc/rvmrc /etc/profile.d/rvm.sh /usr/local/rvm #Removed all rvm install.
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -L https://get.rvm.io | bash -s stable or \curl -sSL https://get.rvm.io | bash -s stable --ruby






#Setting up SSH for GIT - Bitbucket

I was setting up SSH for Bitbucket. Encounter several issues: Below are the steps I used

1. Follow the instruction to generate SSH key here https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html
2. Copy the content of the .pub key to Bitbucket SSH setting
3. run ssh-agent using eval 'ssh-agent' >> not work 
4. Run eval "$(ssh-agent)" instead
5. Add the private key using this command $ ssh-add ~/.ssh/<private_key_file>
6. Test the connection with $ ssh -T git@bitbucket.org
7. Push code as usual

MUST ADD THE KEY TO THE SSH KEYGEN everytime opening up the Cloud9


##Several things to notes
DB can be created using rails db:migrate (rake in older versions)

Game.where("name = 'Dogfighter: World War 2'").delete_all

##Scafolding Notes

- The app/asset/stylesheets defauly use scaffolds.css for the style of text
- The server log will show explicitly the SQL command whenever we reload the page 
- There are no validation by default when creating objects.

##Heroku Deployment Notes

1. heroku created
2. git push heroku master\

 source <(curl -sL https://cdn.learnenough.com/heroku_install)
 
#Tailing heroku rails log
 heroku logs --tail

For database related, also do the following 
heroku run rails db:migrate


#Rails Generations command
Genegrate code following convention. To cancel follow this:
--Controller
$ rails generate controller StaticPages home help
$ rails destroy  controller StaticPages home help
--Model
$ rails generate model User name:string email:string
$ rails destroy model User
--DB
$ rails db:migrate
$ rails db:rollback

#Need this for testing API until integration test is finally created
require 'net/http'
include GamesApiModule

time_t = Time.current - 6.days
time_t = time.to_time.to_i


ids_array = gamesSearchRequest("Age of Empires")
Called to Game Search Request with parameter: Age of Empires
search " Age of Empires";
=> [327, 55029, 24273, 289, 299, 3017, 9951, 5571, 8220, 21221]
>> 
>> ids_array.paginate
=> [327, 55029, 24273, 289, 299, 3017, 9951, 5571, 8220, 21221]
>> ids_array.paginate(:page =>1, :per_page => 4)
=> [327, 55029, 24273, 289]
>> ids_array.paginate(:page =>2, :per_page => 4)                                                                                                                                                                         
=> [299, 3017, 9951, 5571]
>> ids_array.paginate(:page =>3, :per_page => 4)                                                                                                                                                                         
=> [8220, 21221]

gamesRequest(55090)
gameScreenshotRequest(2984)

game_card_carousel = gamesListProcess(dummy_game_ids)

Rails.cache.delete("2062/game_detail")

game.first["platforms"].map{|x| x["name"]}  
game.first["genres"].map{|x| x["name"]}

3007

gamesSeriesRequest.first['games']
gamesRequest('Yakuza 2')

gameCoverRequest(36550)

#Search API Flow test
game_id_result = gamesSearchRequest('Sekiro')
game_card_result = gamesListProcess(game_id_result)

$ rails g model GameArticle external_id:integer author:string summary:text img:string created_at:date title:string url:string news_source:string





heroku pg:reset DATABASE
heroku run rails db:migrate
heroku run rails db:seed

#Working with PG in developent
sudo yum install postgresql-devel
sudo yum install postgressql- postgresql-server 

rails db:setup

sudo vim /var/lib/pgsql9/data/pg_hba.conf
sudo su - postgres
psql -U postgres
psql -U ethudev
sudo vim /var/lib/pgsql9/data/postgresql.conf
sudo service postgresql restart
rails db:setup
sudo su - postgres
rails db:setup
rails db:migrate

create role ethugamedb with createdb login password '!!Tqa2411'
create user username ethudev password 'password'

follow https://medium.com/@floodfx/setting-up-postgres-on-cloud9-ide-720e5b879154
https://coderwall.com/p/adv71w/basic-vim-commands-for-getting-started
ALTER USER "ec2-user" WITH PASSWORD 'password';



Author.joins("INNER JOIN posts ON posts.author_id = authors.id AND posts.published = 't'")
latest_release = Game.where('first_release_date BETWEEN ? AND ?',min_time,max_time).joins('INNER JOIN platforms ON platforms.game_id = games.id AND platforms.name = ?',platform)

# Cloud9 Startup Command 
$ eval "$(ssh-agent)" #Startup the ssh agent
$ ssh-add ~/.ssh/ruby-cloud9 #Add Bitbucket Itentity

git rev-list --all --count #commit counts

git checkout -b newsfeed-implement
git push -u origin newsfeed-implement

eval "$(ssh-agent)" 
ssh-add ~/.ssh/ruby-cloud9 
source <(curl -sL https://cdn.learnenough.com/heroku_install) #Not sure why I need to do this to push to heroku
sudo service postgresql start
Mailer method canbe used to both user activation and password reset. Think of what can be beneficial to your web application?

#Initial Performance 
Benchmark.measure{gamesListProcess} 16s
=> #<Benchmark::Tms:0x00000003642078 @label="", @real=16.22332866799843, @cstime=0.0, @cutime=0.0, @stime=0.03, @utime=0.18000000000000002, @total=0.21000000000000002>

#This is due to the large volume of array I past in the API RequestMapping

Benchmark.measure{gamesSeriesRequest.first['games']} 0.5s
Benchmark.measure{games_id_array.map {|x|gamesRequest(x).first['name']}} 6.5s
Benchmark.measure{games_id_array.map {|x|gamesRequest(x).first['summary']}}                                                                                                                                                                 
Benchmark.measure{games_id_array.map {|x|gameCoverRequest(x)}} 

Benchmark.measure{gamesSearchRequest} 0.2s
Benchmark.measure{gamesSeriesRequest} 0.4s
Benchmark.measure{gamesRequest(55090)} 0.3s
Benchmark.measure{gameCoverRequest(55090)} 0.3s

game_card_data = games_id_array[0...4].flat_map {|x| [gamesRequest(x).first['name'],gamesRequest(x).first['summary'],gameCoverRequest(x)]}
keys = ['name', 'summary', 'cover'] 
game_cards = game_card_data.each {|x| keys.zip(x).to_h}

1. Reduce the array 
Benchmark.measure{games_id_array[0...4].map {|x|gamesRequest(x).first['name']}}

Benchmark.measure{gamesListProcess} 3s
>> #<Benchmark::Tms:0x00000003af8b30 @label="", @real=3.2014455149983405, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.03999999999999998, @total=0.03999999999999998> 

2. Change NET:HTTP
Benchmark.measure{gamesRequest(55090)} 0.2s
Benchmark.measure{gameCoverRequest(55090)} 0.2s

3. Change Net::HTTP.new('api-v3.igdb.com', 80) to constant

Benchmark.measure{gamesListProcess} 2.7s



# Using HTML5, we can define a site layout with logo, header, footer, and main body content.
# Rails partials are used to place markup in a separate file for convenience.
# CSS allows us to style the site layout based on CSS classes and ids.
# The Bootstrap framework makes it easy to make a nicely designed site quickly.
# Sass and the asset pipeline allow us to eliminate duplication in our CSS while packaging up the results efficiently for production.
# Rails allows us to define custom routing rules, thereby providing named routes.
# Integration tests effectively simulate a browser clicking from page to page.


# REGARDING UNIQUENESS IN DATABASE WITH RUBY WEBSITE
# There’s just one small problem, which is that the Active Record uniqueness validation does not guarantee uniqueness at the database level. Here’s a scenario that explains why:

# Alice signs up for the sample app, with address alice@wonderland.com.
# Alice accidentally clicks on “Submit” twice, sending two requests in quick succession.
# The following sequence occurs: request 1 creates a user in memory that passes validation, request 2 does the same, request 1’s user gets saved, request 2’s user gets saved.
# Result: two user records with the exact same email address, despite the uniqueness validation
# If the above sequence seems implausible, believe me, it isn’t: it can happen on any Rails website with significant traffic (which I once learned the hard way). Luckily, the solution is straightforward to implement:
# we just need to enforce uniqueness at the database level as well as at the model level. Our method is to create a database index on the email column (Box 6.2), 
#and then require that the index be unique.

## LOGIN MECHANISM


