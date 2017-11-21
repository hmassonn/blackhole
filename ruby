\curl -sSL https://get.rvm.io | bash -s stable
rvm list known
rvm install ruby-2.4.0
/bin/zsh --login
rvm use ruby-2.4.0 --default
gem install rails

rails server
rails console





bah a priori t as besoin de rien pour lancer le setup
tu set ta version locale de ruby pour l app a la version 2.4
puis tu roules bundle install
rails db:create
rails db:migrate
et t es all good
si tu veux des datas d exemple rails db:seed
a la base je faisais du full test mais en fait contrainte de temps donc je vais les ecrires apres avoir mis une v0 en ligne 
surtout que l interface principale c est juste du js et de l ajax, donc faut utiliser selenium ou un truc du genre, jamais fait, et delais trop court
