namespace :docs do
  task :build do
    exec('bundle exec rspec spec/requests/api/v1 -f Dox::Formatter --order defined --tag dox --out docs.md')
  end
  task :render do
    exec('aglio -i docs.md -o ./public/index.html')
  end
end
