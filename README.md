## Swoonatra - Sinatra MVC Boiler Plate  

*A boiler plate which can be used to quickly spin-up Sinatra web-framework apps.*  
By default, this boiler plate comes loaded with the [Flat-UI CSS Theme](designmodo.github.io/Flat-UI/‎).

---

The baseline for this repository comes from a very awesome person:

- **[Ratpack](https://github.com/ashleygwilliams/ratpack)** by [Ashley Williams](www.github.com/ashleygwilliams)

Let me know if you have any suggestions via comments / pull request!

### Information and Resources

Here is general information and resources to be used with the boilerplate:

#### Up and Running

`git clone` the repository and `rm -rf .git` folder. `git init` folder, and then:

1. `bundle install`
2. `rackup`
3. visit `localhost:9292`

#### Security and Authentication

- Rename `config/authentication.example.rb` to `config/authentication.rb`
- Add your API and authentication tokens etc. to `config/authentication.rb`

#### Gemfile

Here are the gems included with this boiler plate:

**Framework**  

- [sinatra](http://www.sinatrarb.com/)
- [sinatra-contrib](https://github.com/sinatra/sinatra-contrib)
- [activerecord](http://guides.rubyonrails.org/active_record_querying.html)
- [sinatra-activerecord](https://github.com/bmizerany/sinatra-activerecord)
- [sqlite3](https://github.com/luislavena/sqlite3-ruby)
- [rake](http://rake.rubyforge.org/)

---

**Debug**  

- [better_errors](https://github.com/charliesome/better_errors)
- [binding_of_caller](https://github.com/banister/binding_of_caller)
- [pry-debugger](https://github.com/nixme/pry-debugger)

**Development**  

- [tux](https://github.com/cldwalker/tux)


**Test**

- [capybara](www.test.com)
- [factory_girl](www.test.com)
- [rspec](www.test.com)