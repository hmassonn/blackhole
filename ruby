\curl -sSL https://get.rvm.io | bash -s stable
rvm list known
rvm install ruby-2.4.0
/bin/zsh --login
rvm use ruby-2.4.0 --default
gem install rails

rails server
rails console
