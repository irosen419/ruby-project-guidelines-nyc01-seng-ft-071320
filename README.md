# DONATION NATION: AUSTRIALIA #

# Short Description 
Our app aims to raise awareness on threatened species in Australia. Users are able to interact with various animals and charities. Users will be able to search animals via species or threatened category and add them to their own ‘favorite’ list. Users are also able to search charities to make a donation in honor of a specific animal. 

# Install Instructions
1) Run 'bundle install'
2) Migrate all tables by typing in 'rake db:migrate' into your terminal
3) Run seed database file by typing in 'rake db:seed' to get all animal and charity data.
        a) Animal.get_database_animals_gov_au - this seeds all animals from the QLD Wildlife API
        b) Charity.get_charity - this seeds all the charities from the QLD Wildlife API
        c) Donation.create_donations - this seeds numerous placeholder donations
        d) Favorite.create_favs - this seeds numerous placeholder favorites
4) Alright! All the data is loaded. Please run the run file by typing in 'ruby bin/run.rb'
5) Please interact with the application using the command line.
6) Follow application instructions and have fun!

# Contributor’s Guideline
1) Sign up or log in (will need a correct password) or browse as a Guest.
2) In the main menu, you will be 9 options to navigate from.
        a) All user input are not case sensitive.
        b) Type 'exit' to leave the application. 
        c) Type 'logout' to logout and change user.
        d) Options are selected by typing in the name of option or number.
3) Use 'add' to add an animal to your favorite animal list.
4) Use 'delete' to remove an animal from your favorite list, but I promise they will be sad to be removed.
5) Use 'donate' to look at the charities in Australia that will benefit these endangered animals in Australia.
        a) This is our Donations Menu. We have nearly 70 charities. 
        b) Use 'donate' to find and donate to a charity of your choice.
        c) Use 'list' to look at our list of charities.
        d) Use 'rankings' to look at our top donors
        e) User 'view' to look at all the donations you have given to our charities
6) Use 'list' to browse through our nearly 400 Animals. You won't know whom will show up on the list. 
7) Use 'logout' to logout of your account and sign in to a new account. If you are just browsing, you are going to need to update your account infomration to keep your favorites! Think about the poor animals.
8) Use 'rankings' to view different animal rankings. 
        a) You can view top 5 favorited animals or view a random selection of 5 non-favorited animals. Those non-favorited animals need your love!
9) Use 'search' to search for new animals to add to your list of favorites.
        a) You can search by partial/full common name or category (Vulnerable, Endangered, Critically endangered, etc...)
10) Use 'update' to make updates to user info such as changing user info or deleting your account.


# Link for license for code
 
